title: docker
date: 2018-02-26
category: linux
tags: linux, container, docker


## Docker networking doesn't work

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

## Logs

To see the standard out log of a container, do: 

```text
$ docker logs -f <id>
```

> Skybert: what if the container has multiple log files and
> their difference carries significance?
