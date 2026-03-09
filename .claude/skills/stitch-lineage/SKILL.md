---
name: stitch-lineage
version: v5.1
description: "Verbinde Einzel-Lineages mehrerer Scripts zu einer End-to-End Column-Lineage. Output: <cc_object>.stitched_lineage.yaml + .mmd"
argument-hint: "<cc_object>"
allowed-tools: Read, Write, Grep, Glob
---

# /stitch-lineage

## 0) Ziel
Die Einzel-Skills (`/analyze-lineage`) liefern Lineage **pro Script**.
Dieser Skill verbindet alle Einzel-Lineages zu einer **durchgehenden Kette**:

```
ORACLE_RAW.SC_BUCHUNG.buchbetrag
  → sc_ww_buchung.sql (Section 2)
    → sc_ww_buchung.buchbetrag
      → cc_ww_buchung.sql (Section 1.1)
        → cc_buchung.buchbetrag
```

Ergebnis: Für jede Zielspalte in `<cc_object>` ist die vollständige Herkunft
aus den Oracle-Rohtabellen nachvollziehbar.

## 1) Inputs
Pflicht:
- `analysis-output/<cc_object>/<cc_script>.lineage.yaml`
  (z.B. `cc_ww_buchung.lineage.yaml` – die finale CC-Script-Lineage)

Optional (je mehr, desto vollständiger die Kette):
- `analysis-output/<cc_object>/<sc_script>.lineage.yaml`
  (z.B. `sc_ww_buchung.lineage.yaml`, `sc_ww_auftrag_2.lineage.yaml` ...)
- `analysis-output/<cc_object>/<cc_script>.meta.yaml`
  (für Script-Reihenfolge und Tabellen-zu-Script-Mapping)

Vorgehen:
1. Lese alle verfügbaren `*.lineage.yaml` aus `analysis-output/<cc_object>/`
2. Lese alle verfügbaren `*.meta.yaml` aus `analysis-output/<cc_object>/`
3. Baue intern eine Tabellen-Index-Map: `table_name → script_name`
   (welches Script schreibt welche Tabelle laut target_tables in meta.yaml)

## 2) Output
Output-Verzeichnis: `analysis-output/<cc_object>/`

Datei 1: `<cc_object>.stitched_lineage.yaml`
Datei 2: `<cc_object>.stitched_lineage.mmd` (Mermaid End-to-End DAG)

## 3) YAML Schema (v5.1)
```yaml
schema_version: "stitched_lineage_v5_1"
target_object: string          # z.B. "cc_buchung"
cc_script: string              # z.B. "cc_ww_buchung.sql"
scripts_included: [string]     # alle lineage.yaml die gelesen werden konnten
scripts_missing: [string]      # Scripts die fehlen (keine lineage.yaml vorhanden)

chains[]:                      # Eine Chain pro Zielspalte in target_object
  - target_column: string      # z.B. "cc_buchung.buchbetrag"
    chain[]:                   # Vom Ziel zurück zur Rohquelle (Top-Down dargestellt)
      - script: string         # z.B. "cc_ww_buchung.sql"
        section_id: string|null
        expression: string     # kurz, aus lineage.yaml übernehmen
        classification: pass_through|computed|computed_with_pkg|complex_case|unknown
        risk_flags: [string]
      - script: string         # z.B. "sc_ww_buchung.sql"
        section_id: string|null
        expression: string
        classification: ...
        risk_flags: [string]
    raw_sources[]: [string]    # Endpunkte: Oracle-Rohtabellen (kein upstream mehr)
    chain_length: number       # Anzahl Script-Stufen
    chain_complete: boolean    # true wenn bis zur Rohquelle zurückverfolgbar
    risk_flags: [string]       # Union aller risk_flags aus der Chain

data_loss[]:                   # Spalten die in einem SC-Script vorhanden sind,
                               # aber nicht in cc_object ankommen
  - column: string             # z.B. "sc_ww_buchung.alt_feld"
    last_seen_in: string       # Script-Name wo die Spalte zuletzt vorkommt
    reason: string|null        # "not mapped" | "filtered" | unknown

pkg_black_boxes[]:             # Package-Calls die nicht aufgelöst werden können
  - package: string            # z.B. "PKG_IM_VERTRIEBSGEBIET"
    affects_columns: [string]  # Zielspalten die von diesem Package abhängen
    classification: pkg_dependency
    note: string               # Handlungsempfehlung (Lookup Join? UDF? Manual?)

unresolved[]:                  # Spalten wo die Kette abbricht (kein lineage.yaml)
  - target_column: string
    blocked_at_table: string   # Tabelle wo die Kette abbricht
    blocked_at_script: string|null  # Script das fehlt
    reason: string             # "lineage.yaml missing" | "pkg_dependency" | unknown

warnings[]:
  - code: string               # MISSING_LINEAGE, DATA_LOSS, PKG_BLACK_BOX,
                               # CHAIN_INCOMPLETE, UNKNOWN_SOURCE, CYCLE_DETECTED
    message: string
    severity: high|medium|low
    evidence: string
    action: string
```

