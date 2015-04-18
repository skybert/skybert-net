date: 2015-04-16
category: emacs
tags: python, emacs
title: Programming Python in Emacs

[Emacs](http://gnu.org/software/emacs) is an excellent programming
environment for Python. I've selected a handful of packages here that
together give a very neat coding experience. There are many
alternatives for just about every package on display here, but these
are my current favourites when coding Python.

## Auto completion, syntax checking and method help
In just this wee picture you see several great Emacs features at play:
auto completion by
[anaconda-mode](https://github.com/proofit404/anaconda-mode) and
[autocomplete-mode](http://auto-complete.org/), on the fly syntax
checking using [pyflakes](https://github.com/pyflakes/pyflakes/) and
[flymake](https://www.gnu.org/software/emacs/manual/html_mono/flymake.html),
as well as intelligent method help in the minibuffer thanks to
[eldoc](http://emacswiki.org/emacs/ElDoc) and
[anaconda-mode](https://github.com/proofit404/anaconda-mode):

<img src="/graphics/emacs/2015/anaconda-ac-eldoc-pyflakes.png"
     alt="python in emacs"
     class="centered"/>

## Auto completion with documentation lookup
If you just hold on for a bit longer, Emacs will also give you the
full documentation of the method which you are about to complete:

<img src="/graphics/emacs/2015/anaconda-ac-doc-eldoc-pyflakes.png"
     alt="python in emacs"
     class="centered"/>

## Documentation lookup
anaconda-mode will also look up any documentation for you on any
symbol when you hit `M-?`:

<img src="/graphics/emacs/2015/anaconda-doc-lookup.png"
     alt="python doc lookup in emacs"
     class="centered"/>


## Code navigation
anaconda-mode hooks into Emacs' standard tagging feature, which means
you use the standard shortcut `M-.` for jumping to the definition of
the symbol under your cursor and `M-*` for jumping back to where you
were. It's really, really fast and let's you drill down or up your call
stacks with amazing speed.

## Show usage of symbol at point

Hitting `M-r` will show you all the usages in your project of the
symbol at point:

<img src="/graphics/emacs/2015/anaconda-usages.png"
     alt="python usage in emacs"
     class="centered"/>

## Embedded Python shell
Naturally, Emacs gives you a Pythons hell inside Emacs so that you
easily can try out code before adding it to your own source code. Just
type `M-x python-shell-switch-to-shell` and the Python interpreter
opens up in a new buffer:

<img src="/graphics/emacs/2015/python-shell-in-emacs.png"
     alt="python shell in emacs"
     class="centered"/>

## sys.exit(0)

And that concludes my wee tour through some of Emacs' Python
features. Happy coding!

## Useful links

- [My Python](https://github.com/skybert/my-little-friends/blob/master/emacs/.emacs.d/tkj-python.el)
  and [projectile & ido](https://github.com/skybert/my-little-friends/blob/master/emacs/.emacs.d/tkj-smart-file-name-completion.el)
  setup in Emacs
- [anaconda-mode](https://github.com/proofit404/anaconda-mode)
- [autocomplete-mode](http://auto-complete.org/)
- [pyflakes](https://github.com/pyflakes/pyflakes/)
- [flymake](https://www.gnu.org/software/emacs/manual/html_mono/flymake.html),
- [eldoc](http://emacswiki.org/emacs/ElDoc)

