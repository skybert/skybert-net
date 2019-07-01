title: Maven can't see sibling dependencies
date: 2019-06-27
category: java
tags: java, maven

I've just spent another 2 hours of my life due to [this Maven
bug](https://issues.apache.org/jira/browse/MCOMPILER-209): Project `x`
with two modules `a` and `b`. `b` depends on `a`:

```text
x
├── a
│   ├── pom.xml
│   └── src
│       └── main
│           └── java
│               └── net
│                   └── skybert
│                       └── A.java
├── b
│   ├── pom.xml
│   └── src
│       └── main
│           └── java
│               └── net
│                   └── skybert
│                       └── B.java
└── pom.xml
```

`B.java` makes use of `A.java`:

```java
package net.skybert;
import net.skybert.A;
public class B {
}

```

Now, whenever I want to build `b`, I must run `mvn clean` in `b` before
compiling it, or else `b` will not be able to find `a`'s artifact
(even though the `a` artifact is in `~/.m2/repostiory`). Pretty
amazing, right?

The work around is to turn off incremental compilation:
```
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-compiler-plugin</artifactId>
  <version>3.7.0</version>
  <configuration>
    <useIncrementalCompilation>false</useIncrementalCompilation>
  </configuration>
</plugin>
```

With this addition to the project's root POM, I can run `mvn compile`
in `b` and don't get compile errors because `net.skybert.B` can't find
`net.skybert.A`.

Posting this here to 1) help others 2) get it out of my system and 3)
give my future self a laugh when pondering the same mystery 2 years
from now.