## 4) Stitch-Algorithmus
Für jede Zielspalte `col` in `<cc_object>`:

```
1. Suche col in cc_script.lineage.yaml → finde sources[]
2. Für jede source in sources[]:
   a. Ist source eine Rohtabelle (kein Script schreibt sie laut table_index)?
      → raw_sources[] += source, chain_complete = true für diesen Pfad
   b. Ist source eine Zwischentabelle (ein SC-Script schreibt sie)?
      → suche source.column in sc_script.lineage.yaml
      → rekursiv weiter (max. 10 Ebenen, dann CHAIN_TOO_DEEP Warning)
   c. Ist source ein PKG_CALL?
      → pkg_black_boxes[] + risk_flags += pkg_dependency
   d. Kein lineage.yaml für das upstream-Script?
      → unresolved[] + Warning MISSING_LINEAGE
3. chain_complete = true nur wenn alle Pfade bis zur Rohquelle zurückverfolgt
```

## 5) Mermaid DAG
`<cc_object>.stitched_lineage.mmd` zeigt:
- Knoten: Rohtabellen (links) → SC-Scripts → Zwischentabellen → CC-Script → Zieltabelle (rechts)
- Kanten: Datenfluß mit Spaltengruppen als Label (aggregiert, nicht jede Spalte einzeln)
- Farb-Konvention (Kommentar im MMD):
  - Rohtabellen: neutral
  - SC-Scripts: blau
  - CC-Script: grün
  - PKG Black Boxes: rot
  - Missing/Unresolved: gestrichelt

```
flowchart LR
  RAW_SC_BUCHUNG["SC_BUCHUNG\n(Oracle Raw)"]
  sc_buchung["sc_ww_buchung.sql"]
  sc_auftrag["sc_ww_auftrag_2.sql"]
  cc_buchung_script["cc_ww_buchung.sql"]
  cc_buchung["cc_buchung\n(Ziel)"]
  pkg["PKG_IM_VERTRIEBSGEBIET\n⚠ Black Box"]

  RAW_SC_BUCHUNG --> sc_buchung
  sc_buchung --> cc_buchung_script
  sc_auftrag --> cc_buchung_script
  pkg -. "vtg, firma_cc" .-> cc_buchung_script
  cc_buchung_script --> cc_buchung
```

## 6) No-Guessing
- Kein Erfinden von Quellen: wenn lineage.yaml fehlt → unresolved[] + Warning
- Kein Erfinden von Transformationen: expression aus lineage.yaml 1:1 übernehmen
- PKG-Calls nie auflösen → immer als pkg_black_box markieren
- chain_complete: false wenn irgendein Pfad nicht bis zur Rohquelle reicht

## 7) Abgrenzung zu anderen Skills

| Skill | Scope |
|---|---|
| `/analyze-lineage` | Column-Lineage **innerhalb** eines Scripts |
| `/dependency-graph` | Job-Reihenfolge (welcher Job vor welchem) |
| `/stitch-lineage` | End-to-End Column-Lineage **über alle Scripts** |

`/stitch-lineage` **konsumiert** die Outputs von `/analyze-lineage`.
Es ersetzt keinen dieser Skills, sondern baut darauf auf.

## 8) Voraussetzungen (Definition of Ready)
Vor dem Aufruf sollten vorhanden sein:
- [ ] `cc_ww_<object>.lineage.yaml` (Pflicht)
- [ ] Mindestens eine `sc_ww_*.lineage.yaml` (sonst nur unresolved[])
- [ ] `cc_ww_<object>.meta.yaml` (für Tabellen-Index)

## 9) Definition of Done
- [ ] YAML valide, schema_version = "stitched_lineage_v5_1"
- [ ] chains[] enthält alle Zielspalten aus cc_script.lineage.yaml
- [ ] chain_complete = true wo möglich, false + unresolved[] wo nicht
- [ ] pkg_black_boxes[] für alle PKG-Calls
- [ ] data_loss[] gefüllt wenn SC-Spalten nicht in Ziel ankommen
- [ ] Mermaid DAG valide, zeigt Script-Grenzen klar
- [ ] warnings[] für jede Lücke

## 10) Output Format
1. ```yaml  (stitched_lineage.yaml)```
2. ```mermaid  (stitched_lineage.mmd)```
Kein Fließtext außerhalb der Blöcke.
