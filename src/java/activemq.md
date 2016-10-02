title: ActiveMQ
date: 2014-01-02
category: java
tags: java, jms

These are my notes on using ActiveMQ.

## Why is there no admin application?

When installing ActiveMQ with the =apt-get=, there's no admin
application:

```
# apt-get install activemq
$ curl http://127.0.0.1:61616/admin
```

It's because it's not enabled per default. To enable it:
```
# zcat /usr/share/doc/activemq/examples/conf/jetty.xml.gz > \
       /etc/activemq/instances-available/main/jetty.xml
```
You can now refer to it from your activemq.xml:
```
<beans>
  <!-- to get the admin console -->
  <import resource="jetty.xml"/>
</beans>
```

You may then run into this problem because the DEB package doesn't
have all the ActiveMQ features:

```
2014-01-02 13:28:38,065 | ERROR | Failed to load: class path resource
[activemq.xml], reason: Failed to load type:
org.eclipse.jetty.security.HashLoginService. Reason:
java.lang.ClassNotFoundException:
org.eclipse.jetty.security.HashLoginService; nested exception is
java.lang.ClassNotFoundException:
org.eclipse.jetty.security.HashLoginService |
org.apache.activemq.xbean.XBeanBrokerFactory | main
org.springframework.beans.factory.BeanDefinitionStoreException: Failed
to load type: org.eclipse.jetty.security.HashLoginService. Reason:
java.lang.ClassNotFoundException:
org.eclipse.jetty.security.HashLoginService; nested exception is
java.lang.ClassNotFoundException:
org.eclipse.jetty.security.HashLoginService
```

I therefore used the JARs from the vanilla ActiveMQ distribution. I
didn't want to overwrite, or remove, any of the JARs that came with
the Debian packages, instead, I modified the init script so that the
it used the downloaded tarball instead of the package installed version.

```diff
$ diff -w  activemq.orig activemq
21c21,23
< ACTIVEMQ_JAR=/usr/share/activemq/bin/run.jar
---
> activemq_home=/opt/activemq
> ACTIVEMQ_JAR=${activemq_home}/bin/run.jar
113c115
<       export ACTIVEMQ_HOME=/usr/share/activemq
---
>       export ACTIVEMQ_HOME=${activemq_home}
209c211
<       export ACTIVEMQ_HOME=/usr/share/activemq
---
>       export ACTIVEMQ_HOME=${activemq_home}
```

## Admin console says Could not resolve placeholder 'activemq.username'

```
2014-01-02 13:46:25,366 | WARN | Failed startup of context
o.e.j.w.WebAppContext{/admin,file:/opt/apache-activemq-5.6.0/webapps/admin/}
| org.eclipse.jetty.webapp.WebAppContext | main
org.springframework.beans.factory.BeanDefinitionStoreException:
Invalid bean definition with name 'connectionFactory' defined in
ServletContext resource [/WEB-INF/webconsole-embedded.xml]: Could not
resolve placeholder 'activemq.username'
```

This was because I didn't have the activemq.username and password in
my `activemq.xml`:

```
# cat > /etc/activemq/instances-available/main/credentials.properties <<EOF
activemq.username=foo
activemq.password=bar
EOF
```


## ERROR on start up complaining about size

```
2014-01-02 13:08:57,919 | ERROR | Temporary Store limit is 50000 mb,
whilst the temporary data directory:
/var/lib/activemq/main/data/localhost/tmp_storage only has 5656 mb of
usable space | org.apache.activemq.broker.BrokerService | main
```

## Cannot send, channel has already failed
```
2014-01-02 13:01:02,927 | DEBUG | Reason: org.apache.activemq.transport.InactivityIOException: Cannot send, channel has already failed: tcp://127.0.0.1:34528 |
 org.apache.activemq.broker.TransportConnector | ActiveMQ Task-19
org.apache.activemq.transport.InactivityIOException: Cannot send, channel has already failed: tcp://127.0.0.1:34528
        at org.apache.activemq.transport.AbstractInactivityMonitor.doOnewaySend(AbstractInactivityMonitor.java:255)
        at org.apache.activemq.transport.AbstractInactivityMonitor.oneway(AbstractInactivityMonitor.java:244)
        at org.apache.activemq.transport.WireFormatNegotiator.sendWireFormat(WireFormatNegotiator.java:168)
        at org.apache.activemq.transport.WireFormatNegotiator.sendWireFormat(WireFormatNegotiator.java:84)
        at org.apache.activemq.transport.WireFormatNegotiator.start(WireFormatNegotiator.java:74)
        at org.apache.activemq.transport.TransportFilter.start(TransportFilter.java:58)
        at org.apache.activemq.broker.TransportConnection.start(TransportConnection.java:914)
        at org.apache.activemq.broker.TransportConnector$1$1.run(TransportConnector.java:227)
        at java.lang.Thread.run(Thread.java:724)
```

## What's the difference between a topic and a subject?

Looking at this Java-snippet, they seem to mean the same thing:

```java
String subject="topic.jay";
[..]
Destination destination = new ActiveMQTopic(subject);
```

Need to confirm this, though.
