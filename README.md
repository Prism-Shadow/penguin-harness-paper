# PenguinHarness Paper

Manuscript sources for *PenguinHarness: Unified Efficient Recursive Self-Improvement of Agents*. The compiled preprint is available as a [PDF](output/penguinharness-arxiv.pdf).

## Repository Structure

```text
penguin-harness-paper/
├── shared/
│   ├── secs/             # Shared section sources (abstract, introduction, relwork, organization, architecture, experiment, conclusion)
│   ├── figs/             # Shared figures (single source of truth)
│   ├── tabs/             # Shared tables (single source of truth)
│   ├── macros.tex        # Shared LaTeX macros (\fwname, etc.)
│   └── main.bib          # Shared BibTeX bibliography
├── arxiv/                # Single-column PrismShadow preprint
│   ├── main.tex
│   ├── prismshadow.cls / package.tex / logo.pdf
│   └── {secs,figs,tabs,macros.tex,main.bib} -> ../shared/...
├── icml/                 # Anonymous ICML build using the 2026 style
│   ├── main.tex
│   ├── icml2026.sty / icml2026.bst / algorithm.sty / algorithmic.sty / fancyhdr.sty
│   └── {secs,figs,tabs,macros.tex,main.bib} -> ../shared/...
├── output/               # Compiled preprint PDF
└── Makefile              # PDF builds and submission archives
```

## Build the PDFs

Use `make` with a TeX Live installation that includes `latexmk`, pdfLaTeX, BibTeX, and the packages required by the templates.

```bash
make arxiv  # arxiv/main.pdf
make icml   # icml/main.pdf
```

## Package the sources

The packaging targets use `rsync`, `tar`, and `zip` to copy the shared sources into standalone submission archives under `dist/`.

```bash
make pack-arxiv   # Outputs dist/arxiv_submit/, dist/arxiv_submit.tar.gz, dist/arxiv_submit.zip
make pack-icml    # Outputs dist/icml_submit/, dist/icml_submit.tar.gz, dist/icml_submit.zip
```

When trimming the ICML version separately for the 8-page limit, replace the `icml/secs` symlink with a real directory (`rm icml/secs && cp -r shared/secs icml/secs`) while keeping `figs/`, `tabs/`, and `main.bib` symlinked.
