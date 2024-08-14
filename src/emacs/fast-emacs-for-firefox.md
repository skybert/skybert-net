title: Fast Emacs for Firefox
date: 2024-08-14
category: emacs
tags: emacs

Firefox looks up apps by mime type by searching the directory:
```text
/usr/share/applications/
```

If you've got Emacs installed, chances are that you have an
`emacs.desktop` file in there and that file tells the system to use
Emacs for opening a boat load of formats:

```conf
$ grep MimeType= /usr/share/applications/emacs.desktop
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
```

To make Firefox open Emacs with a _minimal_ configuration, I changed
the `Exec=` line like this:

```conf
Exec=/usr/bin/emacs -Q -l /home/torstein/src/skybert/my-little-friends/emacs/.emacs.minimal %F
```

Now, whatever desktop app wants to open any of the above file formats,
it opens it in a new Emacs process (I don't want to open it in my main
Emacs via `emacsclient`) with a minmal configuration file. Fast, yet
has some batteries included.



