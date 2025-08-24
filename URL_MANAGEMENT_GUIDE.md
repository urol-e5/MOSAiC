# URL Management Guide for counts.qmd

## Overview
The `counts.qmd` file has been refactored to make external URL management straightforward and maintainable. All URLs are now centralized in a single configuration section.

## How to Update URLs

### Simple URL Changes
To update any external data URL, edit the `data_urls` list in the main R code block:

```r
data_urls <- list(
  Apul = list(
    species_name = "Acropora pulchra",
    italic_name = "*Acropora pulchra*",
    gene = "https://your-new-url-here.csv",     # <- Update here
    mirna = "https://another-url.txt",          # <- Or here
    lncRNA = "https://third-url.txt",           # <- Or here
    mCpG = "https://fourth-url.csv"             # <- Or here
  ),
  # ... other species
)
```

### Adding New Species
To add a new species:

1. Add a new entry to the `data_urls` list:
```r
  NewSpecies = list(
    species_name = "Full Species Name",
    italic_name = "*Italicized Species Name*",
    gene = "url-to-gene-data",
    mirna = "url-to-mirna-data", 
    lncRNA = "url-to-lncrna-data",
    mCpG = "url-to-mcpg-data"
  )
```

2. The page will automatically generate sections for the new species.

### Adding New Data Types
To add a new data type (e.g., "protein"):

1. Add the new data type to each species in `data_urls`
2. Update the `load_data_file()` function to handle the new data type
3. Add the new data type to the loop in `generate_species_section()`
4. Update the feature counts table generation if needed

## Key Benefits

- **Single Point of Update**: All URLs are in one clearly marked section
- **Automatic Generation**: Content is generated programmatically, reducing errors
- **Consistent Formatting**: All sections follow the same structure
- **Reduced Duplication**: 54% reduction in code length (591 → 269 lines)
- **Easy Maintenance**: Changes only need to be made in one place

## File Structure

1. **Configuration Section**: All URLs and species information
2. **Helper Functions**: Reusable functions for generating content
3. **Data Loading**: Automated data loading with error handling
4. **Content Generation**: Dynamic creation of all species sections

This structure makes the file much easier to maintain while preserving all original functionality.