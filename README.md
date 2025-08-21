# MOSAiC Genome Browser & Data Portal

This repository provides:

1. Static JBrowse genome browser (`index.html` at repo root).
2. A Quarto-based website in `quarto/` documenting and listing downloadable tab-delimited genome feature / annotation files stored in `data/`.

## Quick Start

Serve JBrowse (one option):

```bash
python3 -m http.server 8080
```

Then open <http://localhost:8080> in a browser.

## Quarto Site

Install Quarto (<https://quarto.org>). Verify:

```bash
quarto --version
```

Render site:

```bash
quarto render quarto/
```

Preview with live reload (serves on a local port):

```bash
quarto preview quarto/
```

The generated site lives in `quarto/_site/`. It links back to JBrowse (`../index.html`).

## Adding Data Files

1. Place `.bed`, `.gff3`, `.tsv`, `.csv`, or similar tab-delimited files into `data/`.
2. (Optional) Create `<filename>.yml` sidecar with `description:` and other metadata.
3. Re-run `quarto render quarto/` to update the Data Files table.

## Automation (Future)

A GitHub Action can be added to auto-render Quarto on push and deploy the `_site` contents (e.g. to `gh-pages` or `docs/`). Not yet implemented.

## Notes

Keeping Quarto project in its own folder avoids clobbering the root JBrowse assets.
