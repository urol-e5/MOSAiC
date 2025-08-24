# External URL Management Transformation

## The Challenge
The original `counts.qmd` had **591 lines** with extensive code duplication. Each of the 12 data sections (3 species × 4 data types) required identical code blocks for:
- Download button generation
- URL display  
- Data table preview

This made URL updates tedious and error-prone since changes needed to be made in multiple places.

## The Solution
**Centralized Configuration + Dynamic Generation**

### Before (Repetitive Individual Variables)
```r
# URLs scattered throughout file
Apul_gene_url <- "https://long-url..."
Apul_mirna_url <- "https://another-long-url..."
Apul_lncRNA_url <- "https://yet-another-url..."
Apul_mCpG_url <- "https://fourth-url..."

Peve_gene_url <- "https://peve-gene-url..."
Peve_mirna_url <- "https://peve-mirna-url..."
# ... 6 more individual variables

# Then 45+ lines of repetitive code blocks for EACH data section:
## Gene Counts
cat(as.character(tags$a(href = Apul_gene_url, ...)))
urls <- c(Apul_gene_url)
for (i in seq_along(urls)) { cat("``` bash\n", urls[i], "\n```\n\n", sep = "") }
Apul_gene |> slice_head(n = 4) |> gt()

## miRNA Counts  
cat(as.character(tags$a(href = Apul_mirna_url, ...)))
urls <- c(Apul_mirna_url)
for (i in seq_along(urls)) { cat("``` bash\n", urls[i], "\n```\n\n", sep = "") }
Apul_mirna |> slice_head(n = 4) |> gt()

# ... this pattern repeated 12 times!
```

### After (Centralized + Automated)
```r
# All URLs in ONE organized structure
data_urls <- list(
  Apul = list(
    species_name = "Acropora pulchra",
    italic_name = "*Acropora pulchra*",
    gene = "https://long-url...",      # Easy to find and update!
    mirna = "https://another-url...",   # All URLs together
    lncRNA = "https://third-url...",    # Clear organization
    mCpG = "https://fourth-url..."      # One place to maintain
  ),
  Peve = list(/* ... */),
  Ptuh = list(/* ... */)
)

# Helper functions (defined once, used everywhere)
generate_data_section <- function(species_code, data_type) {
  # Automatically generates download button, URL display, and table preview
}

# ALL content generated with just 2 lines:
for (species_code in names(data_urls)) {
  generate_species_section(species_code)
}
```

## Results

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| **File Length** | 591 lines | 269 lines | **54% reduction** |
| **URL Updates** | 12 places to change | 1 place to change | **92% less effort** |
| **Code Duplication** | ~540 lines repeated | 0 lines repeated | **100% elimination** |
| **Adding New Species** | Copy/paste 45+ lines | Add 6-line config entry | **87% less work** |
| **Maintainability** | Error-prone | Automated | **Significantly improved** |

## Usage
**To update any external URL:** Simply edit the `data_urls` list at the top of the file. All download buttons, URL displays, and data tables automatically reflect the change.

**To add a new species:** Add one entry to the `data_urls` list and the page automatically generates all sections.

This transformation makes the file dramatically easier to maintain while preserving all original functionality.