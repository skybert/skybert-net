date:    2012-10-07
category: latex
title: Wrting Letters in LaTeX

This is how I write letters using LaTeX. Once you have the
template, it's <em>so</em> easy to write letters, you don't
have worry about getting the layout right; LaTeX will take
care of everything for you!


```latex
\documentclass[a4paper,12pt]{letter}
\usepackage[norsk]{babel}
\usepackage[utf8]{inputenc}
\usepackage{url}

\name{Torstein Krause Johansen}
\address
{
Torstein Krause Johansen\\
My house 2\\
0001 Oslo
}
\date{Oslo, den 26. April 2009}

\begin{document}
\begin{letter}
{
The Person\\
To Whom I'm writing\\
0342 OSLO
}
\opening{Kjære ...,}

jeg skriver til Dem vedrørende...

\closing{Med vennlig hilsen,}
\signature{Torstein Krause Johansen}

\end{letter}
\end{document}
```


