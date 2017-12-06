title: Installing Emacs on OSX
date: 2017-12-06
category: mac-os-x
tags: mac-os-x, emacs

```
$ brew uninstall emacs
$ brew cleanup
$ brew doctor
$ brew install emacs --with-cocoa --with-gnutls --with-rsvg --with-imagemagick
$ brew linkapps emacs
```
