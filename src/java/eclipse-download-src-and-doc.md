title: Get Eclipse to download sources and JavaDoc
date: 2014-10-22
category: java
tags: java, eclipse, maven

I've found that for Maven based projects, there's a fast way of doing
this which doesn't require any plugins or fuss:

```
$ mvn eclipse:eclipse -DdownloadSources -DdownloadJavadocs
```

## Why not m2e?
I've never had much luck with m2e, it just doesn't like me. So, I
stick with using ```mvn eclipse:eclipse``` and restarting/refreshing
the Eclipse project whenever something major changes. It works.
