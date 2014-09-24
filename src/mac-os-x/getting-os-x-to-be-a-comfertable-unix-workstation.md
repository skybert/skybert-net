date:    2012-03-01
category: mac-os-x
title: Getting a proper BASH environment
## Using Mac Ports

First off, install the GNU core utils, GNU awk and GNU sed so
that we can get most of the basic command line power we're
used to from GNU/Linux:

    $ sudo port install gawk gsed coreutils

## Using brew

If you're using```brew``` the equivalent is:

    $ sudo brew install coreutils gnu-tar gnu-sed gawk


Read <a
href="http://apple.stackexchange.com/questions/69223/how-to-replace-mac-os-x-utilities-with-gnu-core-utilities">this
article</a> for more instructions on how to install GNU
coreutils using brew.

## Preferring GNU coreutils over BSD utils

Prefer GNU core utils over the ancient BSD utils that come
with Mac. Add this to your```.bashrc```:

    export PATH=/opt/local/libexec/gnubin:$PATH

A wee test to see if the GNU core utils have taken precedence
on your system is to run:

    $ date --iso

If it returns a date like 2012-03-01, you're homefree

## Spell checking

I cannot live without```aspell```, so I also install
this:

    $ sudo port install aspell aspell-dict-en aspell-dict-uk

## Emacs

Install the latest, full graphical GNU Emacs and let it answer
to the standard```/usr/bin/emacs```:

    $ sudo mv /usr/bin/emacs /usr/bin/emacs.mac-os-x
    $ sudo ln -s /Applications/Emacs.app/Contents/MacOS/Emacs /usr/bin/emacs
