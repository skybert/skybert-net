title: Emacs on Windows
date: 2015-05-04
category: emacs
tags: emacs, windows

## Emacs client problems

If you get this error: "The directory `c:/.emacs.d/server' is unsafe"
it's probably because you've got the "Administrator" role in Windows
set on the file. To remedy this, change it to your own user, e.g. by
using Cygwin like so:

    $ chown -R "${USER}" ~/.emacs.d
