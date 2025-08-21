# Issue: Interactive Genome Feature File Preview & Download

Add interactive preview, search, and download functionality for genome feature files.

## Summary

Provide an interactive, searchable web preview and convenient download options for genome feature annotation files (e.g. TSV/GFF/BED) within the Quarto site (`quarto/data.qmd`). Optionally embed JBrowse 2 for genome-context visualization of features.

## Motivation / Problem

Users currently must download feature files blindly or inspect raw text. This reduces discoverability, increases friction for exploration, and makes large files unwieldy. An in-page interactive table with search/filter/export plus an optional genome browser view improves usability and transparency.

## Proposed Solution (Multi-tier)

1. Basic download links with proper browser download hint.
2. Client-side interactive table (R `DT` or lightweight JS) with global + per-column search and export buttons.
3. Metadata + quick preview (head lines, file size, counts) for context.
4. Strategy for large files (> ~100k rows): sampling, splitting, or delegating to genome browser.
5. Optional embedded JBrowse 2 instance for spatial navigation of features in genomic coordinates (requires bgzip+tabix indexing for GFF/BED if using Tabix adapters).

## Detailed Task List

- [ ] Add direct download link(s) in `quarto/data.qmd` using `{download}` attribute.
- [ ] Load feature file (e.g. `data/example_features.tsv`) with `readr::read_tsv()` (handle comments, large `guess_max`) inside an R chunk.
- [ ] Create reduced/selected column view for performance/usability.
- [ ] Implement `DT::datatable` with:
  - [ ] `filter = "top"`
  - [ ] Buttons extension: copy, csv
  - [ ] Scroller extension with `deferRender`, `scrollY`, `scroller = TRUE`
  - [ ] Sensible `pageLength` (e.g. 25)
- [ ] Add metadata summary chunk (row count, distinct seqids, min/max coordinates).
- [ ] Add quick head (first N lines) textual preview (e.g. 5 lines) of raw file.
- [ ] Add optional plain JS fallback table (first 500 rows) if R not executed (decide if needed).
- [ ] Document large-file mitigation guidance in page (sampling, splitting, Parquet, JBrowse, server-side option).
- [ ] (Optional) Unzip `jbrowse-web-v3.6.3.zip` into `static/jbrowse/` (or similar) as part of repo build or prepublish step.
- [ ] Prepare feature file in GFF3 (if not already) and bgzip + tabix index locally: `bgzip -c features.gff3 > features.gff3.gz` and `tabix -p gff features.gff3.gz`.
- [ ] Add `features.gff3.gz` and `features.gff3.gz.tbi` to `static/jbrowse/` (or a subfolder) and reference in JBrowse config.
- [ ] Create or modify `static/jbrowse/config.json` to include FeatureTrack referencing the Tabix adapter.
- [ ] Embed iframe in `data.qmd` linking to JBrowse with `?config=` parameter.
- [ ] Verify relative paths from rendered HTML (consider that Quarto output `_site/` changes path depth).
- [ ] Add acceptance criteria checklist to PR description.
- [ ] Update `README.md` (or create `docs/data_features.md`) with usage notes.

## Acceptance Criteria

- Download link appears and triggers file save (tested in at least one browser) without navigating away.
- Interactive table loads within acceptable time (< 3s for ≤ 50k rows) and supports:
  - Global search
  - Column-specific filters
  - Copy + CSV export
  - Smooth scrolling (no huge lag)
- Metadata summary displays accurate counts.
- Head preview shows first 5 lines (or configurable) of raw file.
- For large file scenario (if tested with synthetic large file), documented guidance present; page does not attempt to fully load multi-million-row file.
- (Optional JBrowse path) Embedded genome browser loads and displays feature track with correct coordinates.
- No console JS errors in rendered page.
- All relative paths correct in final published site.

## Non-Goals / Out of Scope

