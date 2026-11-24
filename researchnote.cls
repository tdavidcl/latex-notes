\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{researchnote}[2026/11/24 researchnote: article variant of researchbook]

% ---------------------------------------------------------------------------
% Base class
% ---------------------------------------------------------------------------
% Option "numbers": numeric citations [1] instead of author-year (default)
\newif\if@rn@numbers
\DeclareOption{numbers}{\@rn@numberstrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt]{article}

% A4, margins sized for ~80 characters per line at 11pt
\RequirePackage[
  a4paper,
  tmargin=25mm,bmargin=25mm,hmargin=28mm,
  headsep=7mm
]{geometry}

\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{microtype}

\RequirePackage[svgnames]{xcolor}

% ---------------------------------------------------------------------------
% Maths
% ---------------------------------------------------------------------------
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{witharrows}

\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{calc,shapes.geometric}
\RequirePackage{anyfontsize}

% ---------------------------------------------------------------------------
% Section styles (identical to researchbook)
% ---------------------------------------------------------------------------
\RequirePackage[sf,bf]{titlesec}

\titleformat{\section}
  {\normalfont\bfseries\Large\color{DarkRed}}
  {\thesection.}
  {1em}
  {}

\titleformat{\subsection}
  {\normalfont\bfseries\large\color{black}}
  {\thesubsection.}
  {1em}
  {}

\titleformat{\subsubsection}
  {\normalfont\bfseries\color{black}}
  {\thesubsubsection.}
  {1em}
  {}

\titlespacing*{\section}{0pt}{3.0ex plus 1ex minus .2ex}{1.5ex plus .2ex}

