%%----------------------------------------------------------------------------------------------
%%
%%	Clase U-Memoria
%%	Primer Autor: Nikolas Tapia M.
%%	Version: 1.5
%%	Fecha: 21-06-2012
%%	Actualización: 11-06-2015
%%
%%	Modificaciones: 30-04-2017
%%	Autor: Matías Mattamala
%%	Descripción: Orden de la clase, nuevas definiciones para doble titulación, nuevos packages para mejores referencias
%%
%%----------------------------------------------------------------------------------------------


\NeedsTeXFormat{LaTeX2e}[2009/09/24]
\ProvidesClass{umemoria}[2012/06/18 v1.2 Clase LaTeX para estandarizacion de Memorias U. de Chile]

%%----------------------------------------------------------------------------------------------
%% Nuevos comandos
%%----------------------------------------------------------------------------------------------

%% Definicion de Condicionales
\newif\if@swapnum
\newif\if@contnum
\@swapnumfalse
\@contnumtrue

%% Declaracion de Opciones
\DeclareOption{leftnum}{\@swapnumtrue}
\DeclareOption{rightnum}{\@swapnumfalse}
\DeclareOption{contnum}{\@contnumtrue}
\DeclareOption{nocontnum}{\@contnumfalse}
%\DeclareOption{uprightd}{\AtEndOfPackage{\DeclareMathSymbol{d}{\mathalpha}{operators}{`d}}}
%\DeclareOption{uprighte}{\AtEndOfPackage{\DeclareMathSymbol{e}{\mathalpha}{operators}{`e}}}
%\DeclareOption{uprighti}{\AtEndOfPackage{\DeclareMathSymbol{i}{\mathalpha}{operators}{`i}}}
%\DeclareOption{upright}{\ExecuteOptions{uprightd,uprighte,uprighti}}

%% Pasar Opciones a clase Book
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[11pt, openany]{book}

%%----------------------------------------------------------------------------------------------
%% Packages requeridos
%%----------------------------------------------------------------------------------------------

%Encoding
\usepackage[T1,T2A]{fontenc}
\RequirePackage[utf8]{inputenc}


% Margenes
\RequirePackage[top=2cm, left=3cm, bottom=2cm, right=2cm, paper=letterpaper]{geometry}

% Comandos matematicos
\RequirePackage{amsmath, amssymb, amsthm, amsfonts, dsfont}

% Figuras
\RequirePackage{graphicx}

% Lenguaje
%\RequirePackage[spanish, es-nolists, es-lcroman,es-nodecimaldot]{babel} % Lenguaje

% Referencias cruzadas
\RequirePackage[pdfpagelabels,
				backref=page,
				%colorlinks=true,
				%hidelinks=false
				]{hyperref} % Links y numeracion del PDF con referencias cruzadas

\backrefspanish
\renewcommand*{\backref}[1]{}
%\renewcommand*{\backrefalt}[4]{%
%	\ifcase #1 (No citado.)%
%	\or        (Citado en pag.~#2.)%
%	\else      (Citado en pag.~#2.)%
%	\fi}

% Codigo fuente
\RequirePackage{listings} % Codigo Fuente
% \RequirePackage{minted} % minted es mas bonito, pero requiere instalar pygments y cambiar algunas opciones del compilador

%% Interlineado
\RequirePackage{parskip}
\setlength{\parskip}{1em}
\setlength{\parindent}{15pt}

% Lorem Ipsum (texto relleno)
\RequirePackage{lipsum}

% Foreach
\RequirePackage{pgffor}

% Hyperlinks
\RequirePackage{url}	% Hyperlinks

% Texto de colores
\RequirePackage{color}	% Texto en colores

% figuras flotantes (habilita opcion H)
\RequirePackage{float}

% Figuras flotantes junto al texto
\RequirePackage{wrapfig}

% Configuracion de titulos de figuras 
\RequirePackage{caption}

% Subtitulos en figuras (multiples figuras)
\RequirePackage{subcaption}

% Tablas con multiples filas
\RequirePackage{multirow}

% tablas con columnas de tamaño adaptable
\RequirePackage{tabulary}

% Cita al principio de cada capítulo
\RequirePackage{epigraph}


%%----------------------------------------------------------------------------------------------
%% Configuracion
%%----------------------------------------------------------------------------------------------

%% Redefinicion de titulos de secciones
%\addto\captionsspanish{\renewcommand\tablename{Tabla}}
%\addto\captionsspanish{\renewcommand\contentsname{Contents}}
%\addto\captionsspanish{\renewcommand\listtablename{List of Tables}}
%\addto\captionsspanish{\renewcommand\listfigurename{List of Figures}}

%% Renovar enumerate e itemize
\let\oldenum\enumerate
\let\oldendenum\endenumerate
\renewenvironment{enumerate}{\oldenum\setlength{\parskip}{\smallskipamount}}{\oldendenum}
\let\olditem\itemize
\let\oldenditem\enditemize
\renewenvironment{itemize}{\olditem\setlength{\parskip}{\smallskipamount}}{\oldenditem}

% Opciones de tabla de contenidos y numeracion
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{2}

%%----------------------------------------------------------------------------------------------
%% Entornos nuevos
%% Paginas requeridas por la memoria/tesis
%%----------------------------------------------------------------------------------------------
% Resumen en español
\newenvironment{resumen}{%
	\foreach \x [count=\N] in \@carrera {}
	\cleardoublepage
	\begin{flushright}
		\footnotesize
		\begin{tabulary}{0.5\linewidth}{L}
			RESUMEN DE LA\foreach \x [count=\xi] in \@memoria{
				\foreach \y [count=\yi] in \@carrera{
					\ifnum\xi=\yi
						\MakeUppercase\x: {\MakeUppercase\y}
						\ifnum\xi<\N;\fi
					\fi
				}
			}\\
			POR: \MakeUppercase\@author \\
			FECHA: \MakeUppercase\@fecha \\
			PROF. GUÍA: \foreach \x in \@guia { \MakeUppercase\x }
		\end{tabulary}
	\end{flushright}
	\begin{center}
		\MakeUppercase\@titulo
	\end{center}
}{\vfill\null}

% Resumen en inglés
\newenvironment{abstract}{%
	\foreach \x [count=\N] in \@carrera {}
	\cleardoublepage
	\begin{flushright}
		\footnotesize
		\begin{tabulary}{0.5\linewidth}{L}
			RESUMEN DE LA\foreach \x [count=\xi] in \@memoria {
				\foreach \y [count=\yi] in \@carrera{
					\ifnum\xi=\yi
					\MakeUppercase\x: {\MakeUppercase\y}
					\ifnum\xi<\N;\fi
					\fi
				}
			}\\
			BY: \MakeUppercase\@author \\
			DATE: \MakeUppercase\@date \\
			SUPERVISOR: \foreach \x in \@guia { \MakeUppercase\x }
		\end{tabulary}
	\end{flushright}
	\begin{center}
		\MakeUppercase\@title
	\end{center}
}{\vfill\null}

% Dedicatoria
\newenvironment{dedicatoria}{\cleardoublepage\null\vspace{\stretch{1}}\begin{flushright}\itshape}{\end{flushright}\vspace{\stretch{2}}\null}
\let\thanks\undefined

% Agradecimientos
\newenvironment{thanks}{\cleardoublepage\chapter*{Agradecimientos}}{\vfill\null}

% Acrónimos
\newenvironment{acronyms}{\cleardoublepage\chapter*{Acrónimos}}{\vfill\null}

% Agradecimientos
\newenvironment{notation}{\cleardoublepage\chapter*{Notación}}{\vfill\null}

%Introduccion
\newenvironment{intro}{\addcontentsline{toc}{chapter}{\protect\numberline{}Introducción}\chapter*{Introducción}}{\vfill\null}

% Conclusion
\newenvironment{conclusion}{\addcontentsline{toc}{chapter}{\protect\numberline{}Conclusión}\chapter*{Conclusión}}{\vfill\null}

%%----------------------------------------------------------------------------------------------
%% Teoremas y demostraciones
%%----------------------------------------------------------------------------------------------

\renewenvironment{proof}[1][\proofname] {\par\pushQED{\qed}\normalfont\topsep6\p@\@plus6\p@\relax\trivlist\item[\hskip\labelsep\scshape\footnotesize#1\@addpunct{.}]\ignorespaces}{\popQED\endtrivlist\@endpefalse}

\newtheoremstyle{miestilo}{\baselineskip}{3pt}{\itshape}{}{\bfseries}{}{.5em}{}
\newtheoremstyle{miobs}{\baselineskip}{3pt}{}{}{\bfseries}{}{.5em}{}
\if@swapnum
	\swapnumbers
\fi
\theoremstyle{miestilo}
\newtheorem{defn}{Definición}[chapter]
\if@contnum
\newtheorem{teo}[defn]{Teorema}
\newtheorem{cor}[defn]{Corolario}
\newtheorem{lema}[defn]{Lema}
\newtheorem{prop}[defn]{Proposición}
\else
\newtheorem{teo}{Teorema}[chapter]
\newtheorem{cor}{Corolario}[chapter]
\newtheorem{lema}{Lema}[chapter]
\newtheorem{prop}{Proposición}[chapter]
\fi
\theoremstyle{miobs}
\newtheorem*{ej}{Ejemplo}
\newtheorem*{obs}{Observación}

%%----------------------------------------------------------------------------------------------
%% Comandos para la portada
%%----------------------------------------------------------------------------------------------

% Titulo
\global\let\@titulo\@empty
\newcommand{\settitulo}[1]{\def\@titulo{#1}}
\let\titulo\settitulo
\let\settitulo\relax

% Fecha
\global\let\@fecha\@empty
\newcommand{\setfecha}[1]{\def\@fecha{#1}}
\let\fecha\setfecha
\let\setfecha\relax

% Carrera
\global\let\@carrera\@empty
\newcommand{\setcarrera}[1]{\def\@carrera{#1}}
\let\carrera\setcarrera
\let\setcarrera\relax

% Memoria
\global\let\@memoria\@empty
\newcommand{\setmemoria}[1]{\def\@memoria{#1}}
\let\memoria\setmemoria
\let\setmemoria\relax

% Guia
\global\let\@guia\@empty
\newcommand{\setguia}[1]{\def\@guia{#1}}
\let\guia\setguia
\let\setguia\relax

% Departamento
\global\let\@depto\@empty
\newcommand{\setdepto}[1]{\def\@depto{#1}}
\let\depto\setdepto
\let\setdepto\relax

% Comision
\global\let\@comision\@empty
\newcommand{\setcomision}[1]{\def\@comision{#1}}
\let\comision\setcomision
\let\setcomision\relax

% Auspicio
\global\let\@auspicio\@empty
\newcommand{\setauspicio}[1]{\def\@auspicio{#1}}
\let\auspicio\setauspicio
\let\setauspicio\relax

%%----------------------------------------------------------------------------------------------
%% Portada
%%----------------------------------------------------------------------------------------------
\renewcommand{\maketitle}{
	\begin{titlepage}
		\begin{minipage}{1.6cm}
			\includegraphics[scale=.12]{imagenes/escudoU.pdf}
		\end{minipage}
		\begin{minipage}[t]{12cm}
			UNIVERSIDAD DE CHILE\\FACULTAD DE CIENCIAS FÍSICAS Y MATEMÁTICAS\\\MakeUppercase\@depto
		\end{minipage}

		\vspace{2cm}
		\centering
			\MakeUppercase\@titulo

		\vspace{1cm}
			\foreach \x [count=\xi] in \@memoria {
				\foreach \y [count=\yi] in \@carrera {
					\ifnum\xi=\yi \MakeUppercase\x  { \MakeUppercase\y } \\[10pt] \fi
				}
			}

		\vspace{1cm}
			\MakeUppercase\@author

		\vspace{3cm}
			\foreach \x [count=\xi] in \@guia {
				PROFESOR GUÍA\ifnum\xi>1 \ \xi \fi:\\ \MakeUppercase\x\\
			}

		\vspace{1cm}
			MIEMBROS DE LA COMISIÓN:\\
			\foreach \x in \@comision { \MakeUppercase\x\\ }
		
		\if\@auspicio\@empty\else

		\vfill
			\normalfont
			Este trabajo ha sido parcialmente financiado por \@auspicio
		\fi

		\vfill
			SANTIAGO DE CHILE\\ \MakeUppercase\@fecha
	\end{titlepage}
}

%% Estilo del frontmatter
\newcommand{\ps@front}{
	\renewcommand{\thepage}{\roman{page}}
	\renewcommand{\@oddhead}{}
	\renewcommand{\@evenhead}{}
	\renewcommand{\@oddfoot}{\hfill\thepage\hfill}
	\renewcommand{\@evenfoot}{\hfill\thepage\hfill}
}

\let\oldfrontmatter\frontmatter
\renewcommand{\frontmatter}{
	\pagestyle{front}
	\oldfrontmatter
}
\let\oldfrontmatter\relax

%%----------------------------------------------------------------------------------------------
%% Miscelaneos
%%----------------------------------------------------------------------------------------------
\newcommand{\A}{\mathcal{A}}
%\newcommand{\C}{\mathbb{C}}
\newcommand{\D}{\mathbb{D}}
\newcommand{\E}{\mathbb{E}}
\newcommand{\F}{\mathcal{F}}
\newcommand{\G}{\mathcal{G}}
\renewcommand{\H}{\mathcal{H}}
\newcommand{\K}{\mathcal{K}}
\renewcommand{\L}{\mathcal{L}}
\newcommand{\M}{\mathcal{M}}
\newcommand{\N}{\mathbb{N}}
\renewcommand{\M}{\mathcal{M}}
\renewcommand{\P}{\mathbb{P}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\renewcommand{\S}{\mathcal{S}}
\newcommand{\T}{\mathcal{T}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\1}{\mathbf{1}}
\let\epsilon\varepsilon

% Estilo de listas
\renewcommand{\labelitemi}{\tiny$\blacksquare$}


\newcommand*\aap{A\&A}
\let\astap=\aap
\newcommand*\aapr{A\&A~Rev.}
\newcommand*\aaps{A\&AS}
\newcommand*\actaa{Acta Astron.}
\newcommand*\aj{AJ}
\newcommand*\ao{Appl.~Opt.}
\let\applopt\ao
\newcommand*\apj{ApJ}
\newcommand*\apjl{ApJ}
\let\apjlett\apjl
\newcommand*\apjs{ApJS}
\let\apjsupp\apjs
\newcommand*\aplett{Astrophys.~Lett.}
\newcommand*\apspr{Astrophys.~Space~Phys.~Res.}
\newcommand*\apss{Ap\&SS}
\newcommand*\araa{ARA\&A}
\newcommand*\azh{AZh}
\newcommand*\baas{BAAS}
\newcommand*\bac{Bull. astr. Inst. Czechosl.}
\newcommand*\bain{Bull.~Astron.~Inst.~Netherlands}
\newcommand*\caa{Chinese Astron. Astrophys.}
\newcommand*\cjaa{Chinese J. Astron. Astrophys.}
\newcommand*\fcp{Fund.~Cosmic~Phys.}
\newcommand*\gca{Geochim.~Cosmochim.~Acta}
\newcommand*\grl{Geophys.~Res.~Lett.}
\newcommand*\iaucirc{IAU~Circ.}
\newcommand*\icarus{Icarus}
\newcommand*\jcap{J. Cosmology Astropart. Phys.}
\newcommand*\jcp{J.~Chem.~Phys.}
\newcommand*\jgr{J.~Geophys.~Res.}
\newcommand*\jqsrt{J.~Quant.~Spec.~Radiat.~Transf.}
\newcommand*\jrasc{JRASC}
\newcommand*\memras{MmRAS}
\newcommand*\memsai{Mem.~Soc.~Astron.~Italiana}
\newcommand*\mnras{MNRAS}
\newcommand*\na{New A}
\newcommand*\nar{New A Rev.}
\newcommand*\nat{Nature}
\newcommand*\nphysa{Nucl.~Phys.~A}
\newcommand*\pasa{PASA}
\newcommand*\pasj{PASJ}
\newcommand*\pasp{PASP}
\newcommand*\physrep{Phys.~Rep.}
\newcommand*\physscr{Phys.~Scr}
\newcommand*\planss{Planet.~Space~Sci.}
\newcommand*\pra{Phys.~Rev.~A}
\newcommand*\prb{Phys.~Rev.~B}
\newcommand*\prc{Phys.~Rev.~C}
\newcommand*\prd{Phys.~Rev.~D}
\newcommand*\pre{Phys.~Rev.~E}
\newcommand*\prl{Phys.~Rev.~Lett.}
\newcommand*\procspie{Proc.~SPIE}
\newcommand*\qjras{QJRAS}
\newcommand*\rmxaa{Rev. Mexicana Astron. Astrofis.}
\newcommand*\skytel{S\&T}
\newcommand*\solphys{Sol.~Phys.}
\newcommand*\sovast{Soviet~Ast.}
\newcommand*\ssr{Space~Sci.~Rev.}
\newcommand*\zap{ZAp}

\providecommand{\bjdtdb}{\ensuremath{\rm {BJD_{TDB}}}}
\providecommand{\feh}{\ensuremath{\left[{\rm Fe}/{\rm H}\right]}}
\providecommand{\teff}{\ensuremath{T_{\rm eff}}}
\providecommand{\ecosw}{\ensuremath{e\cos{\omega_*}}}
\providecommand{\esinw}{\ensuremath{e\sin{\omega_*}}}
\providecommand{\msun}{\ensuremath{\,M_\Sun}}
\providecommand{\rsun}{\ensuremath{\,R_\Sun}}
\providecommand{\lsun}{\ensuremath{\,L_\Sun}}
\providecommand{\mj}{\ensuremath{\,M_{\rm J}}}
\providecommand{\rj}{\ensuremath{\,R_{\rm J}}}
\providecommand{\me}{\ensuremath{\,M_{\rm E}}}
\providecommand{\re}{\ensuremath{\,R_{\rm E}}}
\providecommand{\fave}{\langle F \rangle}
\providecommand{\fluxcgs}{10$^9$ erg s$^{-1}$ cm$^{-2}$}



\newcommand{\chapterauthor}[1]{%
  {\parindent0pt\vspace*{5pt}%
  \linespread{1.1}\normalsize\scshape#1%
  \par\nobreak\vspace*{35pt}}
  \@afterheading%
}