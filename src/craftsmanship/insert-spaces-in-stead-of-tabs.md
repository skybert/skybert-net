date:    2012-10-07
category: craftsmanship
title: Insert TABs Instead of Spaces

Most editors will insert a TAB character when you hit
the```TAB``` key. However, this makes the code look
different whereever you view it as the environment in which
you view the file all have a different understanding of what
a TAB character mean.


A lot of developers doesn't even know there is a
difference. All they know, is that it looks nice "on their
computer".


Be sure that all the editors you're using are set up to
insert spaces instead of TABs.

## Emacs
<p>Be sure to include this in your```.emacs```
    (setq-default indent-tabs-mode nil)

## VIm
<p>Be sure to include this in your```.vimrc```
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

