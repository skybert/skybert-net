title: LXD debugging
date: 2021-05-26
category: linux
tags: linux, lxd, containers

## Enable debug logging
```text
# snap set lxd daemon.debug=true
# systemctl reload snap.lxd.daemon
```


## Log

```text
/var/snap/lxd/common/lxd/logs/lxd.log
```

## Reload LXD only

```text
# systemctl reload snap.lxd.daemon
```
