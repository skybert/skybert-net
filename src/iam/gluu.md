title: My gluu notes
date: 2017-10-10
category: iam
tags: iam, gluu

## Running out of disk space

The GLUU dev server doesn't tidy up after itself:

```text
# du -hs /opt/gluu-server-3.1.0/opt/jetty-9.3/temp/
2.4G /opt/gluu-server-3.1.0/opt/jetty-9.3/temp/
```

So some house keeping is in place in case you don't want to run out of disk space:

```text
# /etc/init.d/gluu-server-3.1.0  stop
# rm -rf /opt/gluu-server-3.1.0/opt/jetty-9.3/temp/*
# /etc/init.d/gluu-server-3.1.0 start
```
