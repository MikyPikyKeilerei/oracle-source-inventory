# ORACLE-SOURCE-INVENTORY

## Projekt
Oracle → Databricks Lean Data Vault (LDV) Migration.
Analyse und Transformation von Oracle SQL*Plus DSV-Scripts
für den MVP-Durchstich "Ansprachemenge" (KPI).

## Ziel-Architektur
- Bronze: 1:1 Abbild der Oracle SC_* / CC_* Tabellen (via Lakehouse Federation oder JDBC)
- Silver: Lean Data Vault (Hubs, Links, Satellites) mit Business Keys
- Gold: Materialized Views / Delta Tables für Power BI (eCAT-Dashboards)

## Ordnerstruktur
- `.claude/skills/<name>/SKILL.md` – Skill-Definitionen (v5.1), NICHT manuell editieren
- `exports/`                        – Toad CSV-Exports (DSV Metadaten, READ-ONLY)
- `analysis-output/<cc-objekt>/`    – Skill-Outputs (meta, lineage, params, mermaid)
- `scripts/`                        – Oracle SQL*Plus Quell-Scripts
- `jobs/`                           – Job-Definitionen
- `pdfs/`                           – Dokumentation / Confluence-Exports
- `test/`                           – Test-Daten / Validierung

## Skills (v5.1) – Pipeline-Reihenfolge
Alle Skills liegen unter `.claude/skills/`. Reihenfolge beachten:
1. `/analyze-oracle-script` → <job>.meta.yaml (Sections, Tables, Params)
2. `/resolve-dsv-params`    → <job>.params.yaml (Runtime-Parameter)
3. `/extract-start-conditions` → <job>.preconditions.yaml (Upstream-Abhängigkeiten)
4. `/dependency-graph`      → Mermaid DAG (Job-Reihenfolge)
5. `/analyze-lineage`       → <job>.lineage.yaml + .lineage.mmd (Column-Lineage)
6. `/migration-hint`        → <job>.migration_hints.md (Oracle→Spark Hinweise)
7. `/translate-sql`         → Spark SQL / PySpark (lauffähiger Code)
8. `/export-entity-map`     → JSON für Notion-DB Import

## Zentrale CC-Objekte (MVP)
- `cc_ww_kunde` – Kundenstamm (8 Quelltabellen, ~30 Referenz-Joins, 7 Stufen)
- `cc_ww_buchungen` – Buchungen (1 Quelltabelle, ÷100-Pattern, 27 Sections)

## Konventionen
- Outputs IMMER unter `analysis-output/<cc-objekt>/` ablegen
- Dateinamen: `<job-name>.<artefakt-typ>` (z.B. `clcc_ww_kunde_1.meta.yaml`)
- CSV-Exports unter `exports/` sind Input-Daten – NIEMALS verändern
- Skill-Specs (Source of Truth) liegen in Notion: Skill Specs (Notion SoT)

## Offline-Modus (WICHTIG)
Kein JDBC/MCP-Zugriff auf Oracle verfügbar. Stattdessen:
- DSV-Metadaten aus `exports/*.csv` lesen (dsv_param_pool, dsv_job, dsv_bed_pool, dsv_job_bed, cc_saison)
- Scripts aus `scripts/` lesen
- Ergebnisse in `analysis-output/` schreiben
- KEINE Oracle-Queries versuchen!

## Bekannte Pitfalls (bei Analyse beachten)
- B1: ÷100 Ganzzahldivision bei 13 Mengenfeldern → Spark: /100.0 verwenden
- B2: PKG_IM_VERTRIEBSGEBIET blockiert 10 grüne Felder → als pkg_dependency markieren
- K1: cc_kunde Join 4 (kdfirmkz→firma) + Dirty-Filter + Dedup beachten
- K2: &termin / &vtsaison sind Runtime-Parameter, NICHT hardcoden

## Anti-Halluzination
- Wenn Abhängigkeiten nicht eindeutig aus dem Code lesbar: als Unsicherheit markieren
- Wenn Mapping unklar: classification = unknown, sources = [], Warning erzeugen
- KEINE Quellen, Tabellennamen oder Spaltennamen erfinden
