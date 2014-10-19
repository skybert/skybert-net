date:    2012-10-07
category: latex
title: Writing Chinese Letters
tags: debian, linux

I have the following Chinese related latex (Debian)
packages installed:

    $ dpkg -l *chinese* | grep latex| cut -d' ' -f3
    latex-cjk-chinese
    latex-cjk-chinese-arphic-bkai00mp
    latex-cjk-chinese-arphic-bsmi00lp
    latex-cjk-chinese-arphic-gbsn00lp
    latex-cjk-chinese-arphic-gkai00mp


Around the block of text where I write Chinese characters,
I put the CJK block (this can just as well be around the
full text:

```
\documentclass[a4paper,12pt]{letter}
\usepackage[british]{babel}
\usepackage[utf8]{inputenc}
\usepackage{CJK}

[..]

\begin{document}
[..]

\begin{CJK*}{GB}{gbsn}
Chinese letters can be written here
% the newpage *must* be there
<span class="red">\newpage
\end{CJK*}

[..]

\end{document}
```

Also see the```/usr/share/doc/latex-cjk-chinese/examples``` directory,
as with many things, there are different ways of doing it.


