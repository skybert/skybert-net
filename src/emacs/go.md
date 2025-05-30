title: Go programming in Emacs
date: 2023-12-09
category: emacs
tags: emacs, go


## Go tool chain

```text
# pacman -S go
```

## Go LSP server

```text
# pacman -S gopls
```

## Go debugger

```text
# pacman -S delve
```

## Emacs

Set up `go-mode`:

```lisp
(use-package go-mode
  :ensure t
  :hook (go-mode . subword-mode)
  :hook (go-mode . (lambda () (eglot-ensure))))
```

Set up `dape` for debugging:

```lisp
(use-package dape
  :ensure t
  :init
  (setq dape-buffer-window-arrangement 'right))
```
