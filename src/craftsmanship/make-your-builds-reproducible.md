title: How to NOT make your builds reproducible
date: 2020-06-09
category: craftsmanship
tags: craftsmanship, java

How to not make reproducible builds: Add this to your Java project's
`pom.xml`:

```xml
<profile>
  <id>jdk11+</id>
  <activation>
    <jdk>[11,)</jdk>
  </activation>
  <dependencies>
    <dependency>
      <groupId>com.sun.activation</groupId>
      <artifactId>jakarta.activation</artifactId>
    </dependency>
  </dependencies>
</profile>
```

This gem from `jersey-common` makes sure the dependency graph is
different depending on which version of `javac` is first in classpath
:face_palm: Creating the land of confusion that we all know and love:

- why doesn't this build on my computer, it built yesterday!
- why does this build on Jenkins node `build1` but not on `build6`?

And so on. Good grief. 
