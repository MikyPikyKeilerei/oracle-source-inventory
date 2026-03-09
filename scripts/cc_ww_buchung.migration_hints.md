# Migration Hints: cc_ww_buchung → Databricks LDV

Script version: ##.117 (2026-02-25)
Zielplattform: Databricks Lakehouse (Delta Lake)

---

## Section 1.1 / 1.2 – SC-Tagesdaten laden

**Komplexität: HIGH**

### Bronze Tables benötigt
| Oracle Tabelle | Bronze Delta Table | Hinweis |
|---|---|---|
| sc_ww_buchung | bronze.sc_ww_buchung | Tagesladung – Partition auf dwh_processdate |
| sc_ww_kundenfirma + _ver | bronze.sc_ww_kundenfirma | LDV Hist: dwh_valid_from/to → START_AT/END_AT |
| sc_ww_likz + _ver | bronze.sc_ww_likz | LDV Hist |
| sc_ww_zahlungskz + _ver | bronze.sc_ww_zahlungskz | LDV Hist |
| sc_ww_mgeinh + _ver | bronze.sc_ww_mgeinh | LDV Hist |
| sc_ww_stationaerkz + _ver | bronze.sc_ww_stationaerkz | LDV Hist |
| cc_firma | silver.cc_firma | Referenz: JOIN via dwh_id → wert |
| cc_artstat | silver.cc_artstat | Referenz: likz → artstat |
| cc_zahlwunsch | silver.cc_zahlwunsch | Referenz: zahlungskz → wert |
| cc_meterware | silver.cc_meterware | Referenz: mgeinh → wert |
| cc_stationaerkz | silver.cc_stationaerkz | Referenz |

### LDV Objekte
- `silver_key.ww_buchung` (SCD1: auftrnr_key + auftrpos + buchdat)
- `silver_hist.sc_kundenfirma` (SCD2: dwh_valid_from/to)
- `silver_hist.sc_likz` (SCD2)
- `silver_hist.sc_zahlungskz` (SCD2)

### Transformationen
| Oracle | Spark/SQL | Flag |
|---|---|---|
| `ansprachen/100` | `ansprachen / 100.0` | scale /100 |
| `DECODE(mgeinh,100,1,NULL)` | `CASE WHEN mgeinh=100 THEN 1 ELSE NULL END` | DECODE→CASE |
| `PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, F_EKVT_TO_PREISFIRMA(vtgebiet), &termin)` | `udf_get_landeswaehrung(komwarenwert/100.0, vtgebiet_zu_preisfirma(vtgebiet), process_date)` | **UDF notwendig** |
| `PKG_IM_VERTRIEBSGEBIET.F_EKVT_MIT_SAMMELKONTO(vtgebiet)` | `udf_is_sammelkonto(vtgebiet)` oder Lookup-Tabelle | **UDF notwendig** |
| `TRUNC(dwh_processdate) = TRUNC(&termin)` | `date(dwh_processdate) = date(process_date)` | Datumsfilter |
| `REPLACE(auftragsnr, '.', '')` | `regexp_replace(auftragsnr, '\\.', '')` | Zeichenbereinigung |
| CASE lieferkz (15+ Zweige) | CASE WHEN ... END (1:1 übersetzen) | **Komplex CASE** |

### 1.1 vs. 1.2 Unterschiede
| Spalte | 1.1 Normale Konten | 1.2 Sammelkonten |
|---|---|---|
| Filter | `is_sammelkonto = false` | `is_sammelkonto = true` |
| kontoart | CASE firma IN (22,23..34) THEN 3 | CASE firma IN (29,30,33) THEN 3 |
| lieferkz | Komplex CASE 15 Zweige | NULL |
| verkpreis | ABS(UDF-Berechnung) | NULL |
| *ohnerabattwert | `menge * vkp_fakt` | `CASE vkp_fakt!=0 THEN vkp_fakt ELSE UDF END` |

**Empfehlung:** Beide Sections in einem einzigen Spark-Job mit Branch via `is_sammelkonto`-Flag.

---

## Section 1.3 – OhneRabattWerte Update (Sammelkonten)

**Komplexität: LOW**

### Transformation
```sql
-- Oracle UPDATE
UPDATE clcc_ww_buchung_19 SET
  ansprohnerabattwert = anspr_wert, ...
WHERE F_EKVT_MIT_SAMMELKONTO(ek_vtgebiet) = 1
AND firma NOT IN (28,200,201,202)

-- Spark: direkt in Section 1.2 einbauen, kein separates Update nötig
df_sammel = df_sammel.withColumn("ansprohnerabattwert",
    when(~col("firma").isin(28,200,201,202), col("anspr_wert"))
    .otherwise(col("ansprohnerabattwert")))
```

