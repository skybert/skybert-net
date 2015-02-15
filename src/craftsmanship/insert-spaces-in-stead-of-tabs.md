date:    2012-10-07
category: craftsmanship
title: Insert spaces instead of TABs

## Background
Every single project I've worked on since 2003, there has been an
issue with someone on the project either not knowing the difference
between TABs and spaces or not taking heed that all his or her editing
environments are set properly up to deal with this. A lot of
developers doesn't even know there is a difference. All they know, is
that it looks nice "on their computer".  Hence, I've written this
article to aid in the quest of consistent editing of whitespace.

## The problem
If there's not a clear strategy of how to (or not use) TABs and
characters, you end up with source code which look different in
differnt editors, or when viewing them on the command line, when
browsing the source code in the web browser or when using a code
diffing utility. Inconsistent TAB/space usage also leads to code
commits affecting far more lines of code than what actually was the
real change intended by the developer.

## tl;dr
To cut a long story short: if you want an easier life, make sure that
all your editors insert spaces instead of TABs.

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

## Replacing all TABs with spaces in a file

You can either copy a TAB character in your file and use the
"Search and replace" feature in your editor to replace them
with spaces. Alternatively, and is a better option if you
want to unTABify many files, you can
use```sed```. The following examples conerts TABs
with two spaces and should work on both Unix, Linux and
Windows/Cygwin systems:

    $ cat myfile.txt | sed 's/\t/  /g' > myfile.txt.spaces
    $ mv myfile.txt.spaces myfile.txt


To do this on a number of files (Java files in the below
example), you should be able to do:

     $ find . -name "*.java" | while read f; do (cat $f | sed 's/\t/  /g' > $f.spaces ; mv $f.spaces $f); done

## Becoming more aware of the whitespace

### Emacs
You can easily turn on and off the display of whitespace with:

    M-x whitespace-mode

### IntelliJ IDEA

