---
name: extract-start-conditions
version: v5.1
description: "Extrahiere DSV-Startbedingungen (Gates, Concurrency). Output: <name>.preconditions.yaml"
argument-hint: "<JOB_ID>"
allowed-tools: Read, Write, Grep
---

# /extract-start-conditions

## Ziel
Extrahiere alle Startbedingungen / Preconditions eines DSV-Jobs.
Klassifiziere Gates nach Typ. Liefere Workflow-Implementierungshinweise.

## Inputs
- Oracle Script mit DSV-Preconditions (Pflicht)
- Optional: DSV-Metadaten (Job-ID, Scheduling-Info)
- Optional: <name>.meta.yaml (aus /analyze-oracle-script)

## Output
Datei: <name>.preconditions.yaml
Verzeichnis: analysis-output/<job_name>/

## Schema
Top-Level:
  schema_version: "preconditions_v5_1"  # Pflicht, exakt dieser Wert
  job_name: string
  job_id: string|null

gates[]: (Pflicht – ein Eintrag pro erkannter Precondition-Prüfung im Script)
  id: string                     # z.B. "GATE:data_available_kunde"
  type: data_gate|time_gate|manual_gate|concurrency_gate|unknown
  description: string
  source_table: string|null      # bei data_gate: welche Tabelle
  schedule_expression: string|null  # bei time_gate: Cron/DSV-Schedule
  blocking: boolean
  evidence: string               # Code-Snippet oder DSV-Referenz

gates[] Abgrenzung:
- gates[] = EXPLIZITE Precondition-Checks im Script (WHENEVER, IF-Prüfungen,
  DSV-Gate-Blöcke, Existenz-Checks vor Load)
- NICHT: indirekte Abhängigkeiten aus FROM/JOIN -> die gehören in upstream_dependencies[]
- Überlappung möglich: wenn eine Tabelle sowohl als Gate geprüft als auch in FROM genutzt wird
  -> Eintrag in BEIDEN Arrays + Warning GATE_UPSTREAM_OVERLAP

concurrency_policy: (Pflicht)
  type: serial|parallel|mutex|unknown
  max_parallel: number|null
  mutex_resource: string|null    # z.B. Tabellen-Lock
  evidence: string|null
  Wenn nicht erkennbar: { type: unknown, evidence: null } + Warning UNKNOWN_CONCURRENCY

upstream_dependencies[]: (Pflicht – indirekte Abhängigkeiten aus Script-Logik)
  job_name: string|null
  table_name: string|null
  dependency_type: data|scheduling|unknown
  evidence: string

decisions_needed[]: (Pflicht wenn Unsicherheiten)
  id: string                     # z.B. "GATE_TYPE:unknown_precondition_xyz"
  question: string
  impact: p0_blocker|p1_quality|p2_scope
  status: open|resolved|superseded
  evidence: string|null

warnings[]: (Pflicht)
  code: string                   # z.B. UNKNOWN_GATE_TYPE, UNKNOWN_CONCURRENCY, GATE_UPSTREAM_OVERLAP, GATE_MISMATCH
  message: string
  severity: high|medium|low
  evidence: string
  action: string

## Extraktionsregeln
- WHENEVER / IF-Checks / Existenz-Prüfungen -> gates[] mit type: data_gate
- Schedule / Zeitsteuerung / DBMS_SCHEDULER -> gates[] mit type: time_gate
- Manuelle Freigaben / Approval-Patterns -> gates[] mit type: manual_gate
- Mutex / Lock-Patterns / LOCK TABLE -> concurrency_policy mit type: mutex
- Unklare Patterns -> type: unknown + decisions_needed[]

## meta.yaml Abgleich
Wenn <name>.meta.yaml vorhanden:
- Prüfe: Sind gates[] konsistent mit meta.yaml sections[] (referenzieren gleiche Steps)?
- Prüfe: Stimmen upstream_dependencies[] mit meta.yaml source_tables[] überein?
- Diskrepanz -> Warning GATE_MISMATCH

## No-Guessing
- Gate-Typ nicht eindeutig -> type: unknown + decisions_needed[]
- concurrency_policy nicht ableitbar -> type: unknown + Warning
- Keine erfundenen Schedule-Expressions oder Job-Abhängigkeiten

## Definition of Done
- [ ] YAML valide
- [ ] schema_version = "preconditions_v5_1"
- [ ] Alle erkennbaren Preconditions in gates[] mit type + evidence
- [ ] concurrency_policy gesetzt (ggf. unknown + Warning)
- [ ] upstream_dependencies[] gefüllt (aus FROM/JOIN)
- [ ] decisions_needed[] pro unklarem Pattern
- [ ] warnings[] einheitliches Schema
- [ ] Output: <name>.preconditions.yaml
- [ ] meta.yaml Abgleich (wenn vorhanden)

## Output-Format
Nur YAML. Kein Fließtext.
