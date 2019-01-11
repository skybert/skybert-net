title: Remote Debugging Java applications
date: 2019-01-11
category: java
tags: java, debugging

Starting with Java 5, you can start the JVM process with:

```text
-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005
```


this is faster than the old way (using the JIT) and as an added plus,
it works on Oracle JDK and OpenJDK alike.


