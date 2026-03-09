# Column Lineage: cc_ww_buchung → clcc_ww_buchung_19

Script version: ##.117 (2026-02-25)
Ziel: `clcc_ww_buchung_19` (Haupt-Staging)
Verglichen: **1.1** (normale Konten) vs. **1.2** (Sammelkonten)

## Spalten-Vergleich

| # | Zielspalte | Source 1.1 (normale Konten) | Source 1.2 (Sammelkonten) | Transformation | Flag |
|---|---|---|---|---|---|
| 1 | dwh_cr_load_id | &gbvid | &gbvid | Job-Parameter | SAME |
| 2 | anspr | ansprachen/100 | ansprachen/100 | scale /100 | SAME |
| 3 | anspr_tele | ansprachen_tele/100 | ansprachen_tele/100 | scale /100 | SAME |
| 4 | artikelnr | artikelnr | artikelnr | direkt | SAME |
| 5 | auftragsnr | CASE LOWER(auftragsnr): uk_sonderlauf/korrektur/crs/urladung/h-* → NULL, sonst REPLACE('.',''') | CASE: uk_sonderlauf/korrektur/crs/urladung → NULL (h-* NICHT ausgeschlossen) | Bereinigung | DIFFERS |
| 6 | auftrnrit_key | auftrnrit_key | auftrnrit_key | direkt | SAME |
| 7 | brabs | brabs/100 | brabs/100 | scale /100 | SAME |
| 8 | brabsers | brabsers/100 | brabsers/100 | scale /100 | SAME |
| 9 | brumsdiff_betrag | brumsdiff_betrag/100 | brumsdiff_betrag/100 | scale /100 | SAME |
| 10 | buchungsdatum | buchungsdatum | buchungsdatum | direkt | SAME |
| 11 | ersatzgroesse | ersatzartikelgroesse | ersatzartikelgroesse | direkt | SAME |
| 12 | ersatzartikelnr | ersatzartikelnr | ersatzartikelnr | direkt | SAME |
| 13 | ersverw | ersverw/100 | ersverw/100 | scale /100 | SAME |
| 14 | firma | firma | firma | direkt | SAME |
| 15 | firma_cc | cc_firma.wert | cc_firma.wert | JOIN lookup | SAME |
| 16 | groesse | groesse | groesse | direkt | SAME |
| 17 | katalogart | CASE firma=28 THEN 992 ELSE katalogart | CASE firma=28 THEN 992 ELSE katalogart | Otto-Marktplatz-Fix | SAME |
| 18 | konto_id_key | konto_id_key | konto_id_key | direkt | SAME |
| 19 | kontoart | CASE cc_firma.wert IN (22,23,24,25,26,27,28,29,30,31,33,34) THEN 3 ELSE kontoart | CASE cc_firma.wert IN (29,30,33) THEN 3 ELSE kontoart | Sammelkonto-Firmen | DIFFERS |
| 20 | lieferwunschkz | lieferwunschkz | lieferwunschkz | direkt | SAME |
| 21 | meterwarekz | DECODE(mgeinh,100,1,NULL) | DECODE(mgeinh,100,1,NULL) | Meterware-Flag | SAME |
| 22 | meterwarekz_cc | cc_meterware.wert | cc_meterware.wert | JOIN lookup | SAME |
| 23 | nabstorno | nabstorno/100 | nabstorno/100 | scale /100 | SAME |
| 24 | nali | nali/100 | nali/100 | scale /100 | SAME |
| 25 | nili | nili/100 | nili/100 | scale /100 | SAME |
| 26 | nina | nina/100 | nina/100 | scale /100 | SAME |
| 27 | nums | nums/100 | nums/100 | scale /100 | SAME |
| 28 | promotionnr | CASE '?' THEN 0 ELSE TO_NUMBER(promotionnr) | CASE '?' THEN 0 ELSE TO_NUMBER(promotionnr) | Null-Safe | SAME |
| 29 | retdiff_betrag | retdiff_betrag/100 | retdiff_betrag/100 | scale /100 | SAME |
| 30 | ret | retoure/100 | retoure/100 | scale /100 | SAME |
| 31 | importanteil | importanteil/100 | importanteil/100 | scale /100 | SAME |
| 32 | telenili | telenili/100 | telenili/100 | scale /100 | SAME |
| 33 | umsatzsaison | umsatzsaison | umsatzsaison | direkt | SAME |
| 34 | umsstorno | umsstorno/100 | umsstorno/100 | scale /100 | SAME |
| 35 | ek_vtgebiet | vtgebiet | vtgebiet | direkt | SAME |
| 36 | zahlungsart | zahlungskz | zahlungskz | direkt | SAME |
| 37 | zahlungsart_cc | cc_zahlwunsch.wert | cc_zahlwunsch.wert | JOIN lookup | SAME |
| 38 | auftrnr_key | auftrnr_key | auftrnr_key | direkt | SAME |
| 39 | auftrpos | auftrpos | auftrpos | direkt | SAME |
| 40 | lieferkz | CASE (15 Zweige: nina/nali/nili/ansprachen/brabs/retoure/nums/telenili/ersatz...) | NULL | Komplex CASE | DIFFERS→UDF |
| 41 | konto_id_orig_key | konto_id_orig_key | konto_id_orig_key | direkt | SAME |
| 42 | mappennr | mappen_nr | mappen_nr | direkt | SAME |
| 43 | anzraten | anzraten | anzraten | direkt | SAME |
| 44 | verkpreis | ABS(CASE ersverw>0: PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100,...) * Mengenfaktor ELSE vkp_fakt/100) | NULL | PKG-Call | DIFFERS→UDF |
| 45 | bestarprom | bestarprom | bestarprom | direkt | SAME |
| 46 | likz | likz | likz | direkt | SAME |
| 47 | likz_cc | cc_artstat.wert | cc_artstat.wert | JOIN lookup | SAME |
| 48 | mwst | mwst/100 | mwst/100 | scale /100 | SAME |
| 49 | anspr_wert | COALESCE(ROUND(anspr/100 * PKG...F_GET_LANDESWAEHRUNG(komwarenwert/100,...),6),0) | COALESCE(ROUND(anspr/100 * PKG...F_GET_LANDESWAEHRUNG(komwarenwert/100,...),6),0) | PKG-Call | SAME→UDF |
| 50 | ansprohnerabattwert | COALESCE(ROUND(anspr/100 * vkp_fakt/100,6),0) | COALESCE(ROUND(anspr/100 * CASE vkp_fakt!=0 THEN vkp_fakt/100 ELSE PKG... END,6),0) | OhneRabatt-Logik | DIFFERS |
| 51 | anspr_tele_wert | COALESCE(ROUND(anspr_tele/100 * PKG...(komwarenwert),6),0) | COALESCE(ROUND(anspr_tele/100 * PKG...(komwarenwert),6),0) | PKG-Call | SAME→UDF |
| 52 | nali_wert | COALESCE(ROUND(nali/100 * PKG...(komwarenwert),6),0) | COALESCE(ROUND(nali/100 * PKG...(komwarenwert),6),0) | PKG-Call | SAME→UDF |
| 53 | naliohnerabattwert | COALESCE(ROUND(nali/100 * vkp_fakt/100,6),0) | COALESCE(ROUND(nali/100 * CASE vkp_fakt!=0... END,6),0) | OhneRabatt-Logik | DIFFERS |
| 54 | nili_wert | COALESCE(ROUND(nili/100 * PKG...(komwarenwert),6),0) | COALESCE(ROUND(nili/100 * PKG...(komwarenwert),6),0) | PKG-Call | SAME→UDF |
| 55 | niliohnerabattwert | COALESCE(ROUND(nili/100 * vkp_fakt/100,6),0) | COALESCE(ROUND(nili/100 * CASE vkp_fakt!=0... END,6),0) | OhneRabatt-Logik | DIFFERS |
| 56 | telenili_wert | COALESCE(ROUND(telenili/100 * PKG...(komwarenwert),6),0) | COALESCE(ROUND(telenili/100 * PKG...(komwarenwert),6),0) | PKG-Call | SAME→UDF |
| 57 | teleniliohnerabattwert | COALESCE(ROUND(telenili/100 * vkp_fakt/100,6),0) | COALESCE(ROUND(telenili/100 * CASE vkp_fakt!=0... END,6),0) | OhneRabatt-Logik | DIFFERS |
| 58 | nums_wert | (brabs-retoure)/100 * PKG...(komwarenwert) | (brabs-retoure)/100 * PKG...(komwarenwert) | PKG-Call | SAME→UDF |
| 59 | numsohnerabattwert | ROUND(brabs/100*vkp_fakt/100) - ROUND(ret/100*vkp_fakt/100) | ROUND(brabs/100*CASE...) - ROUND(ret/100*CASE...) | OhneRabatt-Logik | DIFFERS |
| 60 | brabs_wert | COALESCE(ROUND(brabs/100 * PKG...(komwarenwert),6),0) | COALESCE(ROUND(brabs/100 * PKG...(komwarenwert),6),0) | PKG-Call | SAME→UDF |
| 61 | brabsohnerabattwert | COALESCE(ROUND(brabs/100 * vkp_fakt/100,6),0) | COALESCE(ROUND(brabs/100 * CASE vkp_fakt!=0... END,6),0) | OhneRabatt-Logik | DIFFERS |
| 62 | ret_wert | COALESCE(ROUND(retoure/100 * PKG...(komwarenwert),6),0) | COALESCE(ROUND(retoure/100 * PKG...(komwarenwert),6),0) | PKG-Call | SAME→UDF |
| 63 | retohnerabattwert | COALESCE(ROUND(retoure/100 * vkp_fakt/100,6),0) | COALESCE(ROUND(retoure/100 * CASE vkp_fakt!=0... END,6),0) | OhneRabatt-Logik | DIFFERS |
| 64 | nina_wert | COALESCE(ROUND(nina/100 * PKG...(komwarenwert),6),0) | COALESCE(ROUND(nina/100 * PKG...(komwarenwert),6),0) | PKG-Call | SAME→UDF |
| 65 | ninaohnerabattwert | COALESCE(ROUND(nina/100 * vkp_fakt/100,6),0) | COALESCE(ROUND(nina/100 * CASE vkp_fakt!=0... END,6),0) | OhneRabatt-Logik | DIFFERS |
| 66 | nabstorno_wert | COALESCE(ROUND(nabstorno/100 * PKG...(komwarenwert),6),0) | COALESCE(ROUND(nabstorno/100 * PKG...(komwarenwert),6),0) | PKG-Call | SAME→UDF |
| 67 | nabstornoohnerabattwert | COALESCE(ROUND(nabstorno/100 * vkp_fakt/100,6),0) | COALESCE(ROUND(nabstorno/100 * CASE vkp_fakt!=0... END,6),0) | OhneRabatt-Logik | DIFFERS |
| 68 | umsstorno_wert | COALESCE(ROUND(umsstorno/100 * PKG...(komwarenwert),6),0) | COALESCE(ROUND(umsstorno/100 * PKG...(komwarenwert),6),0) | PKG-Call | SAME→UDF |
| 69 | umsstornoohnerabattwert | COALESCE(ROUND(umsstorno/100 * vkp_fakt/100,6),0) | COALESCE(ROUND(umsstorno/100 * CASE vkp_fakt!=0... END,6),0) | OhneRabatt-Logik | DIFFERS |
| 70 | erslief | CASE brabsers!=0 AND auftrnr_key IS NOT NULL THEN 2 ELSE 1 | CASE brabsers!=0 AND auftrnr_key IS NOT NULL THEN 2 ELSE 1 | Ersatzlieferung-Flag | SAME |
| 71 | nums_wert_vek | COALESCE(ROUND(nums/100 * PKG...(vek/100,...),6),0) | COALESCE(ROUND(nums/100 * PKG...(vek/100,...),6),0) | PKG-Call (EK-Preis) | SAME→UDF |
| 72 | saison | saison | saison | direkt | SAME |
| 73 | retbewegid_key | retbewegid_key | retbewegid_key | direkt | SAME |
| 74 | prozessid | prozessid | prozessid | direkt | SAME |
| 75 | fakturaid_key | fakturaid_key | fakturaid_key | direkt | SAME |
| 76 | auftrag_auftragpoolid_key | auftrag_auftragpoolid_key | auftrag_auftragpoolid_key | direkt | SAME |
| 77 | auftragposid_key | auftragposid_key | auftragposid_key | direkt | SAME |
| 78 | lagerdiffwert | CASE umsstorno>0 AND etbereich!=99: ABS(PKG...(vkp/100,...)) ELSE 0 | CASE umsstorno>0 AND etbereich!=99: ABS(PKG...(vkp/100,...)) ELSE 0 | PKG-Call | SAME→UDF |
| 79 | lagerdiffohnerabattwert | CASE umsstorno>0 AND etbereich!=99: ABS(ROUND(umsstorno/100*vkp_fakt/100)) ELSE 0 | CASE umsstorno>0 AND etbereich!=99: ABS(CASE vkp_fakt!=0... END) ELSE 0 | OhneRabatt-Logik | DIFFERS |
| 80 | impantwert | COALESCE(ROUND(importanteil/100 * PKG...(komwarenwert),6),0) | COALESCE(ROUND(importanteil/100 * PKG...(komwarenwert),6),0) | PKG-Call | SAME→UDF |
| 81 | impantohnerabattwert | COALESCE(ROUND(importanteil/100 * vkp_fakt/100,6),0) | COALESCE(ROUND(importanteil/100 * CASE vkp_fakt!=0... END,6),0) | OhneRabatt-Logik | DIFFERS |
| 82 | stationaerkz | stationaerkz | stationaerkz | direkt | SAME |
| 83 | stationaerkz_cc | cc_stationaerkz.wert | cc_stationaerkz.wert | JOIN lookup | SAME |
| 84 | lagerdiffmenge | CASE etbereich!=99 THEN umsstorno/100 ELSE 0 | CASE etbereich!=99 THEN umsstorno/100 ELSE 0 | scale /100 | SAME |
| 85 | vkp_fakt | vkp_fakt | vkp_fakt | direkt (Rohwert, /100 fehlt hier!) | SAME |
| 86 | paybackauftrag | CASE firma=1 THEN 1 ELSE -3 | CASE firma=1 THEN 1 ELSE -3 | Konstante | SAME |
| 87 | imhostmig | 1 | 1 | Konstante (fix) | SAME |

## Filter-Unterschiede 1.1 vs. 1.2

| Kriterium | 1.1 normale Konten | 1.2 Sammelkonten |
|---|---|---|
| Sammelkonto-Filter | F_EKVT_MIT_SAMMELKONTO = 0 | F_EKVT_MIT_SAMMELKONTO = 1 |
| VTG-Ausschluss | NOT IN ('c','r') | NOT IN ('c','f','F','4','r') |
| Nullzeilen-Filter | lieferkz IS NOT NULL (implizit via CASE) | NOT (alle Mengen = 0) |
| lieferkz | 15-Zweige-CASE-Logik | NULL |
| verkpreis | ABS(PKG-Berechnung) | NULL |

## Zusammenfassung

| Kategorie | Anzahl |
|---|---|
| Gesamtspalten | 87 |
| SAME | 61 |
| DIFFERS | 12 |
| SAME→UDF (PKG-Call in beiden) | 14 |
| DIFFERS→UDF (nur in 1.1) | 1 (`lieferkz`, `verkpreis`) |

## Spalten die UDFs benötigen (PKG_IM_VERTRIEBSGEBIET)

| Spalte | Funktion | Bemerkung |
|---|---|---|
| anspr_wert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | Alle Wert-Spalten |
| nali_wert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | |
| nili_wert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | |
| telenili_wert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | |
| nums_wert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | |
| brabs_wert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | |
| ret_wert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | |
| nina_wert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | |
| nabstorno_wert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | |
| umsstorno_wert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | |
| lagerdiffwert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | |
| impantwert | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | |
| nums_wert_vek | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISFIRMA | EK-Preis (vek statt komwarenwert) |
| verkpreis (nur 1.1) | F_GET_LANDESWAEHRUNG + F_EKVT_TO_PREISVT + F_EKVT_TO_FIRMA | Komplexeste Berechnung |
| F_EKVT_MIT_SAMMELKONTO | Filter-Funktion | WHERE-Klausel |
