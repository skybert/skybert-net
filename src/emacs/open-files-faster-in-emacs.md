title: Open files faster in Emacs (and prettier)
date: 2015-12-14
category: emacs
tags: emacs

As all Emacs users know, the shortcut <kbd>Ctrl</kbd> + <kbd>x</kbd>
<kbd>Ctrl</kbd> + <kbd>f</kbd> opens a file. It's pretty neat with
lots of shortcuts and <kbd>Tab</kbd> completion.

<img class="centered" src="/graphics/2015/find-file.png" alt="find-file"/>

Today, I found a great improvement over `find-file`, namely
`ido-find-file`. Lots of people rave about `helm-find-file`, but it
doesn't allow me to <kbd>Tab</kbd> complete may way down the directory
tree and that just drives me nuts! `ido-find-file` on the other hand,
works pretty much as the traditional `find-file`, but enhances it by
fuzzy matching, vertical menu (thanks to `ido-vertical-mode`) and
different colour coding of files directories:

<img class="centered" src="/graphics/2015/ido-find-file.png" alt="ido-find-file"/>
