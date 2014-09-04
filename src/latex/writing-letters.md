date:    2012-10-07
category: latex
title: Wrting Letters in LaTeX

This is how I write letters using LaTeX. Once you have the
template, it's <em>so</em> easy to write letters, you don't
have worry about getting the layout right; LaTeX will take
care of everything for you!

    
<span class="purple">\documentclass</span>[<span class="orange">a4paper,12pt</span>]{<span class="blue">letter</span>}
\usepackage[norsk]{babel}
\usepackage[utf8]{inputenc}
\usepackage{url}

<span class="green">\name</span>{Torstein Krause Johansen}
<span class="purple">\address</span>
{
Torstein Krause Johansen\\
My house 2\\
0001 Oslo
}
<span class="purple">\date</span>{Oslo, den 26. April 2009}

\begin{document}
<span class="purple">\begin</span>{<span class="blue">letter</span>}
{
The Person\\
To Whom I'm writing\\
0342 OSLO
}
<span class="grey">\opening</span>{Kjære ...,}

jeg skriver til Dem vedrørende...

<span class="grey">\closing</span>{Med vennlig hilsen,}
<span class="grey">\signature</span>{Torstein Krause Johansen}

<span class="purple">\end</span>{<span class="blue">letter</span>}
\end{document}



