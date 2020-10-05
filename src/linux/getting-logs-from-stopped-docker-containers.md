title: Getting logs from a stopped Docker container
date: 2020-10-05
category: linux
tags: linux, docker, containers

I often hear the complaint that people can't give us the log messages
"because the container failed and therefore is no more". This is not a
problem, however. You can copy any file from a stopped Docker
container using scp/rsync syntax:

```
docker cp <container>:<path> <local-path>
```

For instance:

```
$ docker cp 1fbe7cbe61ef:/var/log/um-entrypoint.1601639207.log /tmp
```

For the system out log, you can get the system out log of started and
stopped containers alike with `docker logs <container>`.

Happy reporting!
