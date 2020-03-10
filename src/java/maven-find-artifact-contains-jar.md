title: Find what Maven artifact contains class
date: 2020-03-10
category: java
tags: java, maven

Say you have a java project that doesn't compile because of a missing dependency:
```text
$ mvn compile
[..]
[ERROR] /home/torstein/src/foo-app/src/main/java/com/example/Event.java:[165,47] cannot access javax.ws.rs.sse.InboundSseEvent
  class file for javax.ws.rs.sse.InboundSseEvent not found
```

Now, how do you figure out what dependency to add to your `pom.xml`?

Easy, head over to:
```
https://search.maven.org/search?q=fc:<class>
```

So for us here, that means hitting
[https://search.maven.org/search?q=fc:javax.ws.rs.sse.InboundSseEvent](https://search.maven.org/search?q=fc:javax.ws.rs.sse.InboundSseEvent)

## Searching your local Maven repository

You can also search your local Maven repository for artifact that
matches:

```text
$ grep -r --fixed-strings javax.ws.rs.sse.InboundSseEvent ~/.m2/repository/
```
