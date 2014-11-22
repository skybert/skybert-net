date:    2012-10-07
title: How To Get Unicode working in the Terminal
category: unix
tags: emacs, encoding, utf-8, bash, unix, cygwin, putty

These days, getting Unicode support in most applications is easy. It
usually just works out of the box.

However, to get all international characters to work (Chinese, Bangla
and so on) when running Emacs in a terminal inside an SSH session,
I've found it necessary to make some more changes. I've seen others
having the same kind of issues when running local terminal sessions or
remote ssh sessions too, so here's a runthrough of the typical things
you need to sort out when you encounter problems related to displaying
international characters.

## Terminal

Use a terminal that supports unicode characters. I use
[urxvt](http://software.schmorp.de/pkg/rxvt-unicode.html).

## Font

Be sure that the shell uses a font that can display unicode
characters. Otherwise, you'll see a rectangle instead of the
international character, just like the yellow National Geographic
frame (except that you'll probably see white ones).

The default font (e.g. the font you get when you start your terminal
(e.g. urxvt or xterm) with the parameter ```-fn 7x14```) should do
fine.

If you're using a terminal emulator like
[PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)
or the default [Cygwin](http://cygwin.com) shell, checkout their
settings dialogues for a font which supports Unicode characters.

## Locale

Your system must have a locale that supports utf-8 in order for
Unicode characters to be displayed correctly (strictly speaking, any
Unicode encoding would do, but for all practical purposes, using,
describing and referring to utf-8 will suffice).

    $ locale -a | grep -i utf

If this doesn't list anything, generate one. On Debian based systems, you can do:

    # dpkg-reconfigure locales

Be sure to use this locale to ensure that applications picks
up that you want unicode support. These are my settings in
```/etc/environment```:

    export LC_ALL=en_GB.utf8
    export LANG=en_GB.utf8

You can also set these in your user's settings file,
e.g. ```~/.basrhc```.

You must activate these settings, the easiest of which is to ```source
.bashrc``` or whatever file you wrote these settings to.


## My additions to .emacs
<img class="right" src="/graphics/emacs.png" alt="png"/>

```
;; UTF-8 support
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
```

With these settings in place, UTF-8 works, even in my <a
href="https://launchpad.net/vm">VM mail reader</a>.

