# Debug script for Acropora pulchra gene matrix
# Investigating the 80 sample columns issue

library(tidyverse)

# Read the Apul gene matrix
Apul_gene_url <- "https://gannet.fish.washington.edu/gitrepos/urol-e5/timeseries_molecular/D-Apul/output/02.20-D-Apul-RNAseq-alignment-HiSat2/apul-gene_count_matrix.csv"

cat("Reading Apul gene matrix...\n")
Apul_gene <- read_csv(Apul_gene_url, show_col_types = FALSE)

cat("\n=== MATRIX STRUCTURE ===\n")
cat("Total columns:", ncol(Apul_gene), "\n")
cat("Total rows:", nrow(Apul_gene), "\n")

cat("\n=== COLUMN NAMES ===\n")
colnames_apul <- colnames(Apul_gene)
print(colnames_apul)

cat("\n=== FIRST FEW ROWS ===\n")
print(head(Apul_gene[, 1:10]))

cat("\n=== SAMPLE COLUMN ANALYSIS ===\n")
# Check if first column is gene ID
cat("First column name:", colnames_apul[1], "\n")
cat("First column type:", class(Apul_gene[[1]]), "\n")

# Look for duplicate column names
cat("\n=== DUPLICATE COLUMN ANALYSIS ===\n")
duplicates <- colnames_apul[duplicated(colnames_apul)]
if (length(duplicates) > 0) {
  cat("Duplicate column names found:\n")
  print(duplicates)
  
  # Count occurrences of each duplicate
  for (dup in unique(duplicates)) {
    count <- sum(colnames_apul == dup)
    cat(sprintf("'%s' appears %d times\n", dup, count))
  }
} else {
  cat("No duplicate column names found\n")
}

# Check for columns that might be metadata vs samples
cat("\n=== COLUMN TYPE ANALYSIS ===\n")
cat("Columns that might be metadata (not samples):\n")
for (i in 1:min(10, ncol(Apul_gene))) {
  col_type <- class(Apul_gene[[i]])
  unique_vals <- length(unique(Apul_gene[[i]]))
  cat(sprintf("Column %d (%s): %s, %d unique values\n", 
              i, colnames_apul[i], col_type, unique_vals))
}

# Look at the actual sample columns (assuming first column is gene ID)
if (ncol(Apul_gene) > 1) {
  cat("\n=== SAMPLE COLUMNS (excluding first) ===\n")
  sample_cols <- colnames_apul[-1]
  cat("Number of sample columns:", length(sample_cols), "\n")
  
  # Check for patterns in sample names
  cat("\nSample name patterns:\n")
  sample_patterns <- table(gsub("\\..*$", "", sample_cols))
  print(sample_patterns)
  
  # Show unique sample IDs (without suffixes)
  unique_samples <- unique(gsub("\\..*$", "", sample_cols))
  cat("\nUnique sample IDs (without suffixes):", length(unique_samples), "\n")
  cat("Sample IDs:", paste(unique_samples, collapse = ", "), "\n")
}
