title: My gluu notes
date: 2017-10-10
category: iam
tags: iam, gluu

These are some of my notes after working with the open source identity
and access manager platform, [Gluu](http://gluu.org).

## Service discovery
Gluu supports service OIDC discovery and it sets up redirects from the
`/oxauth` resource so that you can only type the short-ish URI below
to get the JSON document describing the various OIDC services and options
available.

```
$ curl --location https://gluu.example.com/oxauth
```

The `--location` option to `curl` makes it follow redirects. The URI
that it ends up returning the contents of is
`https://gluu.example.com/oxauth/.well-known/openid-configuration`

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
# /etc/init.d/gluu-server-3.1.0 login
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
  -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=6005
"
```

The important bit is the last line starting with `-Xrunjdwp` (I pretty
printed the other values too to make it easier to read, the `bash`
code still works).

Then restart the `identity` process:
```text
# /etc/init.d/identity restart
```

Do the same in `/etc/default/oxauth`, but choose a different port for
the debugger to connect to:
```
  -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005
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
Emacs and point the debugger to port `5005` for the `oxauth` app and
`6005` for the `identity` app respectively.

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

Forward the `1636` the same way as you did with the debug ports
above. You cna then enjoy the full gory details of everything from how
the OpenID Connect clients are stored to how the user objects are
mapped in the LDAP tree.

<img
  class="centered"
  src="/graphics/2017/ldap-gui.png"
  alt="LDAP client browsing the gluu configuation"
  style="width: 900px"
/>

## Investigating problems regarding AD synchronisation

Log on the machine that runs the `oxTrust`/`identity` process and then
tail the `oxtrust_cache_refresh.log`:

```text
$ tail -f /opt/gluu/jetty/identity/logs/oxtrust_cache_refresh.log
```

Note, if you're running the `docker-oxtrust` container, this log file
isn't exposed when you do `docker logs -f oxtrust`, you thus need to
"log in" to the container and tail the log there.

## oxtrust - Can not download ssl certificate
```text
oxtrust_1          | 2018-08-10 11:07:39,718 ERROR [ForkJoinPool.commonPool-worker-2] [org.gluu.oxtrust.ldap.service.StatusCheckerTimer] (StatusCheckerTimer.java:217) - Can not download ssl certificate
oxtrust_1          | java.net.ConnectException: Operation timed out (Connection timed out)
oxtrust_1          | 	at java.net.PlainSocketImpl.socketConnect(Native Method) ~[?:1.8.0_151]
oxtrust_1          | 	at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:350) ~[?:1.8.0_151]
oxtrust_1          | 	at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206) ~[?:1.8.0_151]
oxtrust_1          | 	at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188) ~[?:1.8.0_151]
oxtrust_1          | 	at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392) ~[?:1.8.0_151]
oxtrust_1          | 	at java.net.Socket.connect(Socket.java:589) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.security.ssl.SSLSocketImpl.connect(SSLSocketImpl.java:673) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.security.ssl.BaseSSLSocketImpl.connect(BaseSSLSocketImpl.java:173) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.net.NetworkClient.doConnect(NetworkClient.java:180) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.net.www.http.HttpClient.openServer(HttpClient.java:463) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.net.www.http.HttpClient.openServer(HttpClient.java:558) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.net.www.protocol.https.HttpsClient.<init>(HttpsClient.java:264) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.net.www.protocol.https.HttpsClient.New(HttpsClient.java:367) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.net.www.protocol.https.AbstractDelegateHttpsURLConnection.getNewHttpClient(AbstractDelegateHttpsURLConnection.java:191) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.net.www.protocol.http.HttpURLConnection.plainConnect0(HttpURLConnection.java:1156) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.net.www.protocol.http.HttpURLConnection.plainConnect(HttpURLConnection.java:1050) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.net.www.protocol.https.AbstractDelegateHttpsURLConnection.connect(AbstractDelegateHttpsURLConnection.java:177) ~[?:1.8.0_151]
oxtrust_1          | 	at sun.net.www.protocol.https.HttpsURLConnectionImpl.connect(HttpsURLConnectionImpl.java:162) ~[?:1.8.0_151]
oxtrust_1          | 	at org.gluu.oxtrust.ldap.service.StatusCheckerTimer.setCertificateExpiryAttributes(StatusCheckerTimer.java:205) [classes/:?]
oxtrust_1          | 	at org.gluu.oxtrust.ldap.service.StatusCheckerTimer.processInt(StatusCheckerTimer.java:164) [classes/:?]
oxtrust_1          | 	at org.gluu.oxtrust.ldap.service.StatusCheckerTimer.process(StatusCheckerTimer.java:125) [classes/:?]
oxtrust_1          | 	at org.gluu.oxtrust.ldap.service.StatusCheckerTimer$Proxy$_$$_WeldSubclass.process$$super(Unknown Source) [classes/:?]
```


Check that oxtrust can query the service document from oxauth:
```text
$ docker ps -qf name=oxtrust
$ docker exec -ti d332cf04b5f7 sh
# wget -O -  http://oxauth:8080/oxauth/.well-known/openid-configuration
# wget -O -  https://gluu.quanah/.well-known/openid-configuration
```

The first `wget` checks getting the document directly from `oxauth`
whereas the second does what `oxtrust` does in a production
environment: gets it via the web server (the `nginx` container in our
case, this is the Apache process in the old `chroot` container setup).

## Failed to decript 'bindPassword' property
```text 
2018-09-05 06:47:38,052 ERROR [Thread-44] [org.xdi.util.security.PropertiesDecrypter] (PropertiesDecrypter.java:70) - Failed to decript 'bindPassword' property
org.xdi.util.security.StringEncrypter$EncryptionException:
javax.crypto.IllegalBlockSizeException: Input length must be multiple
of 8 when decrypting with padded cipher

```

Lovely spelling mistake in the error message, isn't it? In any case,
for all passwords, Gluu has a generated string, a salt, which it uses
to encrypt and decrypt all its passwords. In a password  isn't
readable with that Gluu installatin's salt, then this exception is
thrown.

Possible causes for this is:
- You've manually edited the password into the LDAP tree
- The salt used for encrypting the password isn't the same as the salt
  the current Gluu installation is using. This may occur if you're
  migrating data from an old to a new installation or if you're
  running in a containerised environment where only some parts of the
  cluster have been re-initialised.

### Verify that both LDAP and Consul use the same inum
Check that the `inum` in Consul is the same as the `inum` in LDAP:

```text
$ curl -s http://localhost:8500/v1/kv/gluu/config/baseInum | 
  jq --raw-output '.[].Value'|
  base64 -d -
@!1E7E.40BB.DB2A.C565
```

Check that the same base `inum` is in LDAP:
<img
  class="centered"
  src="/graphics/2019/gluu-ldap-inum.png"
  alt="Gluu ldap"
/>


Instead of using a graphical LDAP client, you can also use the command
line:

```text
$ ldapsearch -H ldaps://172.18.0.5:1636 -x -D "cn=directory manager" -w <pass> -b "o=gluu" -s one -a always -z 1000 "(objectClass=*)" "o=*"
[..]
dn: o=@!4371.2E14.5256.EEF4!0001!FA8E.DFD4,o=gluu
```