% ---------------------------------------------------------------------------
% Note metadata
% ---------------------------------------------------------------------------
\def\@notenumber{}
\def\@notetags{}
\def\@notesource{}
\def\@notesourcelabel{Source}
\def\@affiliation{}
\def\@runningtitle{}
\newcommand{\notenumber}[1]{\def\@notenumber{#1}}
\newcommand{\notetags}[1]{\def\@notetags{#1}}
% \notesource[label]{url}: any link back to where the note came from
% (git repository, agent session, web page...); label defaults to "Source"
\newcommand{\notesource}[2][Source]{\def\@notesourcelabel{#1}\def\@notesource{#2}}
\newcommand{\affiliation}[1]{\def\@affiliation{#1}}
\newcommand{\runningtitle}[1]{\def\@runningtitle{#1}}

% ---------------------------------------------------------------------------
% Header & footer
% ---------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small\slshape\@runningtitle}
\fancyhead[R]{\small\slshape\rightmark}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\sectionmark}[1]{\markboth{\thesection.\ #1}{\thesection.\ #1}}

\fancypagestyle{notefirst}{%
  \fancyhf{}%
  \fancyfoot[C]{\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
}

% ---------------------------------------------------------------------------
% Title block: the researchbook chapter header, adapted
% ---------------------------------------------------------------------------
\renewcommand{\maketitle}{%
  \ifx\@runningtitle\@empty\let\@runningtitle\@title\fi
  \thispagestyle{notefirst}%
  \begingroup
  \parindent=0pt
  % Title, flush right as in the chapter style
  {\raggedleft\fontsize{22}{28}\selectfont\@title\par}%
  \vspace{3mm}%
  {\color{DarkRed}\rule{\linewidth}{0.8pt}}\par
  \vspace{2mm}%
  {\small
   \textsc{\@author}%
   \ifx\@affiliation\@empty\else\ \textperiodcentered\ \textit{\@affiliation}\fi
   \hfill\@date\par}%
  \ifx\@notetags\@empty\else
    \vspace{1mm}%
    {\small\color{DimGray}\textsf{\@notetags}\par}%
  \fi
  \vspace{6mm}%
  \endgroup
}

% Abstract as a soft box
\RequirePackage[listings]{tcolorbox}
\tcbuselibrary{listings,theorems,skins,hooks,breakable}

\renewenvironment{abstract}{%
  \begin{tcolorbox}[enhanced,breakable,
    colback=FireBrick!4,colframe=FireBrick!4,
    borderline west={2pt}{0pt}{DarkRed},
    sharp corners,left=4mm,right=4mm,top=2mm,bottom=2mm,
    fontupper=\small]%
  \textbf{\color{DarkRed}Summary.}\ %
}{%
  \ifx\@notesource\@empty\else
    \par\vspace{1.5mm}%
    {\footnotesize\color{DimGray}\@notesourcelabel: \url{\@notesource}\par}%
  \fi
  \end{tcolorbox}\vspace{2mm}%
}

% ---------------------------------------------------------------------------
% Bibliography: natbib, author-year by default (\citet, \citep)
% ---------------------------------------------------------------------------
\if@rn@numbers
  \RequirePackage[numbers,sort&compress]{natbib}
\else
  \RequirePackage[round,sort]{natbib}
  \setcitestyle{aysep={}}   % (Doe and Smith 2020), astronomy style
\fi
\bibliographystyle{plainnat}

% ---------------------------------------------------------------------------
% Links
% ---------------------------------------------------------------------------
\definecolor{linkcolor}{rgb}{0,0,0.6}
\RequirePackage[
    colorlinks=true,
    linkcolor=linkcolor,
    citecolor=linkcolor,
    urlcolor=linkcolor,
    hyperfigures=false]{hyperref}

% ---------------------------------------------------------------------------
% Theorem-like boxes (identical to researchbook)
% ---------------------------------------------------------------------------
\newtcbtheorem[number within=section]{tcdefinition}{Definition}%
{colback=green!5,colframe=green!35!black,fonttitle=\bfseries,
separator sign={\ $\blacktriangleright$}}{def}

\newtcbtheorem[number within=section]{tctheorem}{Theorem}%
{colback=red!5,colframe=red!35!black,fonttitle=\bfseries,
separator sign={\ $\blacktriangleright$}}{thm}

\newtcbtheorem[number within=section]{tcproposition}{Proposition}%
{colback=black!5,colframe=black!35!black,fonttitle=\bfseries,
separator sign={\ $\blacktriangleright$}}{prop}

\newtcolorbox{marker}[1][]{enhanced,
  before skip balanced=2mm,after skip balanced=3mm,
  boxrule=0.4pt,left=5mm,right=2mm,top=1mm,bottom=1mm,
  colback=yellow!50,
  colframe=yellow!20!black,
  sharp corners,rounded corners=southeast,arc is angular,arc=3mm,
  underlay={%
    \path[fill=tcbcolback!80!black] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
    \path[draw=tcbcolframe,shorten <=-0.05mm,shorten >=-0.05mm] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
    \path[fill=yellow!50!black,draw=none] (interior.south west) rectangle node[white]{\Huge\bfseries !} ([xshift=4mm]interior.north west);
    },
  drop fuzzy shadow,#1}

% ---------------------------------------------------------------------------
% Figures & captions
% ---------------------------------------------------------------------------
\RequirePackage[font=small,labelfont={bf,color=DarkRed},labelsep=period]{caption}

% ---------------------------------------------------------------------------
% Astro journal aliases (identical to researchbook)
% ---------------------------------------------------------------------------
\newcommand\aap{A\&A}
\let\astap=\aap
\newcommand\aapr{A\&ARv}
\newcommand\aaps{A\&AS}
\newcommand\actaa{Acta Astron.}
\newcommand\afz{Afz}
\newcommand\aj{AJ}
\newcommand\ao{Appl. Opt.}
\let\applopt=\ao
\newcommand\aplett{Astrophys.~Lett.}
\newcommand\apj{ApJ}
\newcommand\apjl{ApJ}
\let\apjlett=\apjl
\newcommand\apjs{ApJS}
\let\apjsupp=\apjs
\newcommand\apss{Ap\&SS}
\newcommand\araa{ARA\&A}
\newcommand\arep{Astron. Rep.}
\newcommand\aspc{ASP Conf. Ser.}
\newcommand\azh{Azh}
\newcommand\baas{BAAS}
\newcommand\bac{Bull. Astron. Inst. Czechoslovakia}
\newcommand\bain{Bull. Astron. Inst. Netherlands}
\newcommand\caa{Chinese Astron. Astrophys.}
\newcommand\cjaa{Chinese J.~Astron. Astrophys.}
\newcommand\fcp{Fundamentals Cosmic Phys.}
\newcommand\gca{Geochimica Cosmochimica Acta}
\newcommand\grl{Geophys. Res. Lett.}
\newcommand\iaucirc{IAU~Circ.}
\newcommand\icarus{Icarus}
\newcommand\japa{J.~Astrophys. Astron.}
\newcommand\jcap{J.~Cosmology Astropart. Phys.}
\newcommand\jcp{J.~Chem.~Phys.}
\newcommand\jgr{J.~Geophys.~Res.}
\newcommand\jqsrt{J.~Quant. Spectrosc. Radiative Transfer}
\newcommand\jrasc{J.~R.~Astron. Soc. Canada}
\newcommand\memras{Mem.~RAS}
\newcommand\memsai{Mem. Soc. Astron. Italiana}
\newcommand\mnassa{MNASSA}
\newcommand\mnras{MNRAS}
\newcommand\na{New~Astron.}
\newcommand\nar{New~Astron.~Rev.}
\newcommand\nat{Nature}
\newcommand\nphysa{Nuclear Phys.~A}
\newcommand\pra{Phys. Rev.~A}
\newcommand\prb{Phys. Rev.~B}
\newcommand\prc{Phys. Rev.~C}
\newcommand\prd{Phys. Rev.~D}
\newcommand\pre{Phys. Rev.~E}
\newcommand\prl{Phys. Rev.~Lett.}
\newcommand\pasa{Publ. Astron. Soc. Australia}
\newcommand\pasp{PASP}
\newcommand\pasj{PASJ}
\newcommand\physrep{Phys.~Rep.}
\newcommand\physscr{Phys.~Scr.}
\newcommand\planss{Planet. Space~Sci.}
\newcommand\procspie{Proc.~SPIE}
\newcommand\rmxaa{Rev. Mex. Astron. Astrofis.}
\newcommand\qjras{QJRAS}
\newcommand\sci{Science}
\newcommand\skytel{Sky \& Telesc.}
\newcommand\solphys{Sol.~Phys.}
\newcommand\sovast{Soviet~Ast.}
\newcommand\ssr{Space Sci. Rev.}
\newcommand\zap{Z.~Astrophys.}

% References heading: no upper-case running head
\renewcommand\bibsection{\section*{\refname}\markboth{\refname}{\refname}}

\endinput
