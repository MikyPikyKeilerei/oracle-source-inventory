# Oracle Source Inventory

Analyse-Stand: in_progress
Ziel: Oracle Scripts + Jobs extrahieren, Abhängigkeiten dokumentieren, Migration nach Databricks vorbereiten.

## Struktur
- scripts/   → .sql + .meta.yaml pro Script/Prozedur/View
- jobs/       → .yaml + .deps.yaml pro Oracle Scheduler Job
- dependency_graph.yaml → Aggregierte Abhängigkeiten (generiert)
