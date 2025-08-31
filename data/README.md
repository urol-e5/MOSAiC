# Data Directory

Place tab-delimited genomics annotation / feature files here (e.g. BED, GFF3, TSV, CSV). Rendering the Quarto site (`quarto render quarto/`) populates the table on `quarto/data.qmd`.

## Sample ITS Data Files

The following sample files are included for demonstration of the ITS data page:

- `sample_apul_its1.csv` - ITS1 sequence count data for Acropora pulchra across time points
- `sample_apul_its2.csv` - ITS2 sequence count data for Acropora pulchra across time points
- `sample_apul_taxonomy.csv` - Taxonomic assignments for ITS sequences

These files demonstrate the format expected for ITS data and include samples across 4 time points (TP1-TP4) as used in the MOSAiC time series study.

## Time Point Format

Column names should follow the pattern: `{SampleID}_TP{1-4}` where:
- `SampleID` identifies the biological sample
- `TP1`, `TP2`, `TP3`, `TP4` represent the four time points in the study

## File Metadata

Optional: Add per-file metadata by creating a YAML sidecar named `<filename>.yml` containing key-value pairs (e.g. description, organism, source).

Example sidecar (`genes.gff3.yml`):

```
description: High-confidence gene models
organism: Example species
source: Ensembl v110
```
