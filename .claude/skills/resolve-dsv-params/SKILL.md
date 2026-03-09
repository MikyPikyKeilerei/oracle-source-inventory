---
name: resolve-dsv-params
version: v5.1
description: "Löse DSV-Parameter deterministisch auf. Output: <name>.params.yaml"
argument-hint: "<JOB_ID> [<BAJ_TERMIN>]"
allowed-tools: Read, Write, Bash
---

# /resolve-dsv-params

## Ziel
Löse alle &-Parameter eines Oracle/DSV-Scripts in konkrete Werte auf.
Dokumentiere Auflösungslogik, Confidence und Unsicherheiten.

## Inputs
- Oracle Script mit &-Parametern (Pflicht)
- Optional: DSV-Metadaten (BAJ_TERMIN, Job-ID)
- Optional: <name>.meta.yaml (aus /analyze-oracle-script)

## Output
Datei: <name>.params.yaml
Verzeichnis: analysis-output/<job_name>/

## Schema
Top-Level:
  schema_version: "params_v5_1"  # Pflicht, exakt dieser Wert
  job_name: string
  job_id: string|null
  baj_termin: string|null

parameters[]: (Pflicht, ein Eintrag pro &-Parameter)
  name: string                   # z.B. "termin"
  raw: string                    # exakt wie im Script, z.B. "&termin"
  resolved_value: string|null
  resolution_source: dsv_metadata|script_define|csv_lookup|heuristic|unknown
  confidence: high|medium|low
  usage_count: number
  kind: runtime_param|dsv_param_id|dynamic_table_token|unknown
  notes: string|null

kind-Regeln:
- runtime_param: &-Parameter in WHERE/SET/Expressions
- dsv_param_id: numerisch (z.B. &30) mit DEFINE-Kontext
- dynamic_table_token: &-Parameter in FROM/JOIN als Teil eines Tabellennamens
  (z.B. FROM cc_kunde_&vtsaison)
- unknown: nicht zuordenbar -> decisions_needed[]

decisions_needed[]: (Pflicht wenn Unsicherheiten)
  id: string                     # z.B. "PARAM_RESOLVE:vtsaison_value"
  question: string
  impact: p0_blocker|p1_quality|p2_scope
  status: open|resolved|superseded
  evidence: string|null

missing_sources[]: (Pflicht wenn Quellen fehlen)
  source: string                 # z.B. "DSV DB Grant"
  reason: string
  fallback_available: boolean
  evidence: string|null

warnings[]: (Pflicht)
  code: string                   # z.B. HEURISTIC_RESOLUTION, UNRESOLVED_PARAM, PARAM_CONFLICT, PARAM_MISMATCH
  message: string
  severity: high|medium|low
  evidence: string
  action: string

## Resolution Priority
Bei Konflikten (selber Parameter, mehrere Quellen) gilt:
1. script_define  -> confidence: high
2. dsv_metadata   -> confidence: high
3. csv_lookup     -> confidence: medium
4. heuristic      -> confidence: low + decisions_needed[]

Höherpriorer Wert gewinnt. Erzeuge Warning PARAM_CONFLICT mit evidence beider Werte.
Setze confidence = min(beide Quellen).

Nicht auflösbar -> resolved_value: null, Warning UNRESOLVED_PARAM + decisions_needed[].

## meta.yaml Abgleich
Wenn <name>.meta.yaml vorhanden:
- Prüfe: Alle meta.yaml parameters[] auch hier erfasst?
- Prüfe: kind stimmt überein?
- Diskrepanz -> Warning PARAM_MISMATCH

## No-Guessing
- Kurzbezeichnung nicht eindeutig -> decisions_needed[] (NICHT raten)
- DB-Grant + CSV fehlen -> missing_sources[] + Warning
- Numerische Parameter ohne DEFINE -> kind: unknown + decisions_needed[]

## Definition of Done
- [ ] YAML valide
- [ ] schema_version = "params_v5_1"
- [ ] Alle &-Parameter erfasst mit resolution_source + confidence
- [ ] decisions_needed[] pro unsicherer Auflösung
- [ ] missing_sources[] pro fehlender Datenquelle
- [ ] warnings[] einheitliches Schema
- [ ] Output: <name>.params.yaml
- [ ] meta.yaml Abgleich (wenn vorhanden)

## Output-Format
Nur YAML. Kein Fließtext.