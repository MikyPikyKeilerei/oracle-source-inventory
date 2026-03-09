---
name: migration-hint
version: v5.1

description: >
  Erstelle Section-für-Section Migrationshints: Oracle → Databricks/Spark.
  v5.1 härtet den Contract: decisions_needed[] (struktur), oracle_constructs_found[],
  security_check[] als Array sowie Jira-ready Bundle (jira_story + p0_checks).

argument-hint: "[path/to/script.sql]"
allowed-tools: Read, Write, Grep
---

# /migration-hint

## 0) Ziel
- Liefere **umsetzbare** Migrationsempfehlungen pro Section/Step.
- Liefere Jira-ready Artefakte (Story + P0 Checks), damit Sprint-Planung ohne Nacharbeit möglich ist.

## 1) Inputs
- Oracle Script
- `<job>.meta.yaml` (Pflicht empfohlen)
- Optional:
  - `<job>.params.yaml`
  - `<job>.preconditions.yaml`
  - `<job>.lineage.yaml` + `<job>.lineage.mmd`

## 2) Outputs (v5.1)
### 2.1 Hauptoutput: `<job>.migration_hints.md`
Muss enthalten:
- pro Section/Step:
  - Ziel-Layer (Bronze/Silver Key/Silver Hist/Gold)
  - Oracle→Spark Pattern Mapping
  - Code-Sketch (SQL/PySpark) oder TODO mit Begründung
  - Dependencies (Upstreams + missing artifacts)

### 2.2 Zusatzoutputs (Jira-ready Bundle)
- `<job>.jira_story.md`
- `<job>.p0_checks.md`

## 3) Strukturierte Pflichtblöcke (für Maschinenlesbarkeit)
Zusätzlich zum Fließtext MUSST du am Ende des Outputs einen **YAML Summary Block** erzeugen (Pflicht). In diesem Block stehen die folgenden strukturierten Listen:

### 3.1 decisions_needed[] (Pflicht)
Schema pro Eintrag:
- `id`: string
- `question`: string
- `impact`: enum (`p0_blocker|p1_quality|p2_scope`)
- `status`: enum (`open|resolved|superseded`)
- `owner`: string|null
- `suggested_default`: string|null
- `evidence`: string|null (z.B. Section/Step oder Code-Snippet Hinweis)

Beispiel-IDs (projektspezifisch – als Vorlage, nicht als Pflicht-Liste):
- `scope_cross_selling_section_2`
- `scope_vfart_ovf`
- `gold_meterware_case`
- `gold_brutto_netto_split`
- `cc_kunde_season_handling`

### 3.2 oracle_constructs_found[] (Pflicht, wenn vorhanden)
Schema pro Eintrag:
- `construct_type`: enum (`ROWNUM|CONNECT_BY|EXECUTE_IMMEDIATE|CURSOR|UTL_FILE|DBMS_SCHEDULER|DB_LINK|SQLPLUS|PARTITION_MGMT|STATS_GATHER`)
- `location`: string (section/step)
- `databricks_equivalent`: string
- `effort`: enum (`low|med|high`)
- `risk_note`: string|null

### 3.3 security_check[] (Pflicht, wenn sensible Felder vermutet oder erkannt)
Trigger:
- Entweder eindeutig (z.B. aus Meta/Lineage), oder heuristisch über Feldnamen (kontonr, email, telefon, gebdat ...).
- Wenn unsicher: `sensitivity: unknown` + Warning/Decision.
Schema pro Eintrag:
- `field`: string
- `sensitivity`: enum (`pii|financial|restricted|unknown`)
- `databricks_strategy`: string (z.B. Unity Catalog Column Masking)
- `layer_boundary`: enum (`bronze|silver|gold`)

### 3.4 missing_artifacts[] (Pflicht, wenn meta.yaml es liefert)
- Übernimm `missing_artifacts[]` aus meta.yaml.
- Jeder Eintrag MUSS folgendes Schema haben:
  - `id`: string (verwende die kanonischen IDs wie `MISSING:...`)
  - `severity`: enum (`p0|p1|unknown`)
  - `why_blocking`: string
  - `closure_criteria`: string
  - `evidence`: string|null

## 4) P0 Checks (Masterplan Pitfalls)
`p0_checks.md` MUSS die wichtigsten Pitfalls als checklist enthalten (copy/paste in Jira).
Zusätzlich MUSS der YAML Summary Block ein `p0_checks[]` Array enthalten: `{ id, description, severity, evidence }`.
Checklist-Inhalte:
- ÷100 Ganzzahldivision vermeiden (`/100.0`, CAST)
- PKG_IM_VERTRIEBSGEBIET Strategie (Lookup Join vs UDF) + Tests
- CC_Kunde Join 4 (`kdfirmkz` als firma) + Dirty-Filter + Dedup
- Missing Artifacts blocking

## 5) Regeln
- PKG Default:
  - Wenn als Lookup abbildbar: `lookup_join` (Broadcast Join) statt Row-UDF.
  - Wenn nicht abbildbar: `spark_udf` + `missing_artifacts`/`decisions_needed`.
- Unbekannte Oracle Patterns:
  - Nicht raten → `decisions_needed[]` + TODO.

## 6) Definition of Done
- jira_story.md + p0_checks.md vorhanden.
- decisions_needed[] ist vorhanden (auch wenn leer).
- oracle_constructs_found[] ist vorhanden, wenn Constructs erkannt.
- security_check[] befüllt, wenn relevante Felder.

## 7) Output Format
- Haupttext als Markdown.
- Am Ende: genau ein YAML Summary Block (Pflicht) mit decisions_needed, oracle_constructs_found (falls vorhanden), security_check (falls relevant), missing_artifacts (falls vorhanden), p0_checks.