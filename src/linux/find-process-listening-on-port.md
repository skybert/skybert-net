title: Find process listening on a port
date: 2022-10-27
category: linux
tags: linux

In the old days, I used `netstat -nlp | grep -w <port>`. These days
(2022), `ss` the preferred tool to use:

```text
$ ss -lptn | grep -w 8080
LISTEN        0             4096                                   *:8080                             *:*            users:(("java",pid=205361,fd=327))
```


With `ss`, we can even do without the `grep` by asking for the
*source* port directly::

```text
$ ss -lptn 'sport = :8080'
State       Recv-Q      Send-Q           Local Address:Port             Peer Address:Port      Process
LISTEN      0           4096                         *:8080                        *:*          users:(("java",pid=205361,fd=327))
```
