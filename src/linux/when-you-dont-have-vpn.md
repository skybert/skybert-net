title: When You Wish You Had VPN 
date: 2018-08-06
category: linux
tags: linux


## On a machine on the internal network

```text
$ ssh -A server.internal
```

## On server.internal

```text
$ ssh -A -R 6662:localhost:22 public.server
```

## On external.machine 

```text
$ ssh -A -L 7780:localhost:7780 public.server
```

## On public.server

```text
$ ssh -p 6662 -L 7780:localhost:7780 user-on-server-internal@localhost
```

## On server.internal

Install a simple HTTP proxy:

```text

$ mkdir http-proxy
$ cd http-proxy
$ wget https://raw.githubusercontent.com/abhinavsingh/proxy.py/develop/proxy.py
$ python proxy.py 7780
```

## On external.machine

To test that the two tunnels and HTTP proxy are working, do:

```text
$ export http_proxy=localhost:7780
$ wget -O - http://internal.web.site
```
 
You can now set your browser up to access the internet through an HTTP
proxy located at `localhost:7780` and it'll be just like you were on
the internal network.

