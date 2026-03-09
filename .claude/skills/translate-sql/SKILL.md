---
name: translate-sql
version: v5.1

description: >
  Übersetze Oracle SQL/SQL*Plus Blöcke (SELECT, INSERT, MERGE, UPDATE, DELETE, DDL) in Spark SQL.
  v5.1 erzwingt einen deterministischen translation_report mit regelbasierter Confidence-Formel,
  iterationssicheres Output-Naming und klare No-Guessing Regeln.

argument-hint: "[path/to/script.sql]"
allowed-tools: Read, Write
---

# /translate-sql

## 0) Ziel
- Liefere lauffähiges Spark SQL (best effort) als Output.
- Liefere einen maschinenlesbaren Übersetzungsreport, damit klar ist, was manuell zu tun bleibt.
- Scope: SELECT, INSERT, MERGE, UPDATE, DELETE, CREATE TABLE/VIEW (DDL).
- PL/SQL-Blöcke, Packages, Trigger: nur erkennen + als unsupported flaggen (nicht übersetzen).

## 1) Inputs
- Oracle Script (SQL*Plus möglich)
- Optional: <job>.meta.yaml (für load_pattern/merge_keys/targets)

## 2) Outputs (v5.1)
Du MUSST zwei Artefakte erzeugen:
1) <name>.translated.sql (Spark SQL)
2) <name>.translation_report.yaml (Report)

Naming-Konvention (konsistent mit allen anderen Skills):
- <name> = Input-Dateiname ohne Extension
  (z.B. Input: dm_ww_f_ecat_bruttonetto.sql
   -> dm_ww_f_ecat_bruttonetto.translated.sql
   -> dm_ww_f_ecat_bruttonetto.translation_report.yaml)
- Output-Verzeichnis: analysis-output/<job_name>/ (wie alle anderen Skills)
- Pattern: <name>.<skill-suffix>.<extension> (identisch zu .meta.yaml, .lineage.yaml etc.)
- Bei iterativer Nutzung (mehrere Scripts): jedes Script erzeugt sein eigenes Paar.
  Bestehende Artefakte anderer Scripts werden NICHT überschrieben.
- Wenn dasselbe Script erneut übersetzt wird: überschreibe nur dessen eigene Artefakte.
- Cumulative Index: Bei mehreren Scripts in einer Session erzeuge/aktualisiere
  translation_index.yaml (Schema siehe unten).

Wenn nur ein Chat-Output möglich ist, dann gib zuerst SQL aus und danach einen
YAML-Block translation_report. Kennzeichne source_file im Report-Header klar.

### translation_index.yaml Schema
translation_index:
  project: string           # optional, z.B. "eCAT Welle 1"
  runs[]:
    - source_file: string
      run_id: string         # ISO-Timestamp
      confidence_percent: number
      total_statements: number
      translated_statements: number
      unsupported_count: number
      todo_count: number
      output_files: [string]
  summary:
    total_scripts: number
    avg_confidence: number
    scripts_above_80: number
    scripts_below_50: number

## 3) Übersetzungsregeln (Minimum)
- Entferne SQL*Plus Noise: PROMPT, SPOOL, SET, WHENEVER, EXIT.
- Funktions-Transformationen:
  - NVL(a,b) -> COALESCE(a,b)
  - NVL2(a,b,c) -> CASE WHEN a IS NOT NULL THEN b ELSE c END
  - DECODE(...) -> CASE WHEN ... END
  - SYSDATE -> current_timestamp() (oder current_date() wenn passend)
  - TO_DATE(str, fmt) -> to_date(str, spark_fmt) (siehe Formatstring-Lookup)
  - TO_CHAR(val, fmt) -> date_format(val, spark_fmt) (siehe Formatstring-Lookup)
  - ROWNUM -> ROW_NUMBER() OVER (...) + Warning (Kontext manuell prüfen)
- Join-Transformationen:
  - Oracle Outer Join (+) -> LEFT JOIN (best effort)
- DML-Transformationen:
  - UPDATE ... SET -> Spark-kompatibles UPDATE (Delta/Iceberg Syntax)
  - DELETE FROM -> Spark-kompatibles DELETE (Delta/Iceberg Syntax)
- DDL-Transformationen:
  - CREATE TABLE -> CREATE TABLE IF NOT EXISTS ... USING DELTA (immer Delta, Projekt-Standard)
  - CREATE VIEW -> CREATE OR REPLACE VIEW (kein USING)
  - Wenn meta.yaml ein anderes Storage-Format angibt -> das verwenden
  - Sequences, Synonyme, Grants: als unsupported_construct flaggen
- Datentypen:
  - Oracle NUMBER -> Spark DECIMAL/DOUBLE (nur wenn nötig; sonst Warning)
  - Oracle VARCHAR2(n) -> Spark STRING
  - Oracle DATE -> Spark TIMESTAMP (Warning: Oracle DATE hat Zeitanteil)
  - Oracle CLOB/BLOB -> unsupported_construct + manual_todo

### Formatstring-Lookup (Oracle -> Spark)
Datumsformate:
  DD   -> dd         (Tag im Monat)
  MM   -> MM         (Monat numerisch)
  MON  -> MMM        (Monatsname kurz, z.B. JAN)
  MONTH -> MMMM      (Monatsname lang)
  YYYY -> yyyy       (Jahr 4-stellig)
  YY   -> yy         (Jahr 2-stellig)
  RR   -> yy         (Warning: Oracle RR hat Jahrhundertlogik -> manual_todo)
  DAY  -> EEEE       (Wochentag lang)
  DY   -> EEE        (Wochentag kurz)
