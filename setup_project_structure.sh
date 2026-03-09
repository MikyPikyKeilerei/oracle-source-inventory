#!/usr/bin/env bash
set -euo pipefail

# ══════════════════════════════════════════════════════════════
# Setup: ORACLE-SOURCE-INVENTORY Projektstruktur + Skills v5.1
# Erstellt: 2026-03-09
# ══════════════════════════════════════════════════════════════

BASE_DIR="${1:-.}"
SKILLS_DIR="$BASE_DIR/.claude/skills"
EXPORTS_DIR="$BASE_DIR/exports"
OUTPUT_DIR="$BASE_DIR/analysis-output"

echo "═══════════════════════════════════════════════════════"
echo "  ORACLE-SOURCE-INVENTORY – Projektstruktur Setup"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "Base: $BASE_DIR"
echo ""

# ──────────────────────────────────────────────────────────────
# 1) Skills-Ordner (.claude/skills/<skill-name>/SKILL.md)
# ──────────────────────────────────────────────────────────────
echo "📁 Erstelle Skills-Ordner unter $SKILLS_DIR/ ..."

SKILL_NAMES=(
  "analyze-oracle-script"
  "analyze-lineage"
  "resolve-dsv-params"
  "extract-start-conditions"
  "dependency-graph"
  "migration-hint"
  "translate-sql"
  "export-entity-map"
)

for skill in "${SKILL_NAMES[@]}"; do
  mkdir -p "$SKILLS_DIR/$skill"
  # Erstelle SKILL.md nur wenn noch nicht vorhanden
  if [[ ! -f "$SKILLS_DIR/$skill/SKILL.md" ]]; then
    cat > "$SKILLS_DIR/$skill/SKILL.md" << EOF
---
name: $skill
version: v5.1
description: TODO – Skill-Beschreibung aus Notion Skill Specs übernehmen
argument-hint: "[path/to/script.sql]"
allowed-tools: Read, Write, Grep
---

# /$skill

## TODO
SKILL.md Inhalt aus der Notion Skill Specs DB synchronisieren.
Siehe: Skill Specs (Notion SoT) → $skill → Active Spec → Full SKILL.md
EOF
    echo "  ✅ $skill/SKILL.md (neu erstellt)"
  else
    echo "  ⏭️  $skill/SKILL.md (existiert bereits, übersprungen)"
  fi
done

# ──────────────────────────────────────────────────────────────
# 2) Exports-Ordner (Toad CSV-Exports)
# ──────────────────────────────────────────────────────────────
echo ""
echo "📁 Erstelle Exports-Ordner unter $EXPORTS_DIR/ ..."
mkdir -p "$EXPORTS_DIR"

CSV_FILES=(
  "dsv_param_pool.csv"
  "dsv_bed_pool.csv"
  "dsv_job.csv"
  "dsv_job_bed.csv"
  "cc_saison.csv"
)

for csv in "${CSV_FILES[@]}"; do
  if [[ ! -f "$EXPORTS_DIR/$csv" ]]; then
    echo "  ⚠️  $csv fehlt – bitte via Toad exportieren"
  else
    echo "  ✅ $csv vorhanden"
  fi
done

# ──────────────────────────────────────────────────────────────
# 3) Analysis-Output (pro CC-Objekt)
# ──────────────────────────────────────────────────────────────
echo ""
echo "📁 Erstelle Analysis-Output Ordner unter $OUTPUT_DIR/ ..."

CC_OBJECTS=(
  "cc_ww_kunde"
  "cc_ww_buchungen"
)

for obj in "${CC_OBJECTS[@]}"; do
  mkdir -p "$OUTPUT_DIR/$obj"
  echo "  ✅ $obj/"
done

# ──────────────────────────────────────────────────────────────
# 4) Weitere Projektordner
# ──────────────────────────────────────────────────────────────
echo ""
echo "📁 Erstelle weitere Projektordner ..."

mkdir -p "$BASE_DIR/scripts"     # Oracle SQL*Plus Quell-Scripts
mkdir -p "$BASE_DIR/jobs"         # Job-Definitionen
mkdir -p "$BASE_DIR/pdfs"         # Dokumentation / Confluence-Exports
mkdir -p "$BASE_DIR/test"         # Test-Daten / Validierung
mkdir -p "$BASE_DIR/setup"        # Setup-Scripts (einmalig)

echo "  ✅ scripts/ jobs/ pdfs/ test/ setup/"

# ──────────────────────────────────────────────────────────────
# 5) CLAUDE.md (Projekt-Kontext für Claude Code)
# ──────────────────────────────────────────────────────────────
echo ""
if [[ ! -f "$BASE_DIR/CLAUDE.md" ]]; then
  echo "📝 Erstelle CLAUDE.md ..."
  cat > "$BASE_DIR/CLAUDE.md" << 'CLAUDE_EOF'
