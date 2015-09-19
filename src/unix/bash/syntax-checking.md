title: BASH linter
date: 2015-09-19
category: bash
tags: unix, bash, emacs

There's a good linter for BASH called
[ShellCheck](http://hackage.haskell.org/package/ShellCheck), it can be
installed on Debian based systmes with:

```
# apt-get install shellcheck
```

You can then invoke it simply from the command line to get feedback on
your shell script. The messages are colour coded to indicate their
severity: green, yellow and red:

<img
  class="centered"
  src="/graphics/2015/shellcheck.png"
  alt="shellcheck"
/>

## On the fly syntax checking in Emacs

It's easy getting on the fly linting of the BASH scripts you're
working on by installing [flycheck](http://www.flycheck.org):

<img
  class="centered"
  src="/graphics/emacs/2015/flycheck-bash.png"
  alt="flycheck bash"/>


```
M-x package-install flycheck
```

and enable it everwhere:

```lisp
(setq global-flycheck-mode t)
```

It will now pick up whatever linting tool you've installed for the
current mode, e.g. `shellcheck`. For a list of all languages and
linting tools it supports out of the box, have a look at
[this list ](http://www.flycheck.org/manual/latest/Supported-languages.html#Supported-languages).