Zeitformate:
  HH24 -> HH         (24h-Stunde)
  HH12 -> hh         (12h-Stunde)
  HH   -> hh         (12h-Stunde, Oracle Default)
  MI   -> mm         (Minute)
  SS   -> ss         (Sekunde)
  FF   -> SSSSSS     (Microsekunden) + Warning (Präzision prüfen)
Sonderzeichen:
  AM/PM -> a
  TZH:TZM -> unsupported -> Warning + manual_todo
Spezial:
  Q    -> Q          (Quartal, Spark 3.4+; sonst Warning)
  WW   -> ww         (Kalenderwoche) + Warning (ISO-Semantik prüfen)
  IW   -> ww         (ISO-Woche) + Warning (Semantik prüfen)
  FMDD -> dd         (Fill Mode ignorieren, Warning)
Regeln:
- Trennzeichen (-, /, ., :, Leerzeichen) 1:1 übernehmen.
- Unbekannte Formate: unsupported_construct + manual_todo.
- RR-Format immer mit Warning (Jahrhundertlogik geht verloren).

## 4) MERGE Generierung
- Wenn meta.yaml load_pattern: incremental_merge oder MERGE im Oracle Script erkannt wird:
  - Erzeuge MERGE INTO Delta Syntax.
  - Wenn merge_keys fehlen: setze TODO + Report Entry.

## 5) translation_report.yaml (Pflicht)
Schema:
- schema_version: "translation_report_v5_1"
- source_file: string
- total_statements: number (Gesamtzahl erkannter SQL-Statements im Input)
- translated_statements: number (davon erfolgreich übersetzt)
- confidence_percent: number (0-100, deterministisch berechnet, siehe Formel)
- unsupported_constructs[]: list[object]
  - { type, category, location, snippet, reason, penalty_points }
  - category: "structural" | "data_type"
- manual_todos[]: list[object]
  - { id, location, description, snippet, penalty_points }
- warnings[]: list[object]
  - { code, message, severity, evidence, action, penalty_points }
- outputs[]: list[string] (welche Dateien/sections erzeugt wurden)
- run_id: string (ISO-Timestamp des Laufs, z.B. 2026-03-07T12:45:00Z)

### Deterministische Confidence-Formel

base_score = 100
penalty = 0

Für jedes unsupported_construct (category=structural):  penalty += 20
Für jedes unsupported_construct (category=data_type):   penalty += 10
Für jedes manual_todo:                                  penalty += 8
Für jede warning (severity=high):                       penalty += 5
Für jede warning (severity=medium):                     penalty += 3
Für jede warning (severity=low):                        penalty += 1

Bei total_statements > 0:
  coverage_factor = translated_statements / total_statements
Sonst:
  coverage_factor = 0

confidence_percent = max(0, round((base_score - penalty) * coverage_factor))

Kategorisierung unsupported_constructs:
- structural (penalty 20): CONNECT BY, Cursor-Loop, EXECUTE IMMEDIATE,
  PL/SQL Blocks, Packages, Trigger, Bulk Collect, Pipelined Functions
- data_type (penalty 10): CLOB, BLOB, XMLTYPE, SDO_GEOMETRY, BFILE

Regeln:
- Die penalty_points in jedem Eintrag dokumentieren den individuellen Abzug.
- Der Score ist reproduzierbar: gleiches Input -> gleicher Score.
- Penalty kann > 100 werden; confidence_percent wird auf 0 geflooret.

## 6) Join/Outer-Join Warnungen
- Bei (+) oder komplexen Join-Ketten:
  - Füge Warning ORACLE_OUTER_JOIN_PLUS hinzu.
  - Füge manual_todo hinzu, wenn die Transformation unsicher ist.

## 7) No-Guessing
- Wenn ein Konstrukt nicht sauber übersetzbar ist (CONNECT BY, Cursor-Loop, EXECUTE IMMEDIATE, PL/SQL Blocks):
  - Nicht raten.
  - Markiere es als unsupported_constructs + manual_todos.

## 8) Definition of Done
Checks (alle müssen erfüllt sein):
- [ ] Alle SQL*Plus Noise entfernt (kein SPOOL, SET, WHENEVER, EXIT im Output)
- [ ] Keine Oracle-Funktionen mehr im Output (NVL, DECODE, SYSDATE) - sonst unsupported_construct
- [ ] Jedes Statement endet mit ;
- [ ] Alle Formatstrings via Lookup gemappt (keine Oracle-Formate im Output)
- [ ] DDL verwendet USING DELTA (es sei denn meta.yaml sagt anders)
- [ ] translation_report.yaml ist YAML-valide (parst ohne Fehler)
- [ ] confidence_percent ist deterministisch gesetzt (Formel aus Section 5)
- [ ] Output-Dateien folgen <name>.suffix Konvention (konsistent mit Pipeline)
- [ ] Bei Batch: translation_index.yaml ist aktuell
Out of Scope:
- Syntaktische Spark-SQL-Validierung (wäre separater Skill/Schritt)
- Semantische Korrektheit (erfordert Laufzeit-Tests)

## 9) Output Format
- Gib nur die zwei Artefakte aus (SQL + YAML Report). Kein zusätzlicher Fließtext außerhalb der Artefakte.
- Optional: translation_index.yaml wenn Batch-Modus.