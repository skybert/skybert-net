title: How to set my default browser
date: 2015-12-07
tags: linux
category: linux

How does my system know which browser is the default? Or indeed any
default something application?

```
$ cat ~/.config/mimeapps.list
[Default Applications]
text/html=userapp-Iceweasel-EZC28X.desktop
..

[Added Associations]
application/octet-stream=emacs24.desktop;
application/x-virtualbox-vmdk=userapp-virtualbox-LJU14X.desktop;
text/html=iceweasel.desktop;userapp-Iceweasel-EZC28X.desktop;
..
```

The .desktop files correspond to one of the files you have under
`.local/share/applications/`, e.g. this one for Iceweasel:

```
$ ls ~/.local/share/applications/userapp-Iceweasel-EZC28X.desktop
```
