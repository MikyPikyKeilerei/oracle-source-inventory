# DSV – Datenbank-Skript-Verwaltung: Technische Referenz

> Analysiert aus den PDFs: DSV Info, Arbeiten mit DSV, GBV - Global Batch Verarbeitung,
> Platzhalterfunktionen, Spezielle Themen in DSV
> Erstellt: 2026-02-25

---

## 1. Was ist DSV?

**DSV = Datenbank-Skript-Verwaltung** – ein proprietäres internes Job-Scheduling- und
Script-Management-System der Otto/Witt-Gruppe.

### Engine-Stack (Antwort: Was läuft hier?)

| Schicht | Technologie |
|---|---|
| **Scheduling-Engine** | GBV (Globale Batch Verarbeitung) |
| **Script-Ausführung** | Oracle SQL\*Plus (`sqlplus < StartDatei.tmp`) |
| **Primäre Datenbank** | Oracle (UDWH, PAPA, IMDB) |
| **Sekundäre DB** | Teradata (via ODBC/FastExport) |
| **OLAP-Würfel** | IBM Cognos TM1 |
| **Server-Zugang** | SSH (Unix-Server: epa01, epa02, epa03/04, epa-wgd01) |
| **Dateitransfer** | SFTP |
| **Versionierung** | Subversion (SVN) |
| **Prozess-Lock** | Oracle-Tabelle `SEW_LOCK` (Unique Index) |

### Bekannte Datenbanken / Umgebungen

| Alias | Bedeutung |
|---|---|
| `UDWH` | Unternehmens-Data-Warehouse (Produktion) |
| `UDWH_T` / `UDWHT2` | UDWH Testumgebung |
| `PAPA` | Weitere Produktionsdatenbank |
| `PAPATST` | PAPA Testumgebung |
| `IMDB` | Interne Datenbank |
| `LOADER` | DB-User für Dateioperationen |
| `IMPROG` | DB-User für Startbedingungsprüfung |

---

## 2. GBV – Globale Batch Verarbeitung (Scheduling-Engine)

### Wie Jobs gestartet werden

1. **GBV-Server prüfen** alle 45 Sekunden (3 Server, nur einer prüft gleichzeitig via `SEW_LOCK`)
2. **Sortierreihenfolge** beim Start: Priorität → Datenbank (UDWH > PAPA > UDWH_T) → Termin → BAJ_ID
3. **Startbedingungen** werden in der im DSV definierten Reihenfolge geprüft
4. Sobald eine Bedingung nicht erfüllt ist → Job kommt in **Blacklist**
5. Sobald 2 Jobs startbereit sind → Prüfung bricht ab

### Parallele Jobs je Priorität (max. gleichzeitig)

| Priorität | Max. parallele Jobs |
|---|---|
| Prio 1 | 30 |
| Prio 2, 3, 5, 9 | 18 |

### Blacklist-Wartezeiten

| Priorität | Wartezeit in Blacklist |
|---|---|
| Prio 0 | 0 Minuten |
| Prio 1 | 3 Minuten |
| Prio 2–9 | 5 Minuten |
| Prio 9 | 15 Minuten |

### Kurzläufer-Optimierung

- Durchschnittliche Laufzeit < 2 Min → Priorität um 2 erhöht (max. Prio 1)
- Durchschnittliche Laufzeit < 4 Min → Priorität um 1 erhöht (max. Prio 1)
- Basis: Letzte 10 Läufe

---

## 3. Job-Statusübergänge

```
Gesperrt
   │
   ▼
Offen ──────────► In Bearbeitung ──────► Erfolgreich beendet
   │                    │
   ▼                    ▼
Storniert         Mit Fehler beendet ──► Korrigiert
   │
   ▼
Storniert + Wiederholt
```

### Fehlertypen

| Typ | Verhalten |
|---|---|
| **Harmloser Fehler** | Job-Status ändert sich nicht, Job gilt als erfolgreich |
| **Wiederholungsbedürftiger Fehler** | Job wird wiederholt (falls Wiederholungsanzahl > 0) |
| **Abbruchsfehler** | Job endet mit "Mit Fehler beendet" |
| **Sofortiger Abbruchsfehler** | Job sofort beendet + auf Fehler gesetzt |

### Job abbrechen

