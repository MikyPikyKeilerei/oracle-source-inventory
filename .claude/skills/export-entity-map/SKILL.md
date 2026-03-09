---
name: export-entity-map
version: v5.1

description: >
  Generiere ein flaches JSON-Objekt (oder JSON-Array) für Notion/Jira-Import aus den Analyse-Artefakten.
  v5.1 erzwingt Traceability: runtime_contract_summary, migration order summary, check counts,
  kanonische IDs, completeness_percent und striktes No-Guessing.

argument-hint: "[path/to/script.sql]"
allowed-tools: Read, Write
---

# /export-entity-map

## 0) Ziel
- Erzeuge ein exportierbares JSON, das pro Job die wichtigsten Fakten für Planung/Migration enthält.
- Das JSON muss stabil genug sein, um es automatisiert in Notion/Jira zu importieren.
- Liefere einen deterministischen completeness_percent Score.

## 1) Inputs (v5.1)
Du MUSST versuchen, folgende Dateien zu lesen (wenn sie fehlen: warnings, aber kein Raten).
<name> = Input-Dateiname ohne Extension (konsistent mit allen anderen Skills).

Pflicht-Inputs:
- <name>.meta.yaml (Gewicht: 30%)
- <name>.lineage.yaml (Gewicht: 20%)

Optionale Inputs (mit Gewicht für completeness_percent):
- <name>.preconditions.yaml (Gewicht: 15%)
- <name>.mermaid.md ODER dependency_graph.yaml aus /dependency-graph (Gewicht: 20%)
- <name>.migration_hints.md aus /migration-hint (Gewicht: 15%)

Output-Verzeichnis: analysis-output/<job_name>/ (wie alle anderen Skills)

## 2) Output (Pflicht)
- Datei: <name>.entity_map.json
- Pattern: <name>.<skill-suffix>.<extension> (identisch zu .meta.yaml, .translated.sql etc.)
- Format: JSON (ein Objekt). Wenn mehrere Jobs gebündelt werden: Array, jedes Element nach gleichem Schema.

## 3) Fixes JSON Schema (v5.1)
Top-Level Pflichtfelder:
- schema_version: "entity_map_v5_1"
- job_name: string
- job_id: string|null
- source_tables[]: string[]
- target_tables[]: string[]
- load_pattern: string
- merge_keys[]: string[]
- completeness_percent: number (0-100, deterministisch berechnet)

### 3.1 runtime_contract_summary (Pflicht)
- runtime_contract_summary:
  - termin:
      format: string|null          # z.B. "YYYYMMDD", "YYYY-MM-DD" – aus params.yaml ableiten
      timezone: string|null        # z.B. "Europe/Berlin", null wenn nicht erkennbar
      as_of_semantics: string|null # z.B. "processdate", "load_date", "snapshot_date"
  - vtsaison_handling: enum (rotation|season_column|single_table|unknown)
      # rotation: vtsaison/vtsaisonm1/vtsaisonp1 als Parameter
      # season_column: Saison als Tabellenspalte
      # single_table: keine Saisonsteuerung erkennbar
      # unknown: nicht ableitbar → Warning MISSING_RUNTIME_CONTRACT

### 3.2 migration_order_summary (Pflicht)
- migration_order_summary:
  - level: number|null
  - upstream_count: number|null
  - external_dependency_count: number|null
  - blocking_count: number
  - blocking_severity: enum (p0|p1|unknown)

### 3.3 checks_summary (Pflicht)
- checks_summary:
  - p0_check_count: number
  - decision_count_open: number

### 3.4 canonical ids (Pflicht)
- missing_artifacts[]: string[] (nur kanonische IDs, z.B. MISSING:...)
- decisions_needed[]: string[] (nur kanonische IDs, z.B. DECISION:... oder IDs aus migration-hint)
- p0_checks[]: string[] (nur kanonische IDs, z.B. P0:...)

Regel:
- Wenn ein Eintrag nicht in kanonischer Form vorliegt -> warnings[] Eintrag.

### 3.5 warnings[] (Pflicht, einheitliches Schema)
- warnings[]: [{ code, message, severity, evidence, action }]
- severity: enum (high|medium|low)
- action: string (empfohlene nächste Aktion)
- Konsistent mit translate-sql und allen anderen Skills.

### 3.6 completeness_percent (Pflicht)
Deterministische Formel:

artefact_weights:
  meta.yaml:           30
  lineage.yaml:        20
  preconditions.yaml:  15
  dependency-graph:    20
  migration-hint:      15

completeness_percent = Summe(Gewicht aller vorhandenen Artefakte)

Beispiele:
- Alle 5 vorhanden: 100%
- meta + lineage + dependency-graph: 70%
- Nur meta: 30%

Regel: completeness_percent spiegelt nur Artefakt-Verfügbarkeit, nicht Datenqualität.

## 4) No-Guessing Regeln
- Wenn dependency-graph summary fehlt -> setze migration_order_summary.level=null + Warning MISSING_DEP_GRAPH_SUMMARY.
- Wenn migration-hint summary fehlt -> Warning MISSING_MIGRATION_HINT_SUMMARY.
- Wenn runtime contract nicht ableitbar -> setze unknown + Warning MISSING_RUNTIME_CONTRACT.
- Wenn preconditions fehlt -> Warning MISSING_PRECONDITIONS.
- Erfinde KEINE IDs, Zahlen oder Fakten ohne Evidence aus den Input-Artefakten.

## 5) Definition of Done
Checks (alle müssen erfüllt sein):
- [ ] JSON parst ohne Fehler (valides JSON)
- [ ] schema_version = "entity_map_v5_1"
- [ ] Alle Pflichtfelder vorhanden (ggf. null + Warning)
- [ ] Keine kanonische ID ohne MISSING:, DECISION: oder P0: Prefix
- [ ] warnings[] enthält einen Eintrag pro fehlendem Artefakt
- [ ] migration_order_summary.blocking_count >= Anzahl p0_checks[]
- [ ] completeness_percent ist deterministisch gesetzt (Formel aus 3.6)
- [ ] Output-Datei folgt <name>.suffix Konvention
Out of Scope:
- JSON Schema Validierung gegen ein formales Schema (wäre separater Schritt)
- Semantische Prüfung der canonical IDs gegen externe Systeme

## 6) Output Format
Gib nur JSON aus (kein Fließtext).