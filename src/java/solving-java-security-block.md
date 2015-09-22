title: Solving Java Security block from the command line
date: 2015-09-22
category: java
tags: java, security

Tried to start a Java webstart application:
```
$ javaws http://localhost:82/studio/Studio.jnlp
```

<img src="/graphics/2015/blocked-by-java-security.png"
     alt="blocked by java sec"/>

Solved it by simply adding this to the security exception list:

```
$ echo http://localhost:82 >> ~/.java/deployment/security/exception.sites
```

This is much faster than clicking through the Java Control Centre
dialogues.


