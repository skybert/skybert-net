title: My gluu notes
date: 2017-10-10
category: iam
tags: iam, gluu

These are some of my notes after working with the open source identity
and access manager platform, [Gluu](http://gluu.org).

## Running out of disk space

The GLUU dev server doesn't tidy up after itself:

```text
$ du -hs /opt/gluu-server-3.1.0/opt/jetty-9.3/temp/
2.4G /opt/gluu-server-3.1.0/opt/jetty-9.3/temp/
```

So some house keeping is in place in case you don't want to run out of disk space:

```text
# /etc/init.d/gluu-server-3.1.0 stop
# rm -rf /opt/gluu-server-3.1.0/opt/jetty-9.3/temp/*
# /etc/init.d/gluu-server-3.1.0 start
```

## See what's going on

```text 
$ tail -f /opt/gluu-server-3.1.0/opt/gluu/jetty/identity/logs/* \
          /opt/gluu-server-3.1.0/opt/gluu/jetty/oxauth/logs/*

```

## Connecting a remote debugger to Gluu

Being able to connect your local debugger up to Gluu running on any
server is powerful. This is how I do it.

### Enable remote debugging in the 2 gluu processes
Change the configuration of the `init.d` scripts for the `identity`
and `oxauth` processes:

```text
# vim /etc/default/identity
```

Change:
```
JAVA_OPTIONS="-server -Xms256m -Xmx858m -XX:MaxMetaspaceSize=368m
-XX:+DisableExplicitGC -Dgluu.base=/etc/gluu
-Dserver.base=/opt/gluu/jetty/identity
-Dlog.base=/opt/gluu/jetty/identity -Dpython.home=/opt/jython
-Dorg.eclipse.jetty.server.Request.maxFormContentSize=50000000"
```

To:
```
JAVA_OPTIONS="
  -server -Xms256m -Xmx858m 
  -XX:MaxMetaspaceSize=368m 
  -XX:+DisableExplicitGC 
  -Dgluu.base=/etc/gluu 
  -Dserver.base=/opt/gluu/jetty/identity 
  -Dlog.base=/opt/gluu/jetty/identity 
  -Dpython.home=/opt/jython 
  -Dorg.eclipse.jetty.server.Request.maxFormContentSize=50000000 
  -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=6005"
```

Then restart the `identity` process:
```text
# /etc/init.d/identity restart
```

To the same in `/etc/default/oxauth`, but choose a different port for
the debugger to connect to:
```
  -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
```
And then restart `oxauth` too:
```
# /etc/init.d/oxauth restart
```

Now, if you're running the gluu system inside a virtual machine (or
just a different machine than your host machine), forward the ports
`6005` and `5005` to your local machine. Type this command on your
local machine, where you forward these two ports as you `ssh` into the
gluu machine:

```
$ ssh -L5005:localhost:5005 -L6005:localhost:6005 user@gluu
```

As long as you keep this `ssh` connection open, you can access the
debug ports `5005` and `6005` as if they were running locally.

Now, you can open up your favourite IDE like IntelliJ IDEA, Eclipse or
Emacs and point set up the debugger to connect to `5005` for the
`oxauth` app and `6005` for the `identity` app respectively.

### Getting the correct sources
For remote debugging to make any sense, you must of course have the
source code checked out locally and you must check out the Git tag
corresponding to the gluu server you're running.

E.g., I have the following for debugging version 3.1.0 of Gluu:
```
$ git clone https://github.com/GluuFederation/oxAuth.git
$ cd oxAuth
$ git checkout version_3.1.0
```

Confusingly, the `identity` running on your Gluu system, is provided
by the repository called `oxTrust`. In any case, this is what I've
done to have sources to debug against it:
```
$ git clone https://github.com/GluuFederation/oxTrust.git
$ cd oxTrust
$ git checkout version_3.1.0
```

## Connecting an external LDAP browser

If you are as curious as me, you sooner or later want to peek at what
_exactly_ is stored in the backend of Gluu. This means connecting
something like Apache Directory Studio to the `slapd` process running
inside the chroot container.

You can find the configuration you need in
`/opt/gluu-server-3.1.0/etc/gluu/conf/ox-ldap.properties`, e.g.:

```
bindDN: cn=directory manager,o=gluu
bindPassword: foobar
servers: localhost:1636
```
