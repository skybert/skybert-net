title: Navigate to a function in your Python, C, Java, Elisp file
category: emacs
tags: emacs
date: 2015-12-14

There are lots of great special purpose extensions for your favourite
language in Emacs (e.g. I use `emacs-eclim` for Java), but there's a
small gem called `imenu` which gives you a lot of this for free
without any setup of any can. 

It scans the source code in your buffer and provides these in a
menu. Combining this with a completion like `helm-imenu`, you have a
really neat simple code navigation for any source file you open. No
setup required.

For the time being, I prefer using vanilla `imenu` together with
`ido-ubiquitous` and `ido-vertical-mode` over `helm-imenu` as ido
gives a faster experience and it doesn't alter my UI too much.

<img class="centered" src="/graphics/2015/imenu-java.png" alt="imenu"/>

I've bound `imenu` to <kbd>Ctrl</kbd>+<kbd>,</kbd>:

```
(global-set-key (kbd "C-,") 'imenu)
```

Happy hacking.

