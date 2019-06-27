title: Maven can't see sibling dependency
date: 2019-06-27
category: java
tags: java, maven

I've just spent another 2 hours of my life due to [this Maven
bug](https://issues.apache.org/jira/browse/MCOMPILER-209): Project `X`
with two modules `A` and `B`. `B` depends on `A`. Whenever I build
`B`, I must run `mvn clean` before compiling, or else `B` will not be
able to find `A`'s artifacts (even though they're in
`~/.m2/repostiory`.

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

Posting this here to 1) help others 2) get it out of my system and 3)
give my future self a laugh when pondering the same mystery 2 years
from now.