Aufruf von `WWDBA.PKG_KILL.KILL` → Oracle-Session auf `KILLED` setzen → SSH-Sitzung beendet.

---

## 4. Job-Steuerungsmethoden

### 4.1 Steuerung über Termine

- Termine werden automatisch täglich angelegt (ca. 0:00 Uhr), sodass immer 10 Termine vorhanden sind
- Wöchentliche oder monatliche Wiederholung konfigurierbar
- Periodische Wiederholung: ohne/mit Endzeitpunkt möglich

### 4.2 Steuerung über Abhängigkeiten (Dependency Tree)

- **Pflicht**: Es muss immer **einen eindeutigen Startjob (Wurzel)** geben
- Startjob hat Termine, alle Folgejobs bekommen Termine am Ende des Vorgänger-Jobs
- Folgejob startet nur wenn **alle Vorgänger** erfolgreich beendet oder korrigiert sind
- Zugriff auf Wurzel-ID im Skript via `@ID_WURZEL()`

### 4.3 Startbedingungen

- Typ **SQL**: Abfrage wird auf UDWH unter User `IMPROG` ausgeführt → erfüllt wenn min. 1 Datensatz zurückkommt und erstes Feld nicht NULL
- Typ **Dateiprüfung** (EXE): Prüft ob Datei im Verzeichnis existiert; optional Header/Trailer-Check
- Sonderlinks: `@udwht2`, `@papa` für andere Datenbanken; `@DBL()` für alle Umgebungen

---

## 5. Platzhalterfunktionen (@-Funktionen)

### Basis-Syntax

```
A    = aktuelles Datum (Systemdatum)
T    = geplantes Termindatum der Batchausführung
AM   = Monatszahl des aktuellen Datums
TM   = Monatszahl des Termindatums
+N   = N Tage/Monate addieren
-N   = N Tage/Monate subtrahieren
```

### 5.1 Tagesdatumsfunktionen

| Funktion | Rückgabe | Beispiel | Ergebnis |
|---|---|---|---|
| `@D(Basis[,Format])` | Datum als `TO_DATE()` Oracle-Funktion | `@D(T,'dd.mm.yyyy')` | `TO_DATE('14.10.2003','dd.mm.yyyy')` |
| `@DT(Basis[,Format])` | Datum als Textzeichenkette | `@DT(T+1,'ddmmyyyy')` | `"05122003"` |
| `@T(Basis)` | Wochentag (MO, DI, MI, ...) | `@T(A)` | `"DI"` |

### 5.2 Saisonfunktionen

| Funktion | Rückgabe | Beispiel | Ergebnis |
|---|---|---|---|
| `@S(Basis)` | Vertriebsaisonnummer | `@S(A)` | `"103"` |
| `@ES(Basis)` | Einkaufssaisonnummer | `@ES(A)` | `"108"` |
| `@SA(Basis[,Format])` | VT-Saisonanfang als `TO_DATE()` | `@SA(A)` | `"TO_DATE('01.01.2003','dd.mm.rrrr')"` |
| `@SE(Basis[,Format])` | VT-Saisonsende als `TO_DATE()` | `@SE(A)` | `"TO_DATE('30.06.2003','dd.mm.rrrr')"` |
| `@SAT(Basis[,Format])` | VT-Saisonanfang als Text | `@SAT(A)` | `"01.01.2003"` |
| `@SET(Basis[,Format])` | VT-Saisonsende als Text | `@SET(A)` | `"30.06.2003"` |

### 5.3 Sonstige Datumsfunktionen

