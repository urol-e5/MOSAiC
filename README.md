# MOSAiC Genome Browser & Data Portal

This repository provides:

1. JBrowse genome browser.
2. A Quarto-based website in `quarto/` 


## JBrowse Genome Browser. 

Currently the Genome Browser is being coded in this repo and being mirrored (rsync) to gannet and hosted there. This is also where most large files are hosted. Within the quarto site the browser is embedded and there is also a link that takes you to the Genome Browser on gannet (https://gannet.fish.washington.edu/e5-mosaic).

Currently on _A. pulchra_ genome is loaded. 


## Contributing

When developing the site content we recommend creating a new branch for the feature you are working on the using `pull request` to bring back into main branch. Do not publish site to gh-pages when in development on new branch.

Please also use Issues to make suggestions and recommendations. 


## Quick Start

To render site:

```bash
quarto render quarto/
```

To publish website to GitHub Pages:

```bash
quarto publish gh-pages quarto/
```


Preview with live reload (serves on a local port):

```bash
quarto preview quarto/
```

The generated site lives in `quarto/_site/`. 


## Notes

Keeping Quarto project in its own folder avoids clobbering the root JBrowse assets.
