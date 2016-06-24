date:    2012-10-07
category: craftsmanship
title: Insert spaces instead of TABs

## tl;dr

If you want an easier life, make sure that all your editors insert
spaces instead of TABs.

## Background

Every single project I've worked on since 2003, there has been an
issue with someone on the project either not knowing the difference
between TABs and spaces or not taking heed that all his or her editing
environments are set properly up to deal with this. A lot of
developers doesn't even know there is a difference. All they know, is
that it looks nice "on their computer".  The result is commits with
too many lines changed and source code looking like a wreck because of
inconsistent indentation.

## The problem
If there's not a clear strategy of how to (or not use) TABs and
characters, you end up with source code which look different in
differnt editors, or when viewing them on the command line, when
browsing the source code in the web browser or when using a code
diffing utility. Inconsistent TAB/space usage also leads to code
commits affecting far more lines of code than what actually was the
real change intended by the developer.

When a file has inconsistent indentation, it looks messy (in Java
projects, this is often the XML files). When a file looks messy,
people stop caring about it. It becomes a
[broken window](http://en.wikipedia.org/wiki/Broken_windows_theory)
and the code starts to rot.

There are also cases where TABs will break things, like YAML files
which requires indentation to be spaces only.

## Set up ALL your editors to insert spaces instead of TABs
Be sure that all the editors you're using are set up to insert spaces
instead of TABs.

### Emacs
Be sure to include this in your```.emacs```:

    (setq-default indent-tabs-mode nil)

### VIm
Be sure to include this in your```.vimrc```:

    set softtabstop=2
    set expandtab

### Notepad++

Settings → Preferences → Tab Settings → Replace by space (checkbox)

### IntelliJ IDEA

Be sure this checkbox is **not** selected:

<img src="/graphics/2016/2016-06-20-idea-no-tabs.png"
     alt="intellij idea no TABs"/>

### Eclipse

Be sure this checkbox **is** selected:

<img src="/graphics/2016/2016-06-20-eclipse-no-tabs.png"
     alt="Eclipse no TABs"/>

## Replacing all TABs with spaces in a file

You can either copy a TAB character in your file and use the
"Search and replace" feature in your editor to replace them
with spaces. Alternatively, and is a better option if you
want to unTABify many files, you can
use```sed```. The following examples conerts TABs
with two spaces and should work on both Unix, Linux and
Windows/Cygwin systems:

    $ sed 's/\t/  /g' -i myfile.txt

To do this on a number of files (Java files in the below
example), you should be able to do:

     $ find . -name "*.java" | while read f; do (sed -i 's/\t/  /g' "$f"); done

## Becoming more aware of whitespace

### Emacs
You can easily turn on and off the display of whitespace with:

    M-x whitespace-mode

### IntelliJ IDEA
IDEA has this in its General > Appearance settings:

<img src="/graphics/2015/idea-show-whitespace.png" alt="intellij idea"/>

## No rule without exception

There's one notable exception here, where TABs not only is allowed,
but even required and that's with `Makefile`s.