| Funktion | Rückgabe | Beispiel | Ergebnis |
|---|---|---|---|
| `@J(Basis)` | Jahreszahl | `@J(A)` | `"2005"` |
| `@HJ(Basis)` | Halbjahresnummer (1 oder 2) | `@HJ(A)` | `"1"` |
| `@M(Basis[,Format])` | Monatsnummer | `@M(A,'mmmm')` | `"Januar"` |
| `@MA(Basis[,Format])` | Monatsanfang als `TO_DATE()` | `@MA(A)` | `"TO_DATE('01.03.2003','dd.mm.rrrr')"` |
| `@ME(Basis[,Format])` | Monatsende als `TO_DATE()` | `@ME(A)` | `"TO_DATE('31.03.2003','dd.mm.rrrr')"` |
| `@MAT(Basis[,Format])` | Monatsanfang als Text | `@MAT(A)` | `"01.05.2013"` |
| `@MET(Basis[,Format])` | Monatsende als Text | `@MET(A)` | `"31.05.2013"` |
| `@W(Basis[,Format])` | Kalenderwoche | `@W(A,'ww')` | `"02"` |
| `@LV(Basis[,Format])` | LV-Datum als `TO_DATE()` | `@LV(T)` | `TO_DATE('31.05.2017','dd.mm.yyyy')` |
| `@LVT(Basis[,Format])` | LV-Datum als Text | `@LVT(T)` | `'31.05.2017'` |

**Hinweis LV:** Quelle ist `LOADER.LV_INFO`. Wenn kein LV-Tag → Default `01.01.1900`.

### 5.4 Systemfunktionen

| Funktion | Rückgabe | Beispiel-Wert |
|---|---|---|
| `@ID()` | BAJ-Job-Nummer (eindeutig je Lauf) | `"176547"` |
| `@JB()` | DSV-interne Job-Nummer | `"176"` |
| `@ID_WURZEL()` | Batchjob-ID der Wurzel des Abhängigkeitenbaums | `"176547"` |
| `@LAUF_ID()` | Lauf-ID des laufenden Jobs | `"176547"` |
| `@LAUF_ID_WURZEL()` | Lauf-ID der Wurzel des Abhängigkeitenbaums | `"176547"` |
| `@UNIX_BEN_NAME()` | Unix-Benutzername des Job-Besitzers | `"TestUser"` |
| `@TERADATA_NAME()` | Teradata-Benutzername | `"TestBenutzername"` |
| `@TERADATA_PASS()` | Teradata-Passwort | _(verschlüsselt)_ |
| `@TERADATA_NAME_TEST()` | Teradata Testdatenbank Benutzername | `"TestBenutzername"` |
| `@TERADATA_PASS_TEST()` | Teradata Testdatenbank Passwort | _(verschlüsselt)_ |
| `@TD_SERVER_ID()` | Interne ID des Teradata-Servers im Job | `1` |
| `@TERADATA_SERVER()` | Servername des Teradata-Servers | `"tdprod1.ov.otto.de"` |
| `@RECHNER_NAME()` | Name des GBV-Rechners | `"GBV011"` |

### 5.5 Datenbanklink-Funktionen

| Funktion | Verwendung | Kontext |
|---|---|---|
| `@DBL()` | Datenbanklink von IMPROG → UDWH | **Nur in Startbedingungen** |
| `@DBL_LOADER()` | Datenbanklink von UDWH/PAPA → IMDB | In Skripten |
| `@AKT_DBL()` | Datenbanklink der aktuellen DB | **Nur in Startbedingungen** |

**Beispiel Datenbanklink in Startbedingung:**
```sql
SELECT 1 FROM Tabellenname@DBL()
WHERE Flagdatum = @D(T)
-- Auf UDWH:   SELECT 1 FROM Tabellenname@UDWH WHERE ...
-- Auf UDWH_T: SELECT 1 FROM Tabellenname@UDWHT2 WHERE ...
-- Auf PAPA:   SELECT 1 FROM Tabellenname@PAPA WHERE ...
```

### Datumsformat-Bezeichner

| Code | Bedeutung |
|---|---|
| `dd` | Tag mit führender Null (01–31) |
| `mm` | Monat mit führender Null (01–12) |
| `mmm` | Monatsname als Abkürzung (Jan–Dez) |
| `mmmm` | Vollständiger Monatsname |
| `yy` | Jahr zweistellig |
| `yyyy` | Jahr vierstellig |
| `w` | Kalenderwoche ohne Null (1–52) |
| `ww` | Kalenderwoche mit Null (01–52) |

---

## 6. Job-Struktur und Script-Management

### Job-Typen

| Typ | Beschreibung |
|---|---|
| **Oracle** (Standard) | SQL-Skript via SQLPlus auf Oracle-DB |
| **Konzern-DB** | Job auf Konzern-Datenbank |
| **TM1** | Import/Neubau von TM1-Würfeln |
| **Tabellenextraktion (TET)** | Datenextraktion nach Format-Vorlage |
| **Amos Russland** | Spezialtype für Russland-Daten |