---

## Section 2 – Cross-Selling Firma

**Komplexität: MEDIUM**

### Bronze Tables
| Oracle | Databricks |
|---|---|
| sc_ww_vertrgebiet_ver | bronze.sc_ww_vertrgebiet (point-in-time: dwh_valid_to = 9999-12-31) |

### Transformation
```python
# Oracle MERGE → Spark join + withColumn
df = df.join(
    sc_vertrgebiet.filter(col("dwh_valid_to") == "9999-12-31"),
    df.ek_vtgebiet == sc_vertrgebiet.vertrgebiet, "left"
).withColumn("firma",
    when(col("ek_vtgebiet").isin("S"), lit(1))
    .when(~col("firma").isin(28,200,201,202), sc_vertrgebiet.firma_cc)  # kein Otto-Marktplatz
    .otherwise(col("firma")))
```

---

## Section 3 – VF-Kennzeichen (vfart)

**Komplexität: HIGH**

### Bronze Tables
| Oracle | Databricks |
|---|---|
| cc_art | silver.cc_art |
| cc_marktkz | silver.cc_marktkz |
| cc_obermarktkz | silver.cc_obermarktkz |

### Transformation
```python
# vfkz = Muss via JOIN cc_art → cc_marktkz → cc_obermarktkz ermittelt werden
# ab ##.71: cc_obermarktkz statt cc_marktkz für VF-KZ-Basis
# VF-KZ 4 (Katalog): KT-Warengruppe 73.6 (sc_im_tgv_wkz_umcod_ver)
```
**Hinweis:** 3 MERGE + 2 UPDATE in Oracle → in Spark als mehrstufige JOIN-Kette realisieren.

---

## Section 6 – Ausstattungs-ID

**Komplexität: HIGH**

### Bronze Tables
| Oracle | Databricks |
|---|---|
| cc_ausstattung_dir | silver.cc_ausstattung_dir |
| cc_buchung | silver.cc_buchung (Rückzugriff auf Altdaten!) |

### Besonderheiten
- 8 Sub-Steps mit mehreren Hilfstabellen (_01, _02, _03, _04, _14)
- Folgebuchungen brauchen Rückzugriff auf historische cc_buchung
- MIN-Funktion bei mehrdeutigen Ausstattungs-IDs
- **Empfehlung:** In Databricks als mehrstufige Windowed-Aggregation lösen

```python
# Ansprachebuchungen: auftrnr_key IS NOT NULL, is_sammelkonto = false
# Ausstattungs-ID: MIN(ausstattung_dir_id) OVER (PARTITION BY artnr, groesse, firma, ...)
df = df.withColumn("ausstattung_dir_id",
    min("ausstattung_dir_id").over(Window.partitionBy("artnr","groesse","firma",...)))
```

---

## Section 8 – ART-ID

**Komplexität: LOW**

```python
# art_id Berechnung
df = df.withColumn("art_id",
    when(col("erslief") != 2, concat(col("umsatzsaison"), col("artikelnr")))
    .otherwise(concat(col("saison"), col("artikelnr"))))

# Validierung gegen cc_art
valid_art_ids = silver_cc_art.filter(col("dwh_valid_to") == "9999-12-31").select("art_id")
df = df.withColumn("art_id",
    when(col("art_id").isin(valid_art_ids), col("art_id")).otherwise(lit(0)))
```

---

## Section 9 – Auftragsdaten

**Komplexität: HIGH**

### Bronze Tables
| Oracle | Databricks |
|---|---|
| sc_ww_auftragkopf_ver | bronze.sc_ww_auftragkopf (LDV Hist: dwh_valid_from/to) |
| sc_ww_auftragpos_ver | bronze.sc_ww_auftragpos (LDV Hist) |
| sc_ww_lieferwunsch + _ver | bronze.sc_ww_lieferwunsch |
| sc_ww_zahlmethode_ver | bronze.sc_ww_zahlmethode |
| sc_ww_zahlwunsch_ver | bronze.sc_ww_zahlwunsch |

### Sonderregeln
```python
# Stationär: auftragsart_cc = 7
df = df.withColumn("auftragsart_cc",
    when(col("ek_vtgebiet") == "S", lit(7))
    .when(col("firma").isin(28,200,201,202), lit(4))  # Otto/Limango = Internet
    .otherwise(col("auftragsart_cc")))

# BETWEEN valid_from AND valid_to → Spark:
auftragkopf = auftragkopf.filter(
    (col("dwh_valid_from") <= process_date) & (col("dwh_valid_to") >= process_date))
```

