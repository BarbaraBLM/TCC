%=====================================================================
% Identificação
%=====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{projetofinal-dcc}[2013/08/18 v1.0.0 Formatacao de documentos para o projeto final do DCC/NCE/UFRJ]

%=====================================================================
% Declaração de opções
%=====================================================================
\DeclareOption{english}{\@englishtrue\OptionNotUsed}\newif\if@english
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

%=====================================================================
% Herança da classe `report' e inclusão de pacotes e arquivos necessários
%=====================================================================
\LoadClass[12pt,a4paper]{report}
\RequirePackage[english,brazilian]{babel}
\input{babel/brazilian.babel}
\input{babel/english.babel}
\if@english
  \selectlanguage{english}
  \AtBeginDocument{\selectlanguage{english}}
\fi
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{indentfirst}      %identa primeiro parágrafo
\RequirePackage{graphicx}         %imagens
\RequirePackage{amsmath}          %formulas matemáticas
\RequirePackage{hyperref}         %referências
\RequirePackage{fancyhdr}         %manipulação de header e footer
\RequirePackage{iidefs}           %especifico para ufrj/im/dcc

\RequirePackage{color}
\RequirePackage{listings}
\RequirePackage{enumitem}

\RequirePackage[alf]{abntex2cite}   % Citações padrão ABNT
\RequirePackage{microtype}          % para melhorias de justificação

\RequirePackage{booktabs}           % comandos extras para as tabelas

\RequirePackage[table]{xcolor}      % definir cor para as linhas da tabela

\RequirePackage{csquotes}           % citações de frases

\RequirePackage[printonlyused]{acronym}   % criar lista de acrônimos 
\RequirePackage{ccaption}                 % adicionar legendas numeradas e não numeradas (ex. fonte da imagem)

\newcommand*{\eg}{\textit{e.g.}\@\xspace}
\newcommand*{\ie}{\textit{i.e.}\@\xspace}

% Códigos
%==============================================================================
\newcommand{\codejava}[3]{
  \mbox{
    \lstset{framexleftmargin=5mm, frame=shadowbox, rulesepcolor=\color{gray}}
    \lstinputlisting[language=Java,
      breaklines=true,
      basicstyle=\footnotesize\ttfamily,
      keywordstyle=\bfseries\color{purple},
      commentstyle=\itshape\color{dkgreen},
      stringstyle=\color{orange},
      showstringspaces=false,
      rulecolor=\color{black},
      caption=#1,label=#2]{#3}
  }
}

\newcommand{\codec}[3]{
  \mbox{
    \lstset{framexleftmargin=5mm, frame=shadowbox, rulesepcolor=\color{gray}}
    \lstinputlisting[language=C,
      breaklines=true,
      basicstyle=\footnotesize\ttfamily,
      keywordstyle=\bfseries\color{dkgreen},
      commentstyle=\itshape\color{purple},
      identifierstyle=\color{blue},
      stringstyle=\color{orange},
      showstringspaces=false,
      caption=#1,label=#2]{#3}
  }
}

%=====================================================================
% Referências
%=====================================================================
\newcommand{\reffigure}[1]{\figurename~\ref{#1}}
\newcommand{\reftable}[1]{\tablename~\ref{#1}}
\newcommand{\reflisting}[1]{\lstlistingname~\ref{#1}}
\newcommand{\refchapter}[1]{\chaptername~\ref{#1}}
\newcommand{\refsection}[1]{\sectionname~\ref{#1}}
\newcommand{\refequation}[1]{\equationname~\ref{#1}}
\newcommand{\refappendix}[1]{\appendixname~\ref{#1}}

%=====================================================================
% Numeração das páginas
%=====================================================================
\newcommand{\startdocument}{
  \setcounter{page}{1}
  \pagenumbering{roman}
  \pagestyle{plain}
}

\newcommand{\startcontent}{
  \setcounter{page}{1}
  \pagenumbering{arabic}
  \pagestyle{fancyplain}
  \lhead[\fancyplain{}{\bfseries\thepage}]{\fancyplain{}{\bfseries\rightmark}}
  \rhead[\fancyplain{}{\bfseries\leftmark}]{\fancyplain{}{\bfseries\thepage}}
  \cfoot{}
}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}

%=====================================================================
% Definição de autor(es), orientador, co-orientador e banca
%=====================================================================
% Autores - max = 3
\newcounter{ii@authorcount}
\renewcommand{\author}[2]{
  \addtocounter{ii@authorcount}{1}
  \expandafter\gdef\csname @author\alph{ii@authorcount}\endcsname{#1}
  \expandafter\gdef\csname @author\alph{ii@authorcount}thanks\endcsname{#2}
}
% Orientador
\DeclareRobustCommand{\advisor}[4][1]{
  \gdef\@advisorname{#2}
  \gdef\@advisororigin{#3}
  \gdef\@advisorgender{#4}
  \gdef\@advisor{#1~#2}
}
%Co-orientador
\DeclareRobustCommand{\coadvisor}[4][1]{
  \gdef\@coadvisorname{#2}
  \gdef\@coadvisororigin{#3}
  \gdef\@coadvisorgender{#4}
  \gdef\@coadvisor{#1~#2}
}
% Banca - max = 3
\newcounter{ii@bancacount}
\DeclareRobustCommand{\banca}[3][]{
  \addtocounter{ii@bancacount}{1}
  \expandafter\gdef\csname @banca\alph{ii@bancacount}\endcsname{#1~#2}
  \expandafter\gdef\csname @banca\alph{ii@bancacount}name\endcsname{#2}
  \expandafter\gdef\csname @banca\alph{ii@bancacount}origin\endcsname{#3}
}

%=====================================================================
% Definição do Departamento relacionado ao documento
% deve ser definido como 'dcc'
%=====================================================================
\newcommand{\dept}[1]{\gdef\@dept{#1}}

%=====================================================================
% Redefinição da data (para ter mês e ano separados)
%=====================================================================
\renewcommand{\date}[2]{
        \gdef\@publmonth{#1}
        \gdef\@publyear{#2}
}
\date{\monthname}{\number\year}

%=====================================================================
% Formatação das tabela de conteúdo (Sumário)
%=====================================================================
\setcounter{tocdepth}{4}

%=====================================================================
% Formatação das seções
%=====================================================================
\setcounter{secnumdepth}{4}
\renewcommand{\section}{%
  \@startsection{section}{1}{0pt}{18pt}{9pt}{\reset@font\large\bfseries}
}
\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{0pt}{12pt}{6pt}{\reset@font\bfseries}
}
\renewcommand{\subsubsection}{%
  \@startsection{subsubsection}{3}{0pt}{12pt}{6pt}{\reset@font\itshape}
}
\renewcommand{\paragraph}{%
  \@startsection{paragraph}{4}{0pt}{12pt}{6pt}{\reset@font}
}
\renewcommand{\subparagraph}{%
  \@startsection{subparagraph}{5}{0pt}{1ex}{-1em}{\reset@font\bfseries}
}

%=====================================================================
% Definição padrão da folha de rosto.
%=====================================================================
\newlength{\titlepagewinwidth}\setlength{\titlepagewinwidth}{95mm}
\newlength{\titlepagewinheight}\setlength{\titlepagewinheight}{64mm}
\newlength{\titlepagewinvoffset}\setlength{\titlepagewinvoffset}{112mm}
\newcommand{\location}[3]{
  \gdef\@city{#1}
  \gdef\@state{#2}
  \gdef\@country{#3}
}
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \thetitlepage
  \end{titlepage}%
  \clearpage
  \@makeapprovalpage
}
\newcommand{\thetitlepage}{%
  \thispagestyle{empty}
  \noindent\@topbox\\
  \vfill
  \@ifundefined{@advisor}{}{
    \hspace*{\fill}\parbox[b]{.5\textwidth}{%
                        {\titlepageadvisorinfo}
                    }
    \vfill
  }
  \centerline{\@city, \ii@date}
}
\def\@topbox{%
  \parbox[t]{\textwidth}{%
    \centering%
    \vbox to \titlepagewinvoffset{%
      \titlepagetopinfo\vfill\@winbox
    }
  }
}
\def\@winbox{
  \parbox[b]{\titlepagewinwidth}{
    \centering\vbox to \titlepagewinheight{
      \vspace*{\fill}
      \MakeUppercase{\@authora}\\
      \@ifundefined{@authorb}{}{\MakeUppercase{\@authorb}\\}
      \@ifundefined{@authorc}{}{\MakeUppercase{\@authorc}\\}
      \vspace{\stretch{4}}{\large\textbf{\@title}\par}
      \vfill
    }
  }
}
\newcommand{\curso}[1]{\gdef\@curso{#1}}
\newcommand{\titlepagetopinfo}{%
  \MakeUppercase{\ufrrj}\\
  \MakeUppercase{\im}\\
  \@ifundefined{@dept}{}{\MakeUppercase{\csname \@dept\endcsname}\\}%
  \@ifundefined{@curso}{}{\MakeUppercase{\csname \@curso\endcsname}\\}%
}
\newcommand{\titlepageadvisorinfo}{%
  \@ifundefined{@advisor}{}{\vfill\@advisor\\\ifthenelse{\equal{\@advisorgender}{a}}{\advisoraname}{\advisorname}}
  \@ifundefined{@coadvisor}{}{\\[6ex]\@coadvisor\\\ifthenelse{\equal{\@coadvisorgender}{a}}{\coadvisoraname}{\coadvisorname}}
}

%=====================================================================
% Folha de Aprovação
%=====================================================================
\newcommand{\@makeapprovalpage}{%
  \if@english
  \else
    \clearpage
    \thispagestyle{empty}
    \bigskip
    \begingroup
      \leftskip=0cm plus 0.5fil \rightskip=0cm plus -0.5fil
      \parfillskip=0cm plus 1fil
      \textbf{\large\@title}\par
    \endgroup
    \bigskip
    \centerline{\textbf{\@authora}}
    \@ifundefined{@authorb}{}{
      \centerline{\textbf{\@authorb}}
    }
    \@ifundefined{@authorc}{}{
      \centerline{\textbf{\@authorc}}
    }
    \bigskip

    \noindent
    Projeto Final de Curso submetido ao Departamento de Ci\^encia da Computa\c{c}\~ao do Instituto Multidisciplinar da Universidade Federal Rural do Rio de Janeiro como parte dos requisitos necess\'arios para obten\c{c}\~ao do grau de Bacharel em Ci\^encia da Computa\c{c}\~ao.

    \noindent
    Apresentado por:

    \begin{flushright}
      \hfill\line(1,0){250}\\
      \@authora

      \@ifundefined{@authorb}{}{
        \hfill\line(1,0){250}\\
        \@authorb

      }
      
      \@ifundefined{@authorc}{}{
        \hfill\line(1,0){250}\\
        \@authorc

      }
    \end{flushright}

    \noindent
    Aprovado por:

    \bigskip
    \begin{flushright}
      \hfill\line(1,0){250}\\
      \@advisor
      
      \@ifundefined{@coadvisor}{}{
        \hfill\line(1,0){250}\\
        \@coadvisor

      }

      \@ifundefined{@bancaa}{}{
        \hfill\line(1,0){250}\\
        \@bancaa

      }
      \@ifundefined{@bancab}{}{
        \hfill\line(1,0){250}\\
        \@bancab 

      }
      \@ifundefined{@bancac}{}{
        \hfill\line(1,0){250}\\
        \@bancac
  
      }
    \end{flushright}

    \vfill
    \begin{center}
      \MakeUppercase{\@city},~\MakeUppercase{\@state}~-~\MakeUppercase{\@country}\\
      \ii@date
    \end{center}
    \clearpage
  \fi
}

%=====================================================================
% Resumo (abstract) e Abstract (englishabstract)
%=====================================================================
\renewenvironment{abstract}[1]{
  \if@english
  \else
    \addcontentsline{toc}{chapter}{\abstractname}
    \begin{center}
      RESUMO \linebreak
      \@title \linebreak
      \@authora
      \@ifundefined{@authorb}{}{\@ifundefined{@authorc}{~e~}{,~}\@authorb}
      \@ifundefined{@authorc}{}{~e~\@authorc}\linebreak
      \@publmonth/\@publyear
    \end{center}

    \renewcommand{\baselinestretch}{1.2}
    \normalsize

    \noindent
    \@ifundefined{@advisorgender}{}{\ifthenelse{\equal{\@advisorgender}{a}}{\advisoraname}{\advisorname}}{:}
    \@advisorname\\
    \@advisororigin\\

    \renewcommand{\baselinestretch}{1.5}
    \normalsize

    {#1}
  \fi
}
{
  \pagebreak
}

\newenvironment{englishabstract}[1]{
  \addcontentsline{toc}{chapter}{Abstract}
  \begin{center}
    ABSTRACT \linebreak
    \@title \linebreak
    \@authora
    \@ifundefined{@authorb}{}{\@ifundefined{@authorc}{~and~}{,~}\@authorb}
    \@ifundefined{@authorc}{}{~and~\@authorc}\linebreak
    \@publmonth/\@publyear
  \end{center}

  \renewcommand{\baselinestretch}{1.2}
  \normalsize

  \noindent
  Advisor: \@advisorname\\
  \@advisororigin\\

  \renewcommand{\baselinestretch}{1.5}
  \normalsize

  \emph{#1}
}
{
  \pagebreak
}

%=====================================================================
% Redefinição do conteúdo das listas de figuras e tabelas
%=====================================================================
\newif\if@captionlisting\@captionlistingtrue
\long\def\@caption#1[#2]#3{%
  \par
  \if@captionlisting%
    \addcontentsline{\csname ext@#1\endcsname}{#1}%
    {\protect\numberline{\csname fnum@#1\endcsname:}{\ignorespaces #2}}%
  \fi%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \normalsize
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup%
}
\renewcommand*{\l@figure}{\@dottedtocline{1}{0em}{5.5em}}
\let\l@table\l@figure

%=====================================================================
% Definição do conteúdo de agradecimentos
%=====================================================================
\newcommand{\makethankspage}{
  \chapter*{Agradecimentos}
  \addcontentsline{toc}{chapter}{Agradecimentos}
  
  \@ifundefined{@authorb}{}{\underline{\@authora}}
  
  \@authorathanks
  \newpage
  
  \@ifundefined{@authorb}{}{
    \underline{\@authorb}
    
    \@authorbthanks
    \newpage
  }
  
  \@ifundefined{@authorc}{}{
    \underline{\@authorc}
    
    \@authorcthanks
    \newpage
  }
  
  \pagebreak
}{}

%=====================================================================
% Definição do conteúdo de listas de figuras
%=====================================================================
\newcommand{\makefigurespage}{
  \addcontentsline{toc}{chapter}{\listfigurename}
  \listoffigures{}
  \pagebreak
}{}

%=====================================================================
% Definição do conteúdo de listas de tabelas
%=====================================================================
\newcommand{\maketablespage}{
  \addcontentsline{toc}{chapter}{\listtablename} 
  \listoftables{}
  \pagebreak
}{}

%=====================================================================
% Definição do conteúdo de listas de algoritmos
%=====================================================================
\newcommand{\makelistingspage}{
  \addcontentsline{toc}{chapter}{\lstlistlistingname} 
  \lstlistoflistings{}
  \pagebreak
}{}

%=====================================================================
% Definição do conteúdo de listas de abreviaturas e símbolos
%=====================================================================
\newcommand{\makeabrevpage}[1]{
  \chapter*{\listabbrvname}
  \addcontentsline{toc}{chapter}{\listabbrvname}
  #1
  \pagebreak
}

\newcommand{\makesymbolspage}[1]{
  \chapter*{\listsymbolname}
  \addcontentsline{toc}{chapter}{\listsymbolname}  
  #1
  \pagebreak
}{}

%=====================================================================
% Ambiente para alineas e e subalineas (incisos)
% ABNT NBR 6024/2012 - 4.2 e 4.3
%=====================================================================
\newlist{alineas}{enumerate}{2}
\setlist[alineas,1]{label={\alph*)},topsep=0pt,itemsep=0pt,leftmargin=\parindent+\labelwidth-\labelsep}%
\setlist[alineas,2]{label={--},topsep=0pt,itemsep=0pt,leftmargin=*}
\newlist{subalineas}{enumerate}{1}
\setlist[subalineas,1]{label={--},topsep=0pt,itemsep=0pt,leftmargin=*}%
\newlist{incisos}{enumerate}{1}
\setlist[incisos,1]{label={--},topsep=0pt,itemsep=0pt,leftmargin=*}%
% ---

%=====================================================================
% Definição do conteúdo da tabela de conteúdo
%=====================================================================
\newcommand{\maketocpage}{
  \tableofcontents{}
  \pagebreak
}{}

%=====================================================================
% Definição do conteúdo da bibliografia
%=====================================================================
\newcommand{\makebibspage}[1]{
  \addcontentsline{toc}{chapter}{\bibname}
  \bibliography{#1}
}{}

%=====================================================================
% Teoremas, Definições
%=====================================================================
\newtheorem{definition}{Definição}
\newtheorem{theorem}{Teorema}[section]