### Job-Komponenten

| Reiter | Funktion |
|---|---|
| Allgemeine Daten | Name, Priorität, Wartezeit, Gruppe, Ausführungsgruppe |
| Ausführungsplan | Termine, Abhängigkeiten, Wiederholung |
| Startbedingungen | SQL- oder Datei-Bedingungen |
| Parameter | Skript-Parameterwerte (feste Werte oder @-Funktionen) |
| Skript | Haupt-SQL-Skript + Unterskripte |
| Zusatzdateien | CTL-Dateien, Shell-Skripte, etc. |
| Fehlerbehandlung | Spool-Prüfung, Wiederholungsanzahl |
| Jobergebnisse | Email-Versand, RVS-Report, FTP-Archiv |
| Abschluss-Skript | Läuft nach Fehlerprüfung des Hauptskripts |
| Restore-Skript | Rückgängig machen für bereits gelaufene Jobs |
| **Abhängigkeiten** | Vorgänger/Nachfolger-Baum |

### Script-Aufrufkette (Oracle-Job)

```
GBV-Server
  └─► SSH-Login als DSV-Jobbesitzer (Public Key, epa01)
       └─► Umgebungswahl via Kommandozeile (udwh / papa)
            └─► SFTP: Skripte + Zusatzdateien übertragen
                 └─► Oracle-Anmeldung: sqlplus < StartDatei.tmp
                      └─► SQLPlus wartet auf "Disconnected"
```

### Wichtige Oracle-Tabellen im DSV

| Tabelle | Inhalt |
|---|---|
| `GBV_BATCH_JOB` | Alle laufenden/vergangenen Batch-Jobs mit Status |
| `GBV_BATCH_FLAG` | Flags für Job-Koordination |
| `SEW_LOCK` | Mutex für GBV-Server-Prüfung |
| `LOADER.LV_INFO` | LV-Datums-Informationen (LVDAT, lvdatfolgelv) |

---

## 7. Abhängigkeiten exportieren

### Wo liegen Abhängigkeiten?

Die Job-Abhängigkeiten sind in mehreren Quellen gespeichert:

| Quelle | Format | Zugang |
|---|---|---|
| DSV-Datenbank (`GBV_BATCH_JOB`) | Oracle-Tabellen | SQL-Abfrage |
| DSV-GUI Tab "Abhängigkeiten" | Visueller Baum | DSV-Anwendung |
| SVN-Repository | Textdatei `Startbedingungen.txt` je Job | SVN-Client |
| DSV-Abhängigkeitsbaum (`@ID_WURZEL`) | Implizit im Code | Script-Analyse |

### Empfohlene Export-Strategie

**Option A: SQL-Export aus Oracle (direktester Weg)**
```sql
-- Alle aktiven Jobs mit Status
SELECT BAJ_ID, BAJ_PROJEKT, BAJ_STATUS, BAJ_IPAR_1, BAJ_IPAR_2, BAJ_IPAR_3
FROM GBV_BATCH_JOB
WHERE BAJ_PROJEKT = 'DSV'
ORDER BY BAJ_ID;

-- Exklusivitätsprüfung (Muster aus Startbedingungen)
SELECT DECODE(COUNT(*), 0, 1, NULL)
FROM GBV_BATCH_JOB
WHERE BAJ_PROJEKT = 'DSV'
  AND BAJ_STATUS = 'B'        -- 'B' = in Bearbeitung
  AND BAJ_IPAR_1 = @JB()     -- DSV-Job-Nr
```

**Option B: SVN-Repository auslesen**

Pfad: `svn://subversion-witt.witt-gruppe.eu/CPP/IM-TOOLBAR`

Struktur je Job:
```
Jobs/
  └─ <JobVerzeichnis>/
       └─ <JobName>/
            ├─ Parameter.txt          (Parameterwerte mit "|" getrennt)
            ├─ Startbedingungen.txt   (Bezeichnung + SQL/EXE-Definition)
            ├─ Skript.txt             (ID + Name des Skripts)
            ├─ Abschlussskript.txt
            └─ Restoreskript.txt
```

