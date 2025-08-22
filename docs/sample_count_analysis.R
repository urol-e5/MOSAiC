# Sample Count Analysis Script
# This script analyzes the number of samples in each count matrix across species and feature types

# Load required libraries
library(tidyverse)
library(knitr)
library(DT)

# Define URLs for count matrices
Apul_gene_url <- "https://gannet.fish.washington.edu/gitrepos/urol-e5/timeseries_molecular/D-Apul/output/02.20-D-Apul-RNAseq-alignment-HiSat2/apul-gene_count_matrix.csv"
Apul_mirna_url <- "https://raw.githubusercontent.com/urol-e5/timeseries_molecular/refs/heads/main/M-multi-species/output/10-format-miRNA-counts/Apul_miRNA_counts_formatted.txt"
Apul_lncRNA_url <- "https://gannet.fish.washington.edu/v1_web/owlshell/bu-github/timeseries_molecular/D-Apul/output/33-Apul-lncRNA-matrix/Apul_lncRNA_counts_filtered.txt"
Apul_mCpG_url <- "https://gannet.fish.washington.edu/metacarcinus/E5/20250821_meth_Apul/merged-WGBS-CpG-counts_filtered.csv"

Peve_gene_url <- "https://gannet.fish.washington.edu/gitrepos/urol-e5/timeseries_molecular/E-Peve/output/02.20-E-Peve-RNAseq-alignment-HiSat2/peve-gene_count_matrix.csv"
Peve_mirna_url <- "https://raw.githubusercontent.com/urol-e5/timeseries_molecular/refs/heads/main/M-multi-species/output/10-format-miRNA-counts/Peve_miRNA_counts_formatted.txt"
Peve_lncRNA_url <- "https://gannet.fish.washington.edu/v1_web/owlshell/bu-github/timeseries_molecular/E-Peve/output/13-Peve-lncRNA-matrix/Peve_lncRNA_counts_filtered.txt"
Peve_mCpG_url <- "https://gannet.fish.washington.edu/metacarcinus/E5/Pevermanni/20250821_meth_Peve/merged-WGBS-CpG-counts_filtered.csv"

Ptuh_gene_url <- "https://gannet.fish.washington.edu/gitrepos/urol-e5/timeseries_molecular/F-Ptua/output/02.20-F-Ptua-RNAseq-alignment-HiSat2/ptua-gene_count_matrix.csv"
Ptuh_mirna_url <- "https://raw.githubusercontent.com/urol-e5/timeseries_molecular/refs/heads/main/M-multi-species/output/10-format-miRNA-counts/Ptuh_miRNA_counts_formatted.txt"
Ptuh_lncRNA_url <- "https://raw.githubusercontent.com/urol-e5/timeseries_molecular/refs/heads/main/F-Ptua/output/06-Ptua-lncRNA-discovery/lncRNA_counts.clean.filtered.txt"
Ptuh_mCpG_url <- "https://gannet.fish.washington.edu/metacarcinus/E5/Ptuahiniensis/20250821_meth_Ptua/merged-WGBS-CpG-counts_filtered.csv"

# Function to safely read data and get sample count
get_sample_count <- function(url, file_type = "csv", skip_rows = 0) {
  tryCatch({
    if (file_type == "csv") {
      data <- read_csv(url, show_col_types = FALSE)
    } else if (file_type == "tsv") {
      data <- read_delim(url, delim = "\t", col_names = TRUE, skip = skip_rows, show_col_types = FALSE)
    }
    
    # Return number of sample columns (excluding first column which is typically feature ID)
    sample_count <- ncol(data) - 1
    sample_names <- colnames(data)[-1]
    
    return(list(count = sample_count, names = sample_names, success = TRUE))
  }, error = function(e) {
    return(list(count = NA, names = character(0), success = FALSE, error = e$message))
  })
}

# Read all matrices and get sample counts
cat("Reading count matrices...\n")

# Apul matrices
Apul_gene <- get_sample_count(Apul_gene_url, "csv")
Apul_mirna <- get_sample_count(Apul_mirna_url, "tsv")
Apul_lncRNA <- get_sample_count(Apul_lncRNA_url, "tsv", skip_rows = 7)
Apul_mCpG <- get_sample_count(Apul_mCpG_url, "csv")

# Peve matrices
Peve_gene <- get_sample_count(Peve_gene_url, "csv")
Peve_mirna <- get_sample_count(Peve_mirna_url, "tsv")
Peve_lncRNA <- get_sample_count(Peve_lncRNA_url, "tsv", skip_rows = 7)
Peve_mCpG <- get_sample_count(Peve_mCpG_url, "csv")

# Ptuh matrices
Ptuh_gene <- get_sample_count(Ptuh_gene_url, "csv")
Ptuh_mirna <- get_sample_count(Ptuh_mirna_url, "tsv")
Ptuh_lncRNA <- get_sample_count(Ptuh_lncRNA_url, "tsv")
Ptuh_mCpG <- get_sample_count(Ptuh_mCpG_url, "csv")

