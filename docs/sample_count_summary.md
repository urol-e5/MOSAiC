# Sample Count Analysis Results

This document provides the results of analyzing sample counts across all count matrices for the three species and four feature types.

## Summary Table

| Species | Gene | miRNA | lncRNA | mCpG |
|---------|------|-------|--------|------|
| **Acropora pulchra** | 80 | 40 | 45 | 39 |
| **Porites evermanni** | 38 | 37 | 43 | 37 |
| **Pocillopora tuahiniensis** | 39 | 39 | 44 | 32 |

## Key Findings

### Sample Count Patterns
- **Acropora pulchra** has the highest sample representation across all feature types
- **Porites evermanni** and **Pocillopora tuahiniensis** have similar sample counts
- **Gene expression** matrices consistently have the highest sample counts
- **mCpG methylation** matrices have the lowest sample counts

### Sample ID Formatting
The analysis revealed different sample ID formats across data types:

#### Acropora pulchra (Apul)
- **Gene**: Uses ACR-XXX-TP# format (e.g., ACR-139-TP1, ACR-145-TP2)
- **miRNA**: Uses 1A1_ACR-XXX_TP# format (e.g., 1A1_ACR-173_TP1)
- **lncRNA**: Uses file path format with ACR-XXX-TP#.sorted.bam
- **mCpG**: Uses ACR-XXX-TP# format

#### Porites evermanni (Peve)
- **Gene**: Uses POR-XXX-TP# format (e.g., POR-216-TP1, POR-236-TP2)
- **miRNA**: Uses 1A7_POR-XXX_TP# format (e.g., 1A7_POR-73_TP1)
- **lncRNA**: Uses POR-XXX-TP# format
- **mCpG**: Uses POR-XXX-TP# format

#### Pocillopora tuahiniensis (Ptuh)
- **Gene**: Uses POC-XXX-TP# format (e.g., POC-201-TP1, POC-219-TP2)
- **miRNA**: Uses 1A3_POC-XXX_TP# format (e.g., 1A3_POC-255_TP1)
- **lncRNA**: Uses POC-XXX-TP# format
- **mCpG**: Uses POC-XXX-TP# format

## Data Quality Notes

- All 12 matrices were successfully read and analyzed
- Sample counts exclude the first column which contains feature identifiers
- The gene matrices show duplicate sample IDs (e.g., ACR-139-TP1 appears twice), suggesting technical replicates
- miRNA matrices use a different naming convention with plate positions (1A1, 1B2, etc.)
- lncRNA matrices include metadata columns (Chr, Start, End, Strand, Length) before sample columns

## Recommendations

1. **Standardize sample IDs** across all data types for easier cross-referencing
2. **Document technical replicates** in gene expression matrices
3. **Verify sample metadata** to ensure proper biological interpretation
4. **Consider sample overlap** between different feature types for integrated analyses

## Files Generated

- `sample_count_analysis.R` - R script for analysis
- `sample_count_summary.csv` - CSV summary of results
- `sample_count_summary.md` - This summary document
