---
name: dependency-graph
version: v5.1

description: >
  Erzeuge einen Dependency Graph (Mermaid) aus meta/params/preconditions.
  v5.1 ergänzt migration_order, cycles und external_dependencies.

argument-hint: "[job_name]"
allowed-tools: Read, Write, Grep, Glob
---

# /dependency-graph

## 0) Ziel
- Liefere ein Mermaid-DAG für Orchestrierung/Review.
- Liefere eine YAML Summary (v5.1: Pflicht) für Migration Order, Cycles, External Deps.
- Missing Artifacts bleiben als blocking nodes sichtbar.

## 1) Inputs
- `<job>.meta.yaml` (Pflicht)
- Optional:
  - `<job>.preconditions.yaml`
  - `<job>.params.yaml`

## 2) Output
Output-Verzeichnis: `analysis-output/<job_name>/`

### 2.1 Mermaid (Pflicht)
Datei: `<name>.graph.mmd`
- Ein `mermaid` Block (flowchart TD)
- Node Typen sollten erkennbar sein:
  - sources, lookups, gates, stages, targets, packages, missing_artifacts

### 2.2 YAML Summary (Pflicht in v5.1)
Datei: `<name>.graph.yaml`
Top-Level:
- `schema_version: "dependency_graph_v5_1"`
- `job_name`
- `nodes_count`
- `edges_count`
- `migration_order[]`: [{ level, items[] }]
- `cycles[]`: [{ type, nodes[], note }]
- `external_dependencies[]`: [{ type, reference, note, evidence }]
- `blocking[]`: list[string] (missing artifacts ids)
- `blocking_count`: number
- `blocking_severity`: enum (`p0|p1|unknown`)
- `warnings[]`: [{ code, message, severity, action }]
#### migration_order[].items[] Normalisierung
Jedes Item muss typisiert sein:
- `TABLE:<schema.table>`
- `JOB:<job_name>`
- `SCRIPT:<script_name>`

Stable Sort innerhalb eines Levels:
1. Primär nach Typ-Prefix: `JOB` < `SCRIPT` < `TABLE`
2. Sekundär alphabetisch nach `<name>` (case-insensitive)

Beispiel Level 2:
```
- JOB:cc_ww_buchung
- SCRIPT:clcc_ww_buchung_19
- TABLE:sc_ww_buchung
- TABLE:sc_ww_kundenfirma
```

## 3) Regeln
- DSV-Preconditions sind autoritativ → als Gate-Nodes darstellen.
- Script-abgeleitete Abhängigkeiten (FROM/JOIN) sind sekundär → ggf. gestrichelt.
- Missing Artifacts:
  - Wenn meta.yaml `missing_artifacts[]` enthält: als Nodes mit `blocking: true` darstellen.
- Cycles:
  - Self-Read+Write oder gegenseitige Writes als cycle markieren.
  - cycle type als enum: `self_reference|mutual_write|merge_self|unknown`.
- External dependencies:
  - Types: `db_link|dsv_dbl_placeholder|federation|file|unknown`.
  - evidence muss den Token/Snippet enthalten, der zur Erkennung geführt hat.

## 4) Definition of Done
- Exakt 2 Blöcke: mermaid + yaml.
- Mermaid ist valide.
- YAML Summary ist valide.
- migration_order ist deterministisch (stable sort innerhalb level).
- blocking nodes sind sichtbar und blocking_count ist korrekt.

## 5) Output Format
1) ```mermaid ...```
2) ```yaml ...```