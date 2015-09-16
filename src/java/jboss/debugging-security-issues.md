title: Debugging security issues on JBoss
date: 2014-10-19
category: java
tags: java, jboss


When debugging security realm issues on JBoss EAP 6.2, I find it
useful to turn on debugging on the following components:

- org.jboss.security
- org.apache.catalina.realm
- org.apache.catalina.authenticator

Here's the corresponding configuration fragments for
```standalone.xml```:

```
<logger category="org.jboss.security">
    <level name="DEBUG"/>
</logger>
<logger category="org.apache.catalina.realm">
    <level name="DEBUG"/>
</logger>
<logger category="org.apache.catalina.authenticator">
  <level name="DEBUG"/>
</logger>
```

Here's an example output from an HTTP HEAD request of a user who
only has the "write" role, but "read" is required on the particular
resource:
On the client, I did:

```
$ curl -I -u john:<pass> http://localhost:8080/moccasin-webapp-1.0/
```

And my ```server.log``` now contained these useful messages:

```
14:04:32,004 DEBUG [org.apache.catalina.authenticator] (http-localhost.localdomain/127.0.0.1:8080-1) Security checking request HEAD /moccasin-webapp-1.0/
14:04:32,004 DEBUG [org.apache.catalina.realm] (http-localhost.localdomain/127.0.0.1:8080-1)   Checking constraint 'SecurityConstraint[All resources]' against HEAD /index.xhtml --> true
14:04:32,004 DEBUG [org.apache.catalina.realm] (http-localhost.localdomain/127.0.0.1:8080-1)   Checking constraint 'SecurityConstraint[All resources]' against HEAD /index.xhtml --> true
14:04:32,004 DEBUG [org.apache.catalina.authenticator] (http-localhost.localdomain/127.0.0.1:8080-1)  Calling hasUserDataPermission()
14:04:32,004 DEBUG [org.apache.catalina.realm] (http-localhost.localdomain/127.0.0.1:8080-1)   User data constraint has no restrictions
14:04:32,004 DEBUG [org.apache.catalina.authenticator] (http-localhost.localdomain/127.0.0.1:8080-1)  Calling authenticate()
14:04:32,037 DEBUG [org.apache.catalina.authenticator] (http-localhost.localdomain/127.0.0.1:8080-1) Authenticated 'john' with type 'BASIC'
14:04:32,037 DEBUG [org.apache.catalina.authenticator] (http-localhost.localdomain/127.0.0.1:8080-1)  Calling accessControl()
14:04:32,037 DEBUG [org.apache.catalina.realm] (http-localhost.localdomain/127.0.0.1:8080-1)   Checking roles GenericPrincipal[john(write,)]
14:04:32,043 DEBUG [org.apache.catalina.realm] (http-localhost.localdomain/127.0.0.1:8080-1) JBWEB000016: User [john] does not have role [read]
14:04:32,043 DEBUG [org.apache.catalina.realm] (http-localhost.localdomain/127.0.0.1:8080-1) No role found:  read
14:04:32,043 DEBUG [org.apache.catalina.authenticator] (http-localhost.localdomain/127.0.0.1:8080-1)  Failed accessControl() test
```
