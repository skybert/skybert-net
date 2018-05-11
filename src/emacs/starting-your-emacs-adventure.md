title: Starting Your Emacs Adventure
date: 2018-05-09
category: emacs
tags: emacs


## Install Emacs

```
# apt-get install emacs25
```

## Set up package repositories 📦
Emacs has loads of great plugins and it has a package manager to
install them. Add these three to your `~/.emacs`:


```lisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs package repositories
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;; Add the ELPA packages to the load path
(let ((default-directory "~/.emacs.d/elpa"))
  (normal-top-level-add-subdirs-to-load-path))
```

Be sure to create `~/.emacs.d`:

```text
$ mkdir ~/.emacs.d
```

## Start Emacs

```text
$ emacs &
```

## It's all about shortcuts ⌨

There are loads of shortcuts in Emacs. You need to know that `C` means
<kbd>Ctrl</kbd> and `M` means <kbd>Alt</kbd>. 

`M-x` thus means "press **Alt** and **x** at the same time".

`C-x C-s` means "press **Ctrl** and **x** at the same time, then press
**Ctrl** and **s** at the same time".

## Browse the available packages

```text
M-x list-packages
```

## Get a head start by following the built-in tutorial 

```text
C-h t
```

