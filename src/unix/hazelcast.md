title: Hazelcast
date: 2021-11-02
category: unix
tags: unix, caching, linux

Hazelcast is a great in-memory data grid. Much like Redis, but has way
better clustering model.

## Strange conf file location

The installation of Hazelcast is stellar, you set up the APT repository and run 

```text
# apt-get install hazelcast
```

to install it. However, the conf file isn't under `/etc` as you would
expect, but is instead to be found under this path:

```text
/usr/lib/hazelcast/hazelcast-5.0/config/hazelcast.xml
```

## Having it to listen on something else than the loopback device

Change:
```xml
<interfaces enabled="true">
  <interface>127.0.0.1</interface>
</interfaces>
```

to the IP of the interface on which you want Hazelcast to listen:
```xml
<interfaces enabled="true">
  <interface>10.196.166.239</interface>
</interfaces>
```

Restart the Hazelcast instance with:
```text
$ hz restart
```

## Enable REST API

Hazelcast has a nice, [simple REST
API](https://docs.hazelcast.com/hazelcast/5.0/maintain-cluster/rest-api#enabling-rest-api). You
can enable it by adding the `<rest-api>` element:

```xml
<hazelcast ..>
..
  <network>
    <rest-api enabled="true">
      <endpoint-group name="DATA" enabled="true"/>
    </rest-api>
    ..
  </network>
..
</hazelcast>
```


## Good error messages

Here, I've asked it to use `LRUs` eviction strategy instead of `LRU`
🤦:


```
Caused by: org.xml.sax.SAXParseException; lineNumber: 271;
columnNumber: 79; cvc-enumeration-valid: Value 'LRUs' is not
facet-valid with respect to enumeration '[NONE, LRU, LFU, RANDOM]'. It
must be a value from the enumeration.
```