# Create summary table
sample_summary <- data.frame(
  Species = c("Acropora pulchra", "Porites evermanni", "Pocillopora tuahiniensis"),
  Gene = c(Apul_gene$count, Peve_gene$count, Ptuh_gene$count),
  miRNA = c(Apul_mirna$count, Peve_mirna$count, Ptuh_mirna$count),
  lncRNA = c(Apul_lncRNA$count, Peve_lncRNA$count, Ptuh_lncRNA$count),
  mCpG = c(Apul_mCpG$count, Peve_mCpG$count, Ptuh_mCpG$count)
)

# Display summary table
cat("\n=== SAMPLE COUNT SUMMARY ===\n")
print(knitr::kable(sample_summary, 
                   caption = "Sample Counts Across All Matrices",
                   format = "simple"))

# Create detailed sample information
cat("\n=== DETAILED SAMPLE INFORMATION ===\n")

# Apul samples
cat("\n**Acropora pulchra (Apul)**\n")
cat("Gene samples:", Apul_gene$count, "-", paste(Apul_gene$names, collapse = ", "), "\n")
cat("miRNA samples:", Apul_mirna$count, "-", paste(Apul_mirna$names, collapse = ", "), "\n")
cat("lncRNA samples:", Apul_lncRNA$count, "-", paste(Apul_lncRNA$names, collapse = ", "), "\n")
cat("mCpG samples:", Apul_mCpG$count, "-", paste(Apul_mCpG$names, collapse = ", "), "\n")

# Peve samples
cat("\n**Porites evermanni (Peve)**\n")
cat("Gene samples:", Peve_gene$count, "-", paste(Peve_gene$names, collapse = ", "), "\n")
cat("miRNA samples:", Peve_mirna$count, "-", paste(Peve_mirna$names, collapse = ", "), "\n")
cat("lncRNA samples:", Peve_lncRNA$count, "-", paste(Peve_lncRNA$names, collapse = ", "), "\n")
cat("mCpG samples:", Peve_mCpG$count, "-", paste(Peve_mCpG$names, collapse = ", "), "\n")

# Ptuh samples
cat("\n**Pocillopora tuahiniensis (Ptuh)**\n")
cat("Gene samples:", Ptuh_gene$count, "-", paste(Ptuh_gene$names, collapse = ", "), "\n")
cat("miRNA samples:", Ptuh_mirna$count, "-", paste(Ptuh_mirna$names, collapse = ", "), "\n")
cat("lncRNA samples:", Ptuh_lncRNA$count, "-", paste(Ptuh_lncRNA$names, collapse = ", "), "\n")
cat("mCpG samples:", Ptuh_mCpG$count, "-", paste(Ptuh_mCpG$names, collapse = ", "), "\n")

# Check for any failed reads
cat("\n=== DATA READ STATUS ===\n")
matrices <- list(
  "Apul_gene" = Apul_gene, "Apul_mirna" = Apul_mirna, 
  "Apul_lncRNA" = Apul_lncRNA, "Apul_mCpG" = Apul_mCpG,
  "Peve_gene" = Peve_gene, "Peve_mirna" = Peve_mirna, 
  "Peve_lncRNA" = Peve_lncRNA, "Peve_mCpG" = Peve_mCpG,
  "Ptuh_gene" = Ptuh_gene, "Ptuh_mirna" = Ptuh_mirna, 
  "Ptuh_lncRNA" = Ptuh_lncRNA, "Ptuh_mCpG" = Ptuh_mCpG
)

for (name in names(matrices)) {
  status <- ifelse(matrices[[name]]$success, "✓ SUCCESS", "✗ FAILED")
  cat(sprintf("%-20s: %s\n", name, status))
  if (!matrices[[name]]$success) {
    cat(sprintf("  Error: %s\n", matrices[[name]]$error))
  }
}

# Save results to file
cat("\n=== SAVING RESULTS ===\n")
write.csv(sample_summary, "sample_count_summary.csv", row.names = FALSE)
cat("Sample count summary saved to 'sample_count_summary.csv'\n")

# Create a more detailed output for the markdown
cat("\n=== MARKDOWN TABLE FORMAT ===\n")
cat("Copy this table into your markdown document:\n\n")
cat("| Species | Gene | miRNA | lncRNA | mCpG |\n")
cat("|---------|------|-------|--------|------|\n")
for (i in 1:nrow(sample_summary)) {
  cat(sprintf("| %s | %d | %d | %d | %d |\n", 
              sample_summary$Species[i], 
              sample_summary$Gene[i], 
              sample_summary$miRNA[i], 
              sample_summary$lncRNA[i], 
              sample_summary$mCpG[i]))
}