---

## Section 10 – Bestellzähler

**Komplexität: MEDIUM**

### Bronze Tables
| Oracle | Databricks |
|---|---|
| sc_bestellzaehler | silver.sc_bestellzaehler |

### Transformation
```python
# Bestellzähler: Kumulierter Zähler pro Konto (RANK/COUNT über Auftragsdaten)
from pyspark.sql.window import Window
w = Window.partitionBy("konto_id_key").orderBy("auftrdat","auftrnr_key")
df = df.withColumn("rank_neu", dense_rank().over(w))

# Zu altem Bestellzähler addieren (aus sc_bestellzaehler)
df = df.join(sc_bestellzaehler, "konto_id_key", "left")
df = df.withColumn("auftrzaehler", col("bestellanzahl_alt") + col("rank_neu"))
```

---

## Section 23 – AYC-Rückwirkung (About You Cloud)

**Komplexität: HIGH – Sonderfall**

### Besonderheit: Rückwirkender Update auf cc_buchung (letzte 14 Tage)

```python
# Oracle: MERGE INTO cc_buchung (direkt auf Zieltabelle!)
# Databricks: DeltaTable merge
from delta.tables import DeltaTable

delta_cc_buchung = DeltaTable.forName(spark, "silver.cc_buchung")
delta_cc_buchung.alias("target").merge(
    df_ayc_rueckwirkend.alias("source"),
    "target.auftrnr_key = source.auftrnr_key AND target.firma = source.firma"
).whenMatchedUpdate(set={
    "ecc": "source.ecc",
    "bestellkanal": "source.bestellkanal",
    "appinfo": "source.appinfo",
    "bestellmedium": "source.bestellmedium",
    "aycorderid_key": "source.aycorderid_key"
}).execute()
```

**Hinweis:** Einziger direkter Rückwärts-Write in cc_buchung im gesamten Script. Muss als separater Task im DAG modelliert werden.

---

## Section 27b – Data Loss Check

**Komplexität: LOW – aber kritisch**

```python
# Oracle: RAISE_APPLICATION_ERROR wenn COUNT differ
count_staging = df_final.filter(
    (col("firma_cc") != 33) & (col("firma") != 149)
).count()
count_cleanse = df_cleanse.count()

if count_staging != count_cleanse:
    raise Exception(f"Data loss: staging={count_staging}, cleanse={count_cleanse}")
```

---

## Gesamtübersicht: Migration Prioritäten

| Priorität | Thema | Aufwand |
|---|---|---|
| P0 | `PKG_IM_VERTRIEBSGEBIET` als Spark UDFs implementieren | HOCH |
| P0 | `lieferkz` CASE-Logik (15+ Zweige) übersetzen | HOCH |
| P1 | AYC-Rückwirkung als Delta MERGE Task | HOCH |
| P1 | Bestellzähler-Kumulierung (Window Functions) | MITTEL |
| P1 | Ausstattungs-ID (8 Sub-Steps → Window Aggregation) | HOCH |
| P2 | Sammelkonto vs. Normalkonto Branch-Logik | MITTEL |
| P2 | `vfart`-Ermittlung (cc_art + cc_marktkz JOIN-Kette) | MITTEL |
| P3 | PKG_STATS.GATHERTABLE → weglassen (Delta Auto-Stats) | KEINE |

## Bronze-Tabellen Gesamtliste

```
bronze.sc_ww_buchung          (Partition: dwh_processdate)
bronze.sc_ww_kundenfirma
bronze.sc_ww_likz
bronze.sc_ww_zahlungskz
bronze.sc_ww_mgeinh
bronze.sc_ww_stationaerkz
bronze.sc_ww_auftragkopf
bronze.sc_ww_auftragpos
bronze.sc_ww_lieferwunsch
bronze.sc_ww_zahlmethode
bronze.sc_ww_zahlwunsch
bronze.sc_ww_auftrstornokz
bronze.sc_ww_alfa_ersatzart
bronze.sc_ww_ersatzwunschkz
bronze.sc_ww_steuerungskz
bronze.sc_ww_sperrgrundkz
bronze.sc_ww_valutakz
bronze.sc_ww_vertrgebiet
bronze.sc_ww_retbeweg
bronze.sc_ww_intabwicklkto
bronze.sc_ww_interessent
bronze.sc_im_tgv_wkz_umcod
bronze.sc_bestellzaehler
silver.cc_firma / cc_art / cc_marktkz / cc_obermarktkz
silver.cc_ausstattung_dir
silver.cc_buchung              (Rückzugriff Altdaten + AYC-Merge)
```
