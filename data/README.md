# Data Directory

Place tab-delimited genomics annotation / feature files here (e.g. BED, GFF3, TSV, CSV). Rendering the Quarto site (`quarto render quarto/`) populates the table on `quarto/data.qmd`.

Optional: Add per-file metadata by creating a YAML sidecar named `<filename>.yml` containing key-value pairs (e.g. description, organism, source).

Example sidecar (`genes.gff3.yml`):

```
description: High-confidence gene models
organism: Example species
source: Ensembl v110
```
