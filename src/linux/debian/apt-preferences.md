date:    2012-10-07
category: linux
tags: debian
title: Preferring stable Debian packages

This is how I've configured my APT system to prioritise stable
packages, but also allow me to install packages from the
testing and unstable pools if I really want to. This is what's
called <cite>pinning</cite> in Debian lingo.

```
$ cat /etc/apt/preferences
Package: *
Pin: release a=stable
Pin-Priority: 700

Package: *
Pin: release a=testing
Pin-Priority: 650

Package: *
Pin: release a=unstable
Pin-Priority: 600
```

With this in place, whenever I do `apt-get install`, it will pick
packages from the stable package pool. If I want to install something
from e.g. the testing pool, I add the `-t` parameter:

```
# apt-get install -t testing iceweasel
```


