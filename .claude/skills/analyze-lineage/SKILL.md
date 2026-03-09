---
name: analyze-lineage
version: v5.1

description: >
  Erzeuge eine vollständige Spalten-Lineage (YAML + Mermaid) vom Oracle Script bis zur Zielstruktur.
  v5.1 härtet den Contract um Risk Flags (Pitfalls) und critical_patterns[] auf Job-Ebene.

argument-hint: "[path/to/script.sql]"
allowed-tools: Read, Write, Grep
---

# /analyze-lineage

## 0) Ziel
Aus einem Script (und optional meta/params) eine **maschinenlesbare Lineage** erzeugen, die:
- Reviewbar ist (Mermaid)
- Exportierbar ist (YAML)
- P0/Pitfall Checks strukturierbar macht (risk_flags)

## 1) Inputs
- Oracle SQL/SQL*Plus Script (Pflicht)
- Optional:
  - `<job>.meta.yaml` (aus /analyze-oracle-script)
  - `<job>.params.yaml` (Runtime Params)

## 2) Output (Pflicht)
Output-Verzeichnis: `analysis-output/<job_name>/`
Du MUSST exakt zwei Artefakte erzeugen:
1. `<name>.lineage.yaml` (YAML Block)
2. `<name>.lineage.mmd` (Mermaid Block)
Außerhalb dieser beiden Blöcke darf kein zusätzlicher Text stehen (damit Wrapper/Parsing deterministisch bleibt).

### 2.1 YAML Schema (v5.1)
Top-Level:
- `schema_version: "lineage_v5_1"`
- `job_name`: string
- `target_table`: string|null
- `runtime_params[]`: list[object]
- `columns[]`: list[object]
- `transformation_pattern_groups[]`: list[object]
- `critical_patterns[]`: list[object]
- `warnings[]`: list[object]

#### runtime_params[]
- `{ name, raw, kind }`
- kind: `RUNTIME_PARAM|DSV_PARAM_ID|UNKNOWN`

#### columns[]
Jede Target-Spalte, die im MVP/Contract relevant ist.
Harte Regel (v5.1):
- Wenn meta.yaml `tracked_columns[]` enthält, MUSS lineage `columns[]` mindestens diese tracked columns enthalten.
- Wenn meta.yaml eine vollständige `columns[]` enthält, darf lineage entweder volle Coverage liefern oder auf tracked reduzieren, muss dann aber eine Coverage-Angabe liefern.
Schema:
- `target`: string
- `sources[]`: list[string] (Spalten oder Params)
- `expression`: string (kurz, kein komplettes SQL nötig)
- `classification`: enum (`pass_through|computed|computed_with_pkg|complex_case|unknown`)
- `mvp_scope`: boolean (falls meta.yaml columns/tracked_columns verfügbar)
- `step_id`: string|null (Pflicht wenn `<job>.meta.yaml` vorhanden und steps referenzierbar)
- `section_id`: string|null (optional, wenn ableitbar)
- `risk_flags[]`: list[string]
  - mögliche Werte:
    - `integer_division_risk` (z.B. /100)
    - `pkg_dependency`
    - `complex_case_chain`
    - `head_ver_asof_join`
    - `multi_path_insert`
    - `dedup_required`
    - `dirty_filter_required`
Zusatzfelder (wenn reduziert):
- `coverage`: enum (`full|tracked_only`)
- `coverage_reason`: string|null

#### transformation_pattern_groups[] (v4.1 / Mitnahmeeffekt)
- `{ group_name, mitnahmeeffekt, base_field, pattern_signature, fields[] }`

#### critical_patterns[] (v5.1)
Ziel: Oracle-Konstrukte / Komplexitätsstellen sammeln.
- `{ pattern, location, risk_level, note }`
- `pattern` ist ein enum (controlled vocabulary), z.B.:
  - `PKG_CALL`, `EXECUTE_IMMEDIATE`, `CURSOR_LOOP`, `COMPLEX_CASE`, `DB_LINK`, `SQLPLUS`, `HEAD_VER_JOIN`, `MERGE`, `DYNAMIC_TABLE_NAME`
- risk_level: `low|med|high`
- location: `section:<id>` oder `step:<id>` oder `unknown`

#### warnings[] / decisions
- warnings Schema:
  - `{ code, message, severity, evidence, action }`
  - severity: `low|med|high`
  - action: kurzer Fix-Hinweis (z.B. "use /100.0", "add join-4 kundenfirma", "apply dirty-filter")

## 3) Regeln / Heuristiken
- Wenn `/ 100` oder `* 100` Muster erkannt wird: setze `risk_flags += integer_division_risk` und schreibe einen Warning „Spark integer division vermeiden ( /100.0 )“.
- Wenn PKG_CALL in Expression: classification = computed_with_pkg + `risk_flags += pkg_dependency`.
- Wenn CASE mit vielen Zweigen: classification = complex_case + `risk_flags += complex_case_chain`.
- Wenn head+_ver Join + termin Filter erkennbar: `risk_flags += head_ver_asof_join`.

## 4) Failure Handling
- Keine Vermutungen als Fakten ausgeben.
- Wenn Mapping unklar: `classification: unknown`, `sources: []`, Warning + ggf. critical_pattern.

## 5) Definition of Done
- Exakt 2 Blöcke: yaml + mermaid.
- YAML valide.
- critical_patterns[] gefüllt, wenn Oracle-spezifische Konstrukte sichtbar sind.
- risk_flags[] gesetzt, wenn Pitfalls erkennbar sind.

## 6) Output Format
Gib die zwei Blöcke in dieser Reihenfolge aus:
1) ```yaml ...```
2) ```mermaid ...```