- Building a full server-side API for paginated queries (would require dynamic hosting / Shiny / FastAPI).
- Authentication or access control around downloads.
- On-the-fly genomic interval querying (beyond what JBrowse provides client-side).

## Risks / Considerations

- Large files may exceed browser memory; mitigate by sampling or pre-aggregating.
- JBrowse static embedding requires correct relative path; path depth differs when page is nested (ensure use of site root prefix if necessary).
- Tabix indexing step is manual unless scripted.
- Adding large gzipped feature + index increases repo size (consider Git LFS if >50 MB).

## Implementation Notes & Snippets

Download link (Markdown):

```markdown
[Download genome features](../data/example_features.tsv){download="features.tsv"}
```

R `DT` chunk (core):

```r
library(readr)
library(dplyr)
library(DT)

features <- read_tsv("../data/example_features.tsv", comment = "#", guess_max = 100000)
features_small <- features %>% select(seqid = 1, start = 4, end = 5, strand = 7, type = 3)

datatable(
  features_small,
  filter = "top",
  extensions = c("Buttons","Scroller"),
  options = list(
    dom = "Bfrtip",
    buttons = c("copy","csv"),
    pageLength = 25,
    deferRender = TRUE,
    scrollY = 500,
    scroller = TRUE
  )
)
```

Metadata summary:

```r
features_small %>% summarise(
  n_rows = n(),
  n_seqids = n_distinct(seqid),
  min_start = min(start),
  max_end = max(end)
)
```

Plain JS search fallback (first 500 rows):

```python
import pandas as pd
df = pd.read_csv("../data/example_features.tsv", sep="\t", comment="#")
df.head(500).to_html(index=False, table_id="feat")
```

```html
<script>
const input = document.createElement('input');
input.placeholder = 'Search...';
input.oninput = () => {
  const q = input.value.toLowerCase();
  document.querySelectorAll('#feat tbody tr').forEach(tr => {
    tr.style.display = [...tr.children].some(td => td.textContent.toLowerCase().includes(q)) ? '' : 'none';
  });
};
document.currentScript.before(input);
</script>
```

JBrowse track snippet (`config.json`):

```json
{
  "tracks": [
    {
      "type": "FeatureTrack",
      "trackId": "features",
      "name": "Features",
      "assemblyNames": ["hg19"],
      "adapter": {
        "type": "Gff3TabixAdapter",
        "gffGzLocation": { "uri": "features.gff3.gz" },
        "index": { "location": { "uri": "features.gff3.gz.tbi" } }
      }
    }
  ]
}
```

Embed iframe in `data.qmd` (HTML chunk):

```html
<div style="height:650px;border:1px solid #ccc;">
  <iframe src="../static/jbrowse/?config=./config.json" style="width:100%;height:100%;border:0;"></iframe>
</div>
```

## Large File Guidance (Document In Page)

- Keep interactive table under ~100k rows; otherwise sample or aggregate.
- Provide full file download separately.
- Offer JBrowse view for locus-based exploration.
- Consider compressing distribution format (bgzip) and providing index for power users.

## Testing Plan

1. Render `quarto/data.qmd` locally with `quarto preview quarto/`.
2. Confirm table interactivity & export.
3. Inspect browser console for errors.
4. Test iframe path correctness after full site build into `_site/`.
5. (If JBrowse) Navigate within browser to sample region, verify feature track loads.
6. Validate download link saves file (check file size equality via `md5` if desired).

## Future Enhancements

- Server-side (Shiny or API) backed lazy pagination for very large tables.
- Additional derived metrics (feature density plots by chromosome).
- Quick genomic interval search box integrated with JBrowse navigation.
- Add Parquet/Feather optimized versions for downstream analysis.

## References

- DT package docs: <https://rstudio.github.io/DT/>
- JBrowse 2 docs: <https://jbrowse.org/jb2/>
- Tabix indexing: <http://www.htslib.org/doc/tabix.html>

---
Created from prior assistant guidance; adapt as needed before opening a GitHub Issue.
