# Corrected Sample Count Analysis

## Important Correction

The previous analysis incorrectly counted technical replicates as separate samples. Here are the **corrected** sample counts:

## Corrected Summary Table

| Species | Gene | miRNA | lncRNA | mCpG |
|---------|------|-------|--------|------|
| **Acropora pulchra** | **40** | 40 | 45 | 39 |
| **Porites evermanni** | 38 | 37 | 43 | 37 |
| **Pocillopora tuahiniensis** | 39 | 39 | 44 | 32 |

## Key Correction Details

### Acropora pulchra Gene Matrix
- **Total columns**: 81 (1 gene_id + 80 sample columns)
- **Unique samples**: 40
- **Technical replicates**: 2 per sample
- **Sample pattern**: Each sample (e.g., ACR-139-TP1) appears twice with suffixes `...2`, `...3`

### Why This Happened
The `read_csv()` function automatically renamed duplicate column names by adding suffixes:
- `ACR-139-TP1` → `ACR-139-TP1...2` and `ACR-139-TP1...3`
- `ACR-145-TP2` → `ACR-145-TP2...12` and `ACR-145-TP2...13`
- And so on...

## Corrected Analysis

### Unique Sample Counts (excluding technical replicates)
| Species | Gene | miRNA | lncRNA | mCpG |
|---------|------|-------|--------|------|
| **Acropora pulchra** | 40 | 40 | 45 | 39 |
| **Porites evermanni** | 38 | 37 | 43 | 37 |
| **Pocillopora tuahiniensis** | 39 | 39 | 44 | 32 |

## Implications

1. **Technical replicates** provide quality control and reproducibility assessment
2. **Actual sample sizes** are more reasonable and consistent across species
3. **Data analysis** should account for technical replicates appropriately
4. **Sample overlap** between feature types is more meaningful

## Recommendations

1. **Document technical replicates** in metadata
2. **Use appropriate statistical methods** that account for technical replicates
3. **Consider averaging technical replicates** for downstream analysis
4. **Verify if other matrices** also contain technical replicates

## Files Updated

- `corrected_sample_counts.md` - This corrected summary
- Original analysis files remain for reference but contain the counting error
