title: Debugging security issues on JBoss
date: 2014-10-19

When debugging security realm issues on JBoss EAP 6.2, I find it
useful to turn on debugging on the following components:

- org.jboss.security
- org.apache.catalina.realm
- org.apache.catalina.authenticator

Here's the corresponding configuration fragments for
=standalone.xml=:

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

