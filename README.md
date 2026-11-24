# researchnote

A LaTeX class for short research notes, based on `article`. It is the note-sized
sibling of the `researchbook` class from
[modern-book1](https://github.com/tdavidcl/modern-book1) and shares its look:
DarkRed section titles, coloured theorem boxes, the warning box and the
astronomy journal macros.

## Usage

Put `researchnote.cls` next to your `.tex` file (or anywhere on `TEXINPUTS`) and build with:

```sh
latexmk -pdf example.tex
```

Minimal document:

```latex
\documentclass{researchnote}

\title{Note title}
\runningtitle{Short title}          % running head; defaults to the title
\author{Author Name}
\affiliation{Institution Name}
\date{1 January 2026}
\notetags{tag one \textperiodcentered{} tag two}
\notesource{https://example.org/link/to/source}

\begin{document}
\maketitle
\begin{abstract}
Two to five sentences on what the note is about.
\end{abstract}

\section{First section}
...

\bibliography{refs}
\end{document}
```

`example.tex` uses every feature of the class.

## Citations

The class loads `natbib` with author-year citations and the `plainnat` style:

| Command | Output |
| --- | --- |
| `\citet{key}` | Doe and Smith (2020) |
| `\citep{key}` | (Doe and Smith 2020) |
| `\citep{a,b}` | (Doe and Smith 2020; Roe 2018) |
| `\citep[see][chap.~2]{key}` | (see Roe 2018, chap. 2) |

For numeric citations `[1]`, use `\documentclass[numbers]{researchnote}`.
Do not load `natbib` again or set `\bibliographystyle` in the document.

The reference list uses `QV_mnras.bst` (MNRAS style, from
[phd-thesis-tempate](https://github.com/tdavidcl/phd-thesis-tempate), with
BibTeX stack errors fixed). Keep it next to the `.tex` file. Links are coloured
by destination when the `.bib` entry has the field:

| Field | Linked text | Colour |
| --- | --- | --- |
| `doi` (or `url` on articles) | journal name | red (`LinkJournal`) |
| `adsurl` | volume | blue (`LinkADS`) |
| `eprint` | pages | green (`LinkArXiv`) |

BibTeX exported from NASA ADS has all three fields.

## Page layout

A4, 11 pt, 25 mm top and bottom margins, 28 mm side margins. Running heads
show the note title on the left and the first section on the page on the right.

## Note metadata

| Command | Printed |
| --- | --- |
| `\title{}` | title, flush right |
| `\runningtitle{}` | left running head (defaults to the title) |
| `\author{}`, `\affiliation{}`, `\date{}` | line under the title |
| `\notetags{}` | grey line under the author |
| `\notesource[label]{url}` | link at the bottom of the summary box; `label` defaults to `Source` (e.g. `Repository`, `Agent session`) |
| `\notenumber{}` | stored only, not printed |

## Environments

| Environment | Use |
| --- | --- |
| `abstract` | summary box |
| `tcdefinition{title}{label}` | green box, referenced as `def:label` |
| `tcproposition{title}{label}` | grey box, referenced as `prop:label` |
| `tctheorem{title}{label}` | red box, referenced as `thm:label` |
| `proof` | from `amsthm` |
| `WithArrows[displaystyle]` | annotated derivations (`witharrows`) |
| `marker` | yellow warning box |

Boxes are numbered within sections. Astronomy journal macros (`\mnras`, `\apj`,
`\aap`, ...) are defined for use in `.bib` files.

## Packages loaded

`geometry`, `fontenc` (T1), `lmodern`, `microtype`, `xcolor` (svgnames),
`amsmath`, `amsthm`, `amssymb`, `witharrows`, `graphicx`, `tikz`,
`anyfontsize`, `titlesec`, `fancyhdr`, `tcolorbox`, `caption`, `natbib`, `hyperref`.
