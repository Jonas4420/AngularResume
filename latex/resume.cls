\ProvidesClass{resume}
\LoadClass{article}

%----------------------------------------------------------------------------------------
% PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[sfdefault, light]{roboto}

\RequirePackage{enumitem}
\RequirePackage{fontawesome}
\RequirePackage[margin=0cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{tikz}
\RequirePackage{xcolor}

\usetikzlibrary{calc,positioning}

%----------------------------------------------------------------------------------------
% COLOURS
%----------------------------------------------------------------------------------------

\definecolor{cv-white}{HTML}{F5F3F5}
\definecolor{cv-light-grey}{HTML}{EFEDEF}
\definecolor{cv-grey}{HTML}{CECCCE}
\definecolor{cv-dark-grey}{HTML}{222022}
\definecolor{cv-black}{HTML}{1B1A1B}
\definecolor{cv-green}{HTML}{6EAD3A}

%----------------------------------------------------------------------------------------
% PROFILE COMMANDS
%----------------------------------------------------------------------------------------

\newcommand{\cvprofile}[1]{\renewcommand{\cvprofile}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

\newcommand{\cvemail}[1]{\renewcommand{\cvemail}{#1}}
\newcommand{\cvphone}[1]{\renewcommand{\cvphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvcity}[1]{\renewcommand{\cvcity}{#1}}
\newcommand{\cvcountry}[1]{\renewcommand{\cvcountry}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}

\newcommand{\cvdegrees}[1]{\renewcommand{\cvdegrees}{#1}}
\newcommand{\cvlanguages}[1]{\renewcommand{\cvlanguages}{#1}}
\newcommand{\cvinterests}[1]{\renewcommand{\cvinterests}{#1}}

\newcommand{\cvabout}[1]{\renewcommand{\cvabout}{#1}}
\newcommand{\cvexperiences}[1]{\renewcommand{\cvexperiences}{#1}}
\newcommand{\cvskills}[1]{\renewcommand{\cvskills}{#1}}

%----------------------------------------------------------------------------------------
% PAGE CONFIGURATION
%----------------------------------------------------------------------------------------

\pagestyle{empty}

\pagecolor{cv-white}
\color{cv-black}

\hypersetup{
    colorlinks=true
}

\newcommand{\cvsmallspace}{3pt}
\newcommand{\cvspace}{7pt}
\setlength{\parindent}{0pt}
\setlength{\tabcolsep}{0em}

\tolerance=1
\emergencystretch=\maxdimen
\hyphenpenalty=10000
\hbadness=10000

%----------------------------------------------------------------------------------------
% SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{3.5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength}
\newlength{\SectionTitleLength}

\newcommand{\sbprofile}{%
    \begin{tikzpicture}[x=\imagescale,y=-\imagescale]%
        \clip (600/2, 600/2) circle (600/2);%
        \node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\cvprofile}};%
        \draw[cv-white, line width=3pt] (600/2, 600/2) circle (600/2);%
    \end{tikzpicture}%
    \vspace{0.5cm}
}

\newcommand{\sbname}{%
    {\huge\textcolor{cv-white}{\textbf\cvname}}%
    \vspace{0.2cm}%
}

\newcommand{\sbjobtitle}{%
    {\large\textcolor{cv-grey}{\cvjobtitle}}%
}

\newcommand{\sbicon}[1]{\textcolor{cv-white}{#1}}
\newcommand{\sblang}[1]{\textcolor{cv-white}{\textbf{#1}}}
\newcommand{\sbtext}[1]{\textcolor{cv-grey}{#1}}
\newcommand{\sbdesc}[1]{{\small\textcolor{cv-grey}{\textit{#1}}}}
\newcommand{\sburl}[2]{\href{#1#2}{\textcolor{cv-grey}{#2}}}

\newcommand{\sbcontact}{%
    \begin{tabular}{l@{\hskip 0.2cm}l}%
        \sbicon{\faHome}     & \sbtext{\cvaddress}\\%
                             & \sbtext{\cvcity, \textsc{\cvcountry}}\\[\cvspace]%
        \sbicon{\faEnvelope} & \sburl{mailto:}{\cvemail}\\[\cvspace]%
        \sbicon{\faPhone}    & \sbtext{\cvphone}\\[\cvspace]%
        \sbicon{\faLinkedin} & \sburl{http://}{\cvlinkedin}\\[\cvspace]%
        \sbicon{\faGithub}   & \sburl{http://}{\cvgithub}\\%
    \end{tabular}%
}

\newcommand{\sbsection}[1]{%
    \vspace{0.75cm}%
    {\color{white}\Large\textbf{\uppercase{#1}}}%
    \vspace{0.75cm}%
}

\newcommand{\sbdegree}[6]{%
    \textcolor{cv-white}{\textbf{#1}}\textcolor{cv-grey}{\textit{, #2}}\\[\cvsmallspace]%
    \textcolor{cv-grey}{#3, \textsc{#4}}\\%
    \textcolor{cv-grey}{\textit{#5 -- #6}}%
}

%----------------------------------------------------------------------------------------
% RESUME DEFINITIONS
%----------------------------------------------------------------------------------------

\newcommand*\circled[1]{\tikz[baseline=(char.base)]{%
            \node[shape=circle, fill=cv-green, text=cv-white, inner sep=2pt] (char) {#1};}}
\newcommand{\cvsection}[2]{\vspace{0.05cm}\section*{\circled{#1} \uppercase{#2}}\vspace{0.15cm}}

\newcommand{\cvexp}[4]{%
    {\large\textcolor{cv-black}{\textbf{#1}}}\hspace*{\fill}{\normalsize\textit{#2}}\\[\cvsmallspace]%
    \textcolor{cv-dark-grey}{\textbf{#3, \textsc{#4}}}\\[\cvspace]
}

\newcommand{\cvexpdesc}[1]{%
    \vspace{-\topsep}%
    \begin{itemize}[noitemsep,topsep=0pt,leftmargin=*]%
    #1
    \end{itemize}%
}
\newcommand{\cvskill}[1]{{\large\textcolor{cv-black}{\textbf{#1}}}}
\newcommand{\cvbullet}{\hspace*{0.25cm}\textbf{\textbullet}\hspace*{0.25cm}}

\newcommand{\cvskillbar}[2]{%
    \begin{tikzpicture}%
        \filldraw [fill=#2, draw=cv-black] (0,0) rectangle ({#1*11.5/100},0.25);%
        \filldraw [fill=cv-grey, draw=cv-black] ({#1*11.5/100},0) rectangle (11.5,0.25);%
    \end{tikzpicture}%
}
