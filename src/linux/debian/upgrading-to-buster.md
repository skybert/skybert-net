title: Upgrading to Debian Buster
date: 2019-07-08
category: linux
tags: linux, debian

Mostly a smooth upgrade (2000 packages in all for my laptop going from
`stretch` to `buster`.

A couple of things broke, though:

## Network connection was broken
Even though I have entries for my wired and wireless network cards in
`/etc/network/interfaces`, NetworkManager insists on creating
problems.

The away around this, apart from removing NM, is to:

```text
# /etc/init.d/network-manager stop
# /etc/init.d/networking restart
```

## OpenGL 3.3 was broken (no kitty)
The remedy was to re-install the OpenGL drivers and restart the login manager
(`slim` in my case):
```text
# apt-get install --reinstall libgl1-mesa-dri libgl1-mesa-glx xserver-xorg-core
# /etc/init.d/slim restart
```

## Shortcut for clipit wasn't working

## LSP/java doesn't work for Emacs

Get this as if in an eternal loop:
```text
Server jdtls:1211 status:starting exited with status exit. Do you want to restart it? (y or n) n
```


