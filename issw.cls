%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% This file has been newly generated to meet accessivility requirements
%% as LaTeX Template class for extended abstracts for
%% the ISSW 2026 in Whistler, Canada (http://www.issw2018.com)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{issw}[2025/12/04 PDF/UA-2 compliant two-column ISSW-style class]

% Forward options to base article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Default: two-column article
\PassOptionsToClass{twocolumn}{article}
\LoadClass{article}

% Engine check: we rely on LuaLaTeX for Tagged PDF / PDF/UA
\RequirePackage{iftex}
\ifLuaTeX\else
  \PackageError{issw}{LuaLaTeX required for PDF/UA}{%
    Please switch your engine to LuaLaTeX.%
  }
\fi

% --------------------------------------------------------------------
% Page size + basic two-column layout (A4, 2.5 cm margins, 0.8 cm column gap)
% --------------------------------------------------------------------
\RequirePackage[
  a4paper,
  left=2.5cm,
  right=2.5cm,
  top=2.5cm,
  bottom=2.5cm
]{geometry}
\setlength\columnsep{0.8cm}   % space between columns (0.8 cm)
\setlength\parindent{0pt}       % no first-line indent
\setlength\parskip{4pt plus 1pt minus 1pt} % small vertical space between paragraphs

% Subtle micro-typographic improvements
\RequirePackage{microtype}

% Sans-serif font for entire document
\RequirePackage{fontspec}

% Use Arial if available, otherwise Liberation Sans, fallback to Latin Modern Sans
\IfFontExistsTF{Arial}{
  \setmainfont{Arial}[Ligatures=TeX]
}{
  \IfFontExistsTF{Liberation Sans}{
    \setmainfont{Liberation Sans}[Ligatures=TeX]
  }{
    \setmainfont{Latin Modern Sans}[Ligatures=TeX]
  }
}
% keep default math (or choose a math font with unicode-math if you really want)


% match elsarticle_issw2018 font metrics
\linespread{1.05} % slightly tight lines

% Hyperlinks + bookmarks (PDF/UA-friendly; metadata handled via DocumentMetadata)
\RequirePackage{hyperref}
\RequirePackage{bookmark}
% ----- Hyperlink styling (black, normal font, no underline) -----
\hypersetup{
  colorlinks=true,        % colored links instead of boxes
  linkcolor=black,   % section headings, figure/table refs, etc.
  urlcolor=black,     % URLs (mostly in references)
  citecolor=black,    % citations in text
  pdfborder={0 0 0}   % no border/underline on links
}

\RequirePackage[normalem]{ulem} % provides \uline
\RequirePackage{titlesec}

% Bibliography: biblatex + biber, natbib-compatible commands
\RequirePackage[
  backend=biber,
  style=authoryear,  % author–year citations like NHESS
  giveninits=true,   % authors as "Smith, J. A."
  uniquename=init,   % resolve conflict with giveninits
  maxcitenames=2,    % in-text: Smith & Miller, or Smith et al.
  maxbibnames=99,    % full author list in references
  sorting=nyt,       % name, year, title
  dashed=false,      % do NOT replace repeated authors with dash
  doi=true,
  url=false          % normally NHESS prefers DOI over URL
]{biblatex}
% -------- NHESS-like reference formatting (no italics in citations/refs) --------
% Set bibliography font size to 8pt
\AtBeginBibliography{%
  \footnotesize  % 8pt font size
  \renewcommand{\mkbibemph}[1]{#1}
}
% 2) Authors as "Family, G. I."
\DeclareNameAlias{sortname}{family-given}
\DeclareNameAlias{default}{family-given}
% 3) Titles and journaltitles upright (no extra formatting)
\DeclareFieldFormat[article]{title}{#1}
\DeclareFieldFormat[article]{journaltitle}{#1}
% 4) Print DOI as "https://doi.org/..."
\DeclareFieldFormat{doi}{%
  \ifstrequal{#1}{}{}{\space https://doi.org/#1}%
}


\RequirePackage{etoolbox} %for marcos that make tables taggable
\RequirePackage[table]{xcolor} % enables \rowcolor, colored cells, etc.
\RequirePackage{xparse}          % for \NewDocumentEnvironment
\RequirePackage{caption}
\captionsetup[table]{labelfont=bf, labelsep=colon}
% --------------------------------------------------------------------
% Capture abstract and keywords in boxes (ISSW-style)
% --------------------------------------------------------------------
\newbox\issw@absbox
\newbox\issw@keybox

\renewenvironment{abstract}{%
  \global\setbox\issw@absbox=\vbox\bgroup
    \hsize=\textwidth
    \def\baselinestretch{1}%
    \noindent\normalsize
    \text{ABSTRACT: }\ignorespaces
}{%
  \par\egroup
}


\newenvironment{keyword}{%
  \global\setbox\issw@keybox=\vbox\bgroup
    \hsize=\textwidth
    \normalfont\mdseries\upshape
    \noindent\text{KEYWORDS: }\ignorespaces
}{%
  \par\egroup
}



\makeatletter


% Custom ISSW footnote rule: left-aligned and 80% of column width
% Custom ISSW footnote rule: left-aligned and 80% of column width, no extra vspace

\renewcommand{\footnoterule}{%
  \noindent\rule{0.8\columnwidth}{0.4pt}\par
}
\setlength{\skip\footins}{0pt} % remove space above





% --------------------------------------------------------------------
% elsarticle-style author / address / corresponding author interface
% --------------------------------------------------------------------
\newcommand*\issw@authors{}   % collected author line with superscripts
\newcommand*\issw@affils{}    % collected affiliation lines
\newcommand*\issw@corinfo{}   % corresponding author text

% \author[<affil key>]{<name>}
\renewcommand\author[2][]{%
  % #1 = affiliation key (e.g. 1), optional
  % #2 = author name (can contain \corref{...})
  \ifx\issw@authors\@empty
    \gdef\issw@authors{#2%
      \ifx\relax#1\relax\else\fi}%
  \else
    \g@addto@macro\issw@authors{, #2%
      \ifx\relax#1\relax\else\textsuperscript{#1}\fi}%
  \fi
}


% \address[<affil key>]{<affiliation text>}
\newcommand\address[2][]{%
  \ifx\issw@affils\@empty
    \gdef\issw@affils{\textsuperscript{#1}\textit{#2}}%
  \else
    \g@addto@macro\issw@affils{\\\textsuperscript{#1}\textit{#2}}%
  \fi
}


% Mark corresponding author in the author line (star)
\newcommand\corref[1]{\textsuperscript{*}\footnotemark}


% Store corresponding author block (to be printed as a footnote)
\newcommand\cortext[2][]{%
  \gdef\issw@corinfo{#2}%
}



% --- Numbering with trailing dot (1. , 1.1. , ...) ---
\renewcommand\thesection{\arabic{section}.}
\renewcommand\thesubsection{\thesection\arabic{subsection}.}
\renewcommand{\ULthickness}{0.08pt} % or 0.08pt if you want very thin

% --- Section: non-bold, Times-like, ISSWish size ---

\titleformat{\section}
  {\normalfont\rmfamily\mdseries\large} % font: Times, non-bold, large
  {\thesection}                         % label e.g. "1."
  {0.5em}                               % space between label and title
  {}                                    % code before title text

% --- Subsection: italic + thin underline, non-bold, Times-like ---
\titleformat{\subsection}
  {\normalfont\rmfamily\mdseries\itshape\normalsize} % italic, non-bold
  {\thesubsection}                                   % label e.g. "1.1."
  {0.5em}
  {\uline}                                          % thin underline under title text


% Section spacing tuned to resemble ISSW Word template
\titlespacing*{\section}
  {0pt}                         % left indent
  {2.5ex plus 0.5ex minus 0.2ex}% space above
  {1.4ex plus 0.3ex}            % space below

\titlespacing*{\subsection}
  {0pt}
  {2.5ex plus 0.5ex minus 0.2ex}% space above
  {1.0ex plus 0.2ex}            % space below


% Title + abstract + keywords style similar to elsarticle_issw MaketitleBox


\renewcommand\maketitle{%
  \if@twocolumn
    \twocolumn[%
      \thispagestyle{plain}%
      \vspace*{-1.5\baselineskip}%
      \begin{center}%
        % Title
        {\normalfont\mdseries\upshape
         \def\baselinestretch{1}%
         \large\@title\par}%
        \vskip12pt
        % Authors + affiliations
        {\normalfont\mdseries\upshape
         \normalsize
         \ifx\issw@authors\@empty
           \@author
         \else
           \issw@authors
         \fi
         \par}%
        \ifx\issw@affils\@empty\else
          \vskip6pt
          {\normalfont\mdseries\upshape
           \small \issw@affils\par}%
        \fi
        \vskip12pt
        % Abstract (full width)
        \ifvoid\issw@absbox\else
          {\normalfont\mdseries\upshape
           \noindent\unvbox\issw@absbox\par}%
          \vskip10pt
        \fi
        % Keywords (full width)
        \ifvoid\issw@keybox\else
          {\normalfont\mdseries\upshape
           \noindent\unvbox\issw@keybox\par}%
          \vskip10pt
        \fi
      \end{center}%
    ]%
  \else
    \thispagestyle{plain}%
    \vspace*{-1.5\baselineskip}%
    \begin{center}%
      {\normalfont\mdseries\upshape
       \def\baselinestretch{1}%
       \large\@title\par}%
      \vskip18pt
      {\normalfont\mdseries\upshape
       \normalsize
       \ifx\issw@authors\@empty
         \@author
       \else
         \issw@authors
       \fi
       \par}%
      \ifx\issw@affils\@empty\else
        \vskip6pt
        {\normalfont\mdseries\upshape
         \small \issw@affils\par}%
      \fi
      \vskip24pt
      \ifvoid\issw@absbox\else
        {\normalfont\mdseries\upshape
         \noindent\unvbox\issw@absbox\par}%
        \vskip10pt
      \fi
      \ifvoid\issw@keybox\else
        {\normalfont\mdseries\upshape
         \noindent\unvbox\issw@keybox\par}%
        \vskip10pt
      \fi
    \end{center}%
  \fi
     % Corresponding author block as unnumbered footnote on first page (lower left)
\ifx\issw@corinfo\@empty\else
  \begingroup
    \renewcommand\thefootnote{}%
    \footnotetext{%
      {\footnotesize
        % disable all indentation
        \setlength{\parindent}{0pt}%
        \setlength{\leftskip}{0pt}%
        \setlength{\hangindent}{0pt}%

        % first line, italic
        \noindent\textit{* Corresponding author address:}\\
        \noindent\issw@corinfo
      }%
    }%
  \endgroup
\fi
}

% ============================================================
% Tagged Table (PDF/UA) with caption + label + artifact hlines
% ============================================================
% ============================================================
% Simple taggedtable interface (NO optional argument version)
% ============================================================

% Usage:
% \begin{taggedtable}{h}{tab:example}{A table showing a series of values.}{lcc}
%   \HeaderRow{\textit{Location} & \textit{Value 1 (cm)} & \textit{Value 2 (m)}}
%   \Row{Location a & 9.0 & 7.0}
% \end{taggedtable}

\newenvironment{taggedtable}[4]{%
  % #1 = placement (h, ht, t, b, H, etc.)
  % #2 = \label key
  % #3 = caption text
  % #4 = column format (e.g. lcc)
  \begin{table}[#1]
    \centering
    \caption{#3}%
    \label{#2}%
    \begin{tabular}{#4}%
}{%
    \end{tabular}%
  \end{table}%
}

\newcommand{\HeaderRow}[1]{%
  \hline
  \rowcolor{gray!20}%
  #1\\%
  \hline
}

\newcommand{\Row}[1]{%
  #1\\%
}

% Bold underline command

\newcommand{\bolduline}[1]{%
  {\renewcommand{\ULthickness}{0.14em}\uline{#1}}%
}



\makeatother

