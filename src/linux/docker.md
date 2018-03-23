title: docker
date: 2018-02-26
category: linux
tags: linux, container, docker


## Docker networking doesn't work

### Possibility #1 - you've changed network access on the host

You've changed network configuration on your laptop and the `dockerd`
hasn't been restarted. 

I've found that if I change from e.g. wired to wireless on my laptop,
the outgoing network traffic from all docker containers is
broken. I've so far found no better way of remedying this than to
restart the `dockerd` and thus restarting the docker containers, since
they are all children of `dockerd`:

```text
# ifdown eth0
# ifup wlan0
# service docker restart
```

### Possibility #2 The firewall doesn't contain the docker hooks
Docker sets up a lot of networking for you "magically". For instance,
the `EXPOSE` directives in the `Dockerfile`s and the `docker run
--publish` parameter will set up network routing so that it's possible
for the host machine (and the outside world if it allows for this) to
access services listening on various ports inside the
container. Likewise, Docker ensures that one container can access the
services on another container by the `docker run --name` parameter.

For all of this to work, docker must have some pre-defined hooks in
your firewall setup. These hooks are called `chains` in the `iptables`
Linux firewall.

To ensure that the Docker firewall chains exists, run the following
command:

```text
# iptables -L | grep -i docker
DOCKER-USER  all  --  anywhere             anywhere            
DOCKER-ISOLATION  all  --  anywhere             anywhere            
DOCKER     all  --  anywhere             anywhere            
DOCKER     all  --  anywhere             anywhere            
Chain DOCKER (2 references)
Chain DOCKER-ISOLATION (1 references)
Chain DOCKER-USER (1 references)
```

If nothing is returned, you need to set up these chains so that Docker
can do its magic. 

These chains are set up with the `/etc/init.d/docker` script from the
`docker-ce` package on Debian systems. If the don't exist (perhaps
you've flushed your `iptables` rules?), try to restart the init.d
script. The chains should be re-created each time the script runs.

## Viewing logs

It seems to be the "Docker way" to only have one log per container and
that log should be redirected to standard out so that Docker's logging
framework can pick it up.

To see the standard out log of a container, do:

```text
$ docker logs -f <id>
```

To see the log of a named container, use `docker ps` first and ask it
to filter on name, `gluu-oxtrust` in my case:

```text
$ docker logs -f $(docker ps -qf "name=gluu-oxtrust")
```

> Skybert: what if the container has multiple log files and
> their difference carries significance?

> Skybert: how to see the standard error log? (`/dev/stderr`)

## Logging into a container by name

Here, I have a container with name `gluu-oxtrust` and I want to log
into it (which of course is a lie, there's no logging into containers,
they're running the host machine, but hey, let's pretend, shall we?):

```text
$ docker exec -ti $(docker ps -qf "name=gluu-oxtrust") /bin/bash
```

Since I do this _all_ the time, I've created
[drshell](https://github.com/skybert/dr/blob/master/bin/drshell)
which does the above, allowing me to type: `drshell <name>`.

## Overview of container IPs and ports exposed
```text
$ drps
CONTAINER ID  IMAGE                           CREATED              IP           PORTS                                                                                        NAMES
9ddf7adcb85d  gluufederation/nginx:latest     2018-02-28T13:44:14  172.18.0.5   map[443/tcp:[map[HostIp:0.0.0.0 HostPort:8085]] 80/tcp:[map[HostIp:0.0.0.0 HostPort:8084]]]  /gluu-nginx
1f879a8c1145  gluufederation/oxtrust:latest   2018-02-28T13:44:13  172.18.0.4   map[8080/tcp:[map[HostIp:0.0.0.0 HostPort:9981]]]                                            /gluu-oxtrust
53003952bb7b  gluufederation/oxauth:latest    2018-02-28T13:44:13  172.18.0.3   map[8080/tcp:[map[HostPort:9980 HostIp:0.0.0.0]]]                                            /gluu-oxauth
b524850b3af2  gluufederation/openldap:latest  2018-02-28T13:44:12  172.18.0.2   map[1389/tcp:<nil>]  
```

Since `docker ps` doesn't output the IP of the containers, I've
extended a snippet I found on the web to do it:
[drps](https://github.com/skybert/dr/blob/master/bin/drps)
