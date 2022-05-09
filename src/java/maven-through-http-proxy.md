title: Maven Through an HTTP Proxy
date: 2022-04-28
category: java
tags: java, maven, http


If you're using Maven through an HTTP proxy, you might have banged
your head why on earth the snippet below in `~/.m2/settings.xml` isn't
enough to get all Maven plugins to work perfectly with the proxy (no,
it's not because of `protocol=http`):

```xml
<proxies>
  <proxy>
    <id>anping-proxy</id>
    <active>true</active>
    <protocol>http</protocol>
    <host>proxy</host>
    <port>8899</port>
  </proxy>
</proxies>
```

For most Maven plugins, this works great. However, for a few, it
doesn't and `mvn` just hangs forever.

It turns out, for *some* underlying Maven components (possibly related
to [this bug in
Maven](https://issues.apache.org/jira/browse/MNG-5237)), it's not
enough and you'll have to set the *same* values in the `MAVEN_OPTS`
environment variable:

```bash
export MAVEN_OPTS="
  ${MAVEN_OPTS}
  -Dhttp.proxyHost=proxy
  -Dhttp.proxyPort=8899
  -Dhttps.proxyHost=proxy
  -Dhttps.proxyPort=8899
"
```

That took me a while to figure out, have been doing all sorts of
somersaults over and under this 🤸‍♂️

