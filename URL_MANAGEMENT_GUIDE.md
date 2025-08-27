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