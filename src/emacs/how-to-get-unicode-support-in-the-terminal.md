date:    2012-10-07
category: emacs
title: How To Get Unicode in the Terminal
<div style="float: right">
<img src="../graphics/emacs.png" alt="png"/>

These days, getting unicode support in the X version (or
Windows version for that matter) of Emacs is easy. It just
works out of the box. However, to get all international
characters to work (Chinese, Bangla and so on) when running
Emacs in a terminal inside an SSH session, I've found it
necessary to make some more changes.

## My additions to .emacs
    ;; UTF-8 support
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

      

With these settings in place, UTF-8 works, even in my <a
href="https://launchpad.net/vm">VM mail reader</a>.

## Other Things to Remember
### Terminal

Use a terminal that supports unicode characters. I use
```urxvt```

### Font

Be sure that the shell uses a font that can display unicode
characters. The default font (e.g.```-fn 7x14```)
should do fine.

### Locale

Your system should have a locale that supports utf-8

    $ locale -a | grep-i utf


If this doesn't list anything, generate one. On Debian based systems, you can do:
    # dpkg-reconfigure locales


Be sure to use this locale to ensure that applications picks
up that you want unicode support. These are my settings in
```/etc/environment```

    export LC_ALL=en_GB.utf8
export LANG=en_GB.utf8


