title: BASH syntax checking
date: 2016-06-29
category: emacs
tags: emacs, bash

<img
  src="/graphics/2016/2016-06-29-emacs-flycheck-shell.png"
  alt="flycheck in emacs"
  class="centered"
/>

It's easy to get on the fly syntax checking in Emacs (aka
linting). You just two things: `shellcheck` and `flycheck-mode`.

The former is a shell command which on Debian based systems can be
installed with:

```
# apt-get install shellcheck
```

The other thing you need is the Emacs plugin `flycheck` which can be
installed in Emacs with:

```
M-x package-install RET flycheck
```

Now, you're all set. If you enable flycheck in your `.sh` buffers, you
get on the fly syntax checking!
