title: System Agnostic Way of Installing Hazelcast
date: 2024-08-16
category: unix
tags: unix, java, caching

Use Maven to download the Hazelcast binary:

```text
$ mvn dependency:get -Dartifact='com.hazelcast:hazelcast:5.5.0'
```

Start it with `java` without any systemd or `/usr/bin` wrapper:
```text
$ java -jar ~/.m2/repository/com/hazelcast/hazelcast/5.5.0/hazelcast-5.5.0.jar
```

If you want to enable the REST API, you can set these environment
variables in front of the `java` command:
```text
$ HZ_NETWORK_RESTAPI_ENABLED=true \
  HZ_NETWORK_RESTAPI_ENDPOINTGROUPS_DATA_ENABLED=true \
  java -jar ~/.m2/repository/com/hazelcast/hazelcast/5.5.0/hazelcast-5.5.0.jar
```

That's it. Hazelcast is now running on your machine. You can test it
out by creating an entry:

```text
$ curl \
  --include \
  --header "Content-Type: text/plain" \
  --data "bar" \
  http://localhost:5701/hazelcast/rest/maps/mapName/foo
```

And then retrieve it again:
```text
$ curl --include http://localhost:5701/hazelcast/rest/maps/mapName/foo
HTTP/1.1 200 OK
Content-Type: text/plain
Content-Length: 3

one
```