# ORACLE-SOURCE-INVENTORY

## Projekt
Oracle → Databricks LDV Migration. Analyse und Transformation von Oracle SQL*Plus
DSV-Scripts für den MVP-Durchstich "Ansprachemenge".

## Ordnerstruktur
- `.claude/skills/<name>/SKILL.md` – Claude Code Skill-Definitionen (v5.1)
- `exports/`                        – Toad CSV-Exports (DSV Metadaten)
- `analysis-output/<cc-objekt>/`    – Skill-Outputs (meta, lineage, params, mermaid)
- `scripts/`                        – Oracle SQL*Plus Quell-Scripts
- `jobs/`                           – Job-Definitionen
- `pdfs/`                           – Dokumentation / Confluence-Exports
- `test/`                           – Test-Daten / Validierung
- `setup/`                          – Einmalige Setup-Scripts

## Skills (v5.1)
Alle Skills liegen unter `.claude/skills/`. Pipeline-Reihenfolge:
1. `/analyze-oracle-script` → .meta.yaml
2. `/resolve-dsv-params`    → .params.yaml
3. `/extract-start-conditions` → .preconditions.yaml
4. `/dependency-graph`      → .mermaid (DAG)
5. `/analyze-lineage`       → .lineage.yaml + .lineage.mmd
6. `/migration-hint`        → .migration_hints.md
7. `/translate-sql`         → Spark SQL / PySpark
8. `/export-entity-map`     → JSON für Notion-DB Import

## Konventionen
- Outputs werden unter `analysis-output/<cc-objekt>/` abgelegt
- Dateinamen: `<job-name>.<artefakt-typ>` (z.B. `clcc_ww_kunde_1.meta.yaml`)
- CSV-Exports unter `exports/` sind Input-Daten, nicht verändern
- Skill-Specs (Source of Truth) liegen in Notion: Skill Specs (Notion SoT)

## Zentrale CC-Objekte (MVP)
- `cc_ww_kunde` – Kundenstamm (8 Quelltabellen, ~30 Referenz-Joins, 7 Stufen)
- `cc_ww_buchungen` – Buchungen (1 Quelltabelle, 27 Sections)

## Offline-Modus
Kein JDBC-Zugriff auf Oracle. Stattdessen:
- DSV-Metadaten aus `exports/*.csv` lesen
- Scripts aus `scripts/` lesen
- Ergebnisse in `analysis-output/` schreiben
CLAUDE_EOF
  echo "  ✅ CLAUDE.md erstellt"
else
  echo "⏭️  CLAUDE.md existiert bereits, übersprungen"
fi

# ──────────────────────────────────────────────────────────────
# 6) .gitignore Ergänzung
# ──────────────────────────────────────────────────────────────
echo ""
GITIGNORE="$BASE_DIR/.gitignore"
if [[ ! -f "$GITIGNORE" ]]; then
  echo "📝 Erstelle .gitignore ..."
  cat > "$GITIGNORE" << 'GIT_EOF'
# Exports (können sensible Daten enthalten)
exports/*.csv

# Claude Code Internals
.claude/settings.json

# OS
.DS_Store
Thumbs.db

# Temp
*.tmp
*.bak
GIT_EOF
  echo "  ✅ .gitignore erstellt"
else
  echo "⏭️  .gitignore existiert bereits, übersprungen"
fi

# ──────────────────────────────────────���───────────────────────
# Zusammenfassung
# ──────────────────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════"
echo "  ✅ Setup abgeschlossen!"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "Struktur:"
echo "  $BASE_DIR/"
echo "  ├── .claude/skills/        (${#SKILL_NAMES[@]} Skills)"
echo "  ├── exports/               (${#CSV_FILES[@]} CSVs erwartet)"
echo "  ├── analysis-output/       (${#CC_OBJECTS[@]} CC-Objekte)"
echo "  ├── scripts/"
echo "  ├── jobs/"
echo "  ├── pdfs/"
echo "  ├── test/"
echo "  ├── setup/"
echo "  ├── CLAUDE.md"
echo "  └── .gitignore"
echo ""
echo "Nächste Schritte:"
echo "  1. SKILL.md-Inhalte aus Notion Skill Specs (v5.1) synchronisieren"
echo "  2. Toad CSV-Exports nach exports/ kopieren"
echo "  3. Oracle Scripts nach scripts/ kopieren"
echo "  4. Dieses Script nach setup/ verschieben"
echo "  5. Loslegen: /analyze-oracle-script scripts/<job>.sql"
