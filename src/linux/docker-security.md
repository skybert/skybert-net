title: Docker Security
date: 2021-01-18
category: linux
tags: linux, docker, containers

I was shocked to learn that `dockerd` will create holes in your
firewall to route traffic from the outside to your containers.

```text
# netstat -nlp --tcp
..
Chain DOCKER (2 references)target     prot opt source               destinationACCEPT     tcp  --  anywhere             172.19.0.2           tcp dpt:8010
```

