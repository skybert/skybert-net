title: docker
date: 2018-02-26
category: linux
tags: linux, containers, docker


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

## Exposing a container's port to the world

When you use `docker run --publish` or use the `ports:` directive in
`docker-compose.yaml`, `docker` manipulates the firewall rules so that
requests from the outside world hits your container(s) on your
machine's local docker network.

You can see this with `iptables`:

```text
# iptables -t nat -L -n
[..]
Chain DOCKER (2 references)
target     prot opt source               destination         
RETURN     all  --  0.0.0.0/0            0.0.0.0/0           
RETURN     all  --  0.0.0.0/0            0.0.0.0/0           
RETURN     all  --  0.0.0.0/0            0.0.0.0/0           
RETURN     all  --  0.0.0.0/0            0.0.0.0/0           
DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:8600 to:172.18.0.6:8600
DNAT       udp  --  0.0.0.0/0            0.0.0.0/0            udp dpt:8600 to:172.18.0.6:8600
DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:8500 to:172.18.0.6:8500
DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:8400 to:172.18.0.6:8400
DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:9005 to:172.18.0.11:9005
DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:9006 to:172.18.0.12:9006
DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:8681 to:172.18.0.13:8681
DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:8680 to:172.18.0.13:8680
DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:443 to:172.18.0.14:443
hDNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:80 to:172.18.0.14:80
```

Here can you e.g. see that TCP connections to port `80` are redirected
to the `80` port on the container listening on `172.18.0.14`. To see
which container this is, you can do:

```text
$ docker ps -q | xargs docker inspect --format='{{printf "%.12s" .Id}} {{.Name}} {{range $net, $conf := .NetworkSettings.Networks}}{{$conf.IPAddress}}{{end}}'
1fce6f177878 /docker_um_1 172.18.0.14
e090e4a7b24f /docker_cue_um_1 172.18.0.13
640209ed51f5 /docker_oxtrust_1 172.18.0.12
9ade8895cfee /docker_oxauth_1 172.18.0.11
3e56c960f227 /docker_ldap_1 172.18.0.10
c6a65e34acbd /docker_redis_1 172.18.0.8
2f0e8d5724dc /docker_consul_1 172.18.0.6
180e1335d460 /docker_consul-server-1_1 172.18.0.7
0ba6a1514df2 /docker_consul-agent-2_1 172.18.0.5
9333f66d802a /docker_consul-server-2_1 172.18.0.4
72add9eb3ab0 /docker_consul-agent-1_1 172.18.0.3
0c973a09bccf /docker_consul-agent-3_1 172.18.0.2
```

We now know that requests to port `80` on the host machine is routed
to port `80` on container `1fce6f177878` with name `docker_um`.

## Copy a file from the host machine to a running Docker container

```text
$ docker cp tmp/n.class cdde6a98ba79:/tmp/n.class
```

Where `cdde6a98ba79` is the Docker ID of the running container, as
seen with e.g. `docker ps`. 
