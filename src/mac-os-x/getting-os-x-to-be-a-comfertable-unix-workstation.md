date:    2012-03-01
category: mac-os-x
tags: mac-os-x, bash, emacs
title: Make OS X into a Comfortable UNIX Workstation

## Install GNU core utils

The GNU core utils is light years ahad of the BSD utils that come with
Mac OS X. The GNU equivalents of `find`, `date` & friends have many
more feature and generally have so much better defaults than their Mac
OS X counterparts. Installing this is something you definitely want.

### Using Mac Ports

First off, install the GNU core utils, GNU awk and GNU sed so
that we can get most of the basic command line power we're
used to from GNU/Linux:

    $ sudo port install gawk gsed coreutils

### Using brew

If you're using `brew` the equivalent is:

    $ sudo brew install coreutils gnu-getopt gnu-tar gnu-sed gawk

While you're at it, you probably want to install a more updated
version of BASH as well:

    $ sudo brew install bash

Read <a
href="http://apple.stackexchange.com/questions/69223/how-to-replace-mac-os-x-utilities-with-gnu-core-utilities">this
article</a> for more instructions on how to install GNU coreutils
using brew.

### Preferring GNU coreutils over BSD utils

Prefer GNU core utils over the ancient BSD utils that come
with Mac. Add this to your```.bashrc```:

    export PATH=/opt/local/libexec/gnubin:$PATH

A wee test to see if the GNU core utils have taken precedence
on your system is to run:

    $ date --iso

If it returns a date like 2012-03-01, you're homefree

## Spell checking

I cannot live without `aspell`, so I also install
this:

    $ sudo port install aspell aspell-dict-en aspell-dict-uk

## Emacs

<img class="right" src="/graphics/emacs/emacs.png" alt="Emacs"/>

Install the latest, full
[graphical GNU Emacs for Mac OS X](http://emacsformacosx.com/) and let
it answer to the standard ```/usr/bin/emacs```:

    $ sudo mv /usr/bin/emacs /usr/bin/emacs.mac-os-x
    $ sudo ln -s /Applications/Emacs.app/Contents/MacOS/Emacs /usr/bin/emacs

Now, whenever you type `emacs`, the latest and greatest GNU Emacs
version will open and not the old and outdated version that comes
bundled with Mac OS X.

## A better terminal

I recommend installing [iTerm 2](https://www.iterm2.com/) as it's
[far better than the Terminal application](https://www.iterm2.com/features.html)
that comes with OS X as standard. If you come from Linux, you'll
find many features you miss after moving to Mac land in iTerm 2.
