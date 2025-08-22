# Sample Count Analysis Across Count Matrices

This document analyzes the number of samples represented in each count matrix across the three species and four feature types.

## Overview

The analysis examines count matrices for:
- **Species**: Acropora pulchra (Apul), Porites evermanni (Peve), Pocillopora tuahiniensis (Ptuh)
- **Feature Types**: Gene, miRNA, lncRNA, mCpG

## Sample Count Table

| Species | Gene | miRNA | lncRNA | mCpG |
|---------|------|-------|--------|------|
| **Acropora pulchra** | `r ncol(Apul_gene) - 1` | `r ncol(Apul_mirna) - 1` | `r ncol(Apul_lncRNA) - 1` | `r ncol(Apul_mCpG) - 1` |
| **Porites evermanni** | `r ncol(Peve_gene) - 1` | `r ncol(Peve_mirna) - 1` | `r ncol(Peve_lncRNA) - 1` | `r ncol(Peve_mCpG) - 1` |
| **Pocillopora tuahiniensis** | `r ncol(Ptuh_gene) - 1` | `r ncol(Ptuh_mirna) - 1` | `r ncol(Ptuh_lncRNA) - 1` | `r ncol(Ptuh_mCpG) - 1` |

*Note: Sample counts exclude the first column which typically contains feature identifiers*

## Sample ID Analysis

### Acropora pulchra (Apul)

#### Gene Counts
```r
# Sample columns (excluding first column)
Apul_gene_samples <- colnames(Apul_gene)[-1]
cat("Number of samples:", length(Apul_gene_samples), "\n")
cat("Sample IDs:", paste(Apul_gene_samples, collapse = ", "), "\n")
```

#### miRNA Counts
```r
# Sample columns (excluding first column)
Apul_mirna_samples <- colnames(Apul_mirna)[-1]
cat("Number of samples:", length(Apul_mirna_samples), "\n")
cat("Sample IDs:", paste(Apul_mirna_samples, collapse = ", "), "\n")
```

#### lncRNA Counts
```r
# Sample columns (excluding first column)
Apul_lncRNA_samples <- colnames(Apul_lncRNA)[-1]
cat("Number of samples:", length(Apul_lncRNA_samples), "\n")
cat("Sample IDs:", paste(Apul_lncRNA_samples, collapse = ", "), "\n")
```

#### mCpG Counts
```r
# Sample columns (excluding first column)
Apul_mCpG_samples <- colnames(Apul_mCpG)[-1]
cat("Number of samples:", length(Apul_mCpG_samples), "\n")
cat("Sample IDs:", paste(Apul_mCpG_samples, collapse = ", "), "\n")
```

### Porites evermanni (Peve)

#### Gene Counts
```r
# Sample columns (excluding first column)
Peve_gene_samples <- colnames(Peve_gene)[-1]
cat("Number of samples:", length(Peve_gene_samples), "\n")
cat("Sample IDs:", paste(Peve_gene_samples, collapse = ", "), "\n")
```

#### miRNA Counts
```r
# Sample columns (excluding first column)
Peve_mirna_samples <- colnames(Peve_mirna)[-1]
cat("Number of samples:", length(Peve_mirna_samples), "\n")
cat("Sample IDs:", paste(Peve_mirna_samples, collapse = ", "), "\n")
```

#### lncRNA Counts
```r
# Sample columns (excluding first column)
Peve_lncRNA_samples <- colnames(Peve_lncRNA)[-1]
cat("Number of samples:", length(Peve_lncRNA_samples), "\n")
cat("Sample IDs:", paste(Peve_lncRNA_samples, collapse = ", "), "\n")
```

#### mCpG Counts
```r
# Sample columns (excluding first column)
Peve_mCpG_samples <- colnames(Peve_mCpG)[-1]
cat("Number of samples:", length(Peve_mCpG_samples), "\n")
cat("Sample IDs:", paste(Peve_mCpG_samples, collapse = ", "), "\n")
```

### Pocillopora tuahiniensis (Ptuh)

#### Gene Counts
```r
# Sample columns (excluding first column)
Ptuh_gene_samples <- colnames(Ptuh_gene)[-1]
cat("Number of samples:", length(Ptuh_gene_samples), "\n")
cat("Sample IDs:", paste(Ptuh_gene_samples, collapse = ", "), "\n")
```

#### miRNA Counts
```r
# Sample columns (excluding first column)
Ptuh_mirna_samples <- colnames(Ptuh_mirna)[-1]
cat("Number of samples:", length(Ptuh_mirna_samples), "\n")
cat("Sample IDs:", paste(Ptuh_mirna_samples, collapse = ", "), "\n")
```

#### lncRNA Counts
```r
# Sample columns (excluding first column)
Ptuh_lncRNA_samples <- colnames(Ptuh_lncRNA)[-1]
cat("Number of samples:", length(Ptuh_lncRNA_samples), "\n")
cat("Sample IDs:", paste(Ptuh_lncRNA_samples, collapse = ", "), "\n")
```

#### mCpG Counts
```r
# Sample columns (excluding first column)
Ptuh_mCpG_samples <- colnames(Ptuh_mCpG)[-1]
cat("Number of samples:", length(Ptuh_mCpG_samples), "\n")
cat("Sample IDs:", paste(Ptuh_mCpG_samples, collapse = ", "), "\n")
```

## Summary Statistics

```r
# Create a summary data frame
sample_summary <- data.frame(
  Species = c("Acropora pulchra", "Porites evermanni", "Pocillopora tuahiniensis"),
  Gene_Samples = c(length(colnames(Apul_gene)) - 1, 
                   length(colnames(Peve_gene)) - 1, 
                   length(colnames(Ptuh_gene)) - 1),
  miRNA_Samples = c(length(colnames(Apul_mirna)) - 1, 
                    length(colnames(Peve_mirna)) - 1, 
                    length(colnames(Ptuh_mirna)) - 1),
  lncRNA_Samples = c(length(colnames(Apul_lncRNA)) - 1, 
                     length(colnames(Peve_lncRNA)) - 1, 
                     length(colnames(Ptuh_lncRNA)) - 1),
  mCpG_Samples = c(length(colnames(Apul_mCpG)) - 1, 
                   length(colnames(Peve_mCpG)) - 1, 
                   length(colnames(Ptuh_mCpG)) - 1)
)

# Display summary table
knitr::kable(sample_summary, 
             col.names = c("Species", "Gene", "miRNA", "lncRNA", "mCpG"),
             caption = "Sample Counts Across All Matrices")
```

## Notes

- Sample counts exclude the first column which typically contains feature identifiers (e.g., gene names, transcript IDs)
- The analysis assumes consistent column structure across all matrices
- Sample ID formatting may vary between data types as noted in the main document
