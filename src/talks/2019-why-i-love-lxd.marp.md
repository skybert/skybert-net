
# Why I ❤ Lex-Dee

---

# What is a container? 📦

Let's illustrate this with a demo.

---

# You don't like Docker? 🐳

---

## Dockerfile is no nice and "declarative"

- Can ditch all those scripts
- Goodbye Ansible, Puppet, Chef and BASH
- We can now only write a `Dockerfile`

---

## Dockerfile is no nice and "declarative"

```sql

FROM debian:buster-slim

RUN apt-get update && apt-get install --yes openjdk11-headless

COPY myapp.jar /opt
CMD java -jar /opt/myapp.jar
```

---

## The Docker happy path 

- One process containers
- Stateless
- One log

---

## The Docker happy path

...like the
[redis](https://github.com/docker-library/redis/blob/d42494ab2d96070c8d83f37a7542fbbffd999988/5.0/Dockerfile)
memory cache, right?

---


## Idea of Docker is to have one process per container

---

## Idea of Docker is to have one process per container

- But we sin against this all the time
- We repeatedly add an init system to our Docker containers using e.g. `tini`
- Or we create our own `/sbin/endpoint.sh` which runs several
  processes.
- No systemd or other init system `pid 1`

---

## Where's my log? 
If the process failed, where's the log file that can tell us what went
wrong?

---

## What if your process has more than one log

Gluu's two most important containers (`oxtrust` and `oxauth`) have
several important log files. Only one is exposed through `docker logs
<sha>`

---

## What to do if one container is dependent on another? 
```

wait_for:
  - other
```

Doesn't cut it.

---

## What I still like about Docker

- Reproducible builds 
- Simple one-machine cluster orchestration `docker-compose.yaml`

---

## Docker increases the complexity

Use case: Gluu IAM
- LDAP
- object store
- Three java apps
- nginx


---

## Docker increases the complexity

Before:
```text

# apt install gluu-server-1.2.3
```

---

## Docker increases the complexity

Now, there is 3 `docker-compose.yaml` files, the [main one is this one](https://cci-jira.ccieurope.com/stash/projects/ESCRD/repos/user-manager/browse/user-manager-docker/src/main/docker/docker-compose.yaml). 

---

# LXD
---

## Images

```text

$ lxc image list images: | less
$ lxc launch images:alpine/3.10 alpine
```

Let's try that out ...

---

## Snapshots, backup and restore
```text

$ lxc snapshot <container> <snapshot-name>
$ lxc restore  <container> <snapshot-name>
```

---

## Much better CLI

e.g. to get a shell in the container (aka "log into the container),
you use the name of the container, not the id:

With Docker, you must first look up the id, then run exec:
```text

$ docker exec -ti docker $(ps -qf name=orange) /bin/bash
```

---

## Much better CLI

With LXD, you can just do:
```text

$ lxc exec orange bash
```

---

## REST
```text

$ curl \
  --unix-socket /var/snap/lxd/common/lxd/unix.socket \
  lxd/1.0/containers/orange
```

---

## You want to turn on remote debugging, no problem!

---

## You want to replace a JAR in ECE, no problem!

```text

$ lxc file push /path/to/local/file.jar my-container/path/to/file/in/container/file.jar
$ lxc exec my-container service foo restart
```
---

## Try lxd out in your browser

https://linuxcontainers.org/lxd/getting-started-cli/

---

## Get it

### 🐧
```text
# snap install lxd
```

### 🗔
```text
c:\> choco install lxc
```

### 🍎
```text
$ brew install lxc
```

