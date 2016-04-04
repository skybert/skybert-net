title: Taming NetworkManager
date: 2016-04-12
category: linux
tags: network, linux

I really, really dislike NetworkManager. From the way it's capitalised
(doesn't look like a Unix program),
the way it writes its configuration files (doesn't look like a Unix
program) and the way it works different than all other network
services on my system (doesn't feel like a Unix program).

Here are some of my notes on how to tame it.

## Stop it the old way
Stop it using good old `init.d` scripts (example from Debian):

```text
# /etc/init.d/network-manager stop
```

## Stop it the new way
Stop it using `systemd`:

```text
# systemctl stop NetworkManager.service
```

## Disable it the new way
Disable it using `systemd` so that it doesn't start again when you
reboot:

```text
# systemctl disable NetworkManager.service
```

## Uninstall it with apt-get

```text
# apt-get remove network-manager
```