**Option C: DSV-GUI Jobexplorer**
- Filter nach ID, Name oder Inhalt (Skript, Parameter, Startbedingungen)
- Visueller Abhängigkeitsbaum mit Vorgänger- und Nachfolgerjobs
- Kontextmenü: Differenz zur Vorgängerversion (via Tortoise SVN)

**Option D: YAML-basiertes Inventar (bereits vorhanden)**

Das Projekt enthält bereits `dependency_graph.yaml` – ideal für strukturierte Erfassung der in den Skripten erkennbaren `@ID_WURZEL()`/`@JB()`-Bezüge.

### Exportierbare Attribute je Job

```yaml
job:
  dsv_job_id: "@JB()"           # DSV-interne Nummer
  baj_id: "@ID()"               # Batchjob-ID (je Lauf eindeutig)
  wurzel_id: "@ID_WURZEL()"     # Wurzel des Abhängigkeitenbaums
  lauf_id: "@LAUF_ID()"
  lauf_id_wurzel: "@LAUF_ID_WURZEL()"
  vorgaenger: []                # direkte Vorgänger-Jobs
  nachfolger: []                # direkte Nachfolger-Jobs
  startbedingungen: []          # SQL oder Dateiprüfung
  datenbank: UDWH | PAPA | IMDB
  prioritaet: 1-9
```

---

## 8. Abschluss-Skript – Fehlercode-Variable

Das Abschluss-Skript erhält eine `DSVFehler CHAR(5)` Variable mit einem Bit je Fehlertyp:

| Position | Fehlertyp |
|---|---|
| 1 | Abbruchsfehler |
| 2 | Sofortiger Abbruchsfehler |
| 3 | Wiederholungsbedürftiger Fehler |
| 4 | Harmloser Fehler |
| 5 | Noch nicht definierter Fehler |

```sql
-- Beispielwert: '00101' = nur Wiederholungsbedürftige + Undefinierte Fehler
BEGIN
  if :DSVFehler in ('00000','00010') then -- kein Fehler oder harmloser Fehler
    -- Erfolgspfad
  end if;
END;
```

---

## 9. Wichtige Muster für die Migration

### Erkennen von DSV-Abhängigkeiten im Code

```sql
-- Suche nach Abhängigkeitsreferenzen in Startbedingungen:
SELECT DECODE(COUNT(*), 0, 1, NULL)
FROM GBV_BATCH_JOB
WHERE BAJ_PROJEKT = 'DSV'
  AND BAJ_STATUS = 'B'
  AND BAJ_IPAR_1 = @JB()     -- Job läuft bereits?

-- LV-Stammgeschäft: tägliche Stornierung falls kein LV-Tag
-- Cronjob: 0:01 Uhr
-- Bedingung: trunc(lvdatfolgelv) = trunc(sysdate)
```

### Teradata-Job-Muster

```bash
.logon @TERADATA_SERVER()/@TERADATA_NAME(),@TERADATA_PASS();
```

### SQL-Loader-Muster

```bash
!sqlldr parfile=pass.txt control=Datei.ctl
```

### NLS-Einstellungen (login.sql)

```sql
ALTER SESSION SET NLS_LANGUAGE= 'AMERICAN';
ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ',.';
ALTER SESSION SET NLS_CALENDAR= 'GREGORIAN';
ALTER SESSION SET NLS_DATE_FORMAT= 'DD-MON-RR';
ALTER SESSION SET NLS_DATE_LANGUAGE= 'GERMAN';
ALTER SESSION SET NLS_SORT= 'GERMAN';
```

---

## 10. Automatische Bereinigung (Housekeeping)

| Prozess | Trigger | Aktion |
|---|---|---|
| LV-Stornierung | Täglich 0:01 Uhr (Cronjob) | Jobs der Gruppe "LV-Stammgeschäft Datenladung" stornieren, falls kein LV-Tag in `loader.lv_info` |
| Skript-Benachrichtigung | 1. des Monats | Skripte ohne Verwendung und letzter Änderung zwischen -2 Monate und heute → Email an IM-BI |
| Skript-Löschung | 1. des Monats | Skripte ohne Verwendung und letzter Änderung vor -2 Monate → löschen |
| Job-Deaktivierung | Automatisch | Jobs die > 13 Monate nicht gelaufen sind und keine neuen Termine haben |
