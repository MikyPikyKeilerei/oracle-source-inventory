---
name: analyze-oracle-script
version: v5.1

description: >
  Analysiere ein Oracle SQL*Plus/DSV Script und generiere eine strukturierte <job>.meta.yaml.
  v5.1 härtet den Contract: execution_context, columns/tracked_columns mit MVP-Scope,
  Lookup-Origin + decisions_needed, sowie dimension_keys (compound_fk) als Join-Contract.

argument-hint: "[path/to/script.sql]"
allowed-tools: Read, Write, Bash, Grep
---

# /analyze-oracle-script

## 0) Ziel
Erzeuge eine **maschinenlesbare** `.meta.yaml`, die als Source of Truth für nachgelagerte Skills dient:
- `/analyze-lineage`
- `/dependency-graph`
- `/migration-hint`
- `/translate-sql`
- `/export-entity-map`

## 1) Inputs
- Pfad zu einem Oracle Script (SQL*Plus typisch: PROMPT, DEFINE, SPOOL, WHENEVER, @@, &parameter).
- Optional (wenn verfügbar):
  - `<job>.params.yaml` (Parameterauflösung)
  - `<job>.preconditions.yaml` (Startbedingungen)

## 2) Ausgabe (Pflicht): `<job>.meta.yaml`
Du MUSST valides YAML ausgeben.

### 2.1 Top-Level Pflichtfelder
- `name`: string (job/script name)
- `type`: enum
  - `sqlplus_script` (wenn SQL*Plus Konstrukte vorhanden)
  - `procedure|view|trigger|function` (wenn eindeutig)
  - `unknown`
- `source_tables[]`: list[string]
- `target_tables[]`: list[string]
- `lookup_tables[]`: list[object]
- `cleanse_tables[]`: list[string] (falls erkennbar)
- `finale_cleanse_table`: string|null (falls erkennbar)
- `db_links[]`: list[string] (aus @DBL_... oder TABLE@DBLINK)
- `parameters[]`: list[object]
- `package_functions[]`: list[object]
- `sections[]`: list[object]
- `steps[]`: list[object]
- `load_pattern`: enum (`full_reload|incremental_merge|append_only|unknown`)
- `merge_keys[]`: list[string] (nur wenn load_pattern incremental_merge oder MERGE erkannt)
- `warnings[]`: list[object]

### 2.2 execution_context (v5.1)
Ziel: Hinweise zur Einbettung in Scheduling/DSV/GBV.

- `execution_context`:
  - `suspected_jobs[]`: list[string]
    - Fülle nur, wenn im Script klare Job-/Scheduler-Hinweise vorkommen (DBMS_SCHEDULER, RUN_JOB, job_name, bekannte Prozessnamen).
  - `invocation_hints[]`: list[string]
    - Z.B. "expects DSV substitution for @D(T), @S(T)" oder "reads GBV run id".
  - `db_links[]`: list[string] (redundant erlaubt; zusätzlich zu top-level db_links)

Wenn keine Hinweise ableitbar sind: `execution_context: { suspected_jobs: [], invocation_hints: [], db_links: [] }`.

### 2.3 parameters[]
Erkenne alle `&...` Substitutionen.

Schema je Parameter:
- `name`: string (z.B. termin, datum, vtsaison; wenn nicht ableitbar: raw token)
- `raw`: string (exakt wie im Script, z.B. "&termin", "&30")
- `usage_count`: number
- `kind`: enum (`runtime_param|dsv_param_id|dynamic_table_token|unknown`)

### 2.4 lookup_tables[] (Origin + Effort)
- `lookup_tables[]` enthält Objekte:
  - `name`: string
  - `origin`: enum (`code_generator|manually_crafted|unknown`)
  - `migration_effort_modifier`: enum (`low|medium|high|unknown`)
  - `reason`: string (kurz)

Wenn origin nicht ableitbar ist: setze `origin: unknown` und schreibe einen Eintrag in `decisions_needed[]`.

### 2.5 columns[] vs tracked_columns[] (MVP Scope)
Ziel: MVP-Scope auf Spaltenebene.

- Wenn du eine vollständige Target-Spaltenliste sicher ableiten kannst (INSERT/MERGE Spaltenliste): verwende `columns[]`.
- Wenn nicht: verwende `tracked_columns[]` als MVP-Minimum.

Schema je Column:
- `name`: string
- `mvp_scope`: boolean
- `mvp_scope_reason`: string (Pflicht, wenn mvp_scope=false; sonst optional)
- `classification_hint`: enum (`id_key|dim_key|metric|flag|other|unknown`)
- `risk_flags[]`: list[string] (optional; z.B. integer_division_risk, pkg_dependency)

### 2.6 dimension_keys[] (compound_fk)
- `dimension_keys[]` enthält Objekte:
  - `dimension`: string
  - `type`: enum (`simple_fk|compound_fk`)
  - `columns[]`: list[string]
  - `join_notes`: string (optional)

### 2.7 package_functions[] (PKG Contract)
- `package_functions[]` enthält:
  - `package`: string
  - `function`: string
  - `params`: string|null
  - `usage_count`: number
  - `migration_strategy`: enum (`lookup_join|spark_udf|ignore|unknown`)

### 2.8 sections[] und steps[]
- `sections[]`:
  - `id`: string
  - `title`: string
  - `mvp_in_scope`: boolean
  - `notes`: string|null
- `steps[]`:
  - `id`: string
  - `name`: string
  - `section_id`: string
  - `sources[]`: list[string]
  - `target`: string|null
  - `logic`: string
  - `mvp_in_scope`: boolean

## 3) Heuristiken / Regeln
- SQL*Plus Erkennung: PROMPT/DEFINE/@@/SPOOL/WHENEVER/SET/EXIT → type=sqlplus_script.
- DB Links: `@DBL_...` (DSV) und `TABLE@DBLINK` (Oracle) müssen beide erfasst werden.
- Self-Reference: wenn eine Target-Tabelle auch Source ist → Warning.
- Wenn MERGE erkannt → load_pattern=incremental_merge und merge_keys extrahieren oder decisions_needed.

## 4) Failure Handling
- Unklare Ableitungen NICHT raten.
- Stattdessen:
  - setze Felder auf `unknown`/leer
  - schreibe `warnings[]`
  - schreibe `decisions_needed[]`

## 5) Output-DoD (Definition of Done)
- YAML ist valide.
- type ist korrekt.
- sections[] + steps[] existieren (bei sqlplus scripts).
- columns[] oder tracked_columns[] existiert und enthält MVP Scope.
- lookup_tables[] enthält origin oder decisions_needed.

## 6) Ausgabeformat
Gib ausschließlich YAML (kein zusätzlicher Fließtext außerhalb des YAML), wenn das Tooling die Ausgabe direkt persistiert.