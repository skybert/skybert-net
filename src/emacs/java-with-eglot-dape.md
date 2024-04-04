title: java with eglot dape
date: 2024-02-27
category: emacs
tags: emacs


## Debugging

Download the latest version of the jdtls java plugin. You can find the
latest version number on
[github.com/microsoft/java-debug](https://github.com/microsoft/java-debug/releases/). Then,
use `mvn` to download the file:

```text
$ mvn \
  org.apache.maven.plugins:maven-dependency-plugin:2.1:get \
  -Dartifact=com.microsoft.java:com.microsoft.java.debug.plugin:0.51.1
```

We then know the path of the JAR file:
```text
~/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/0.51.1/com.microsoft.java.debug.plugin-0.51.1.jar
```


```lisp
(add-to-list
  'eglot-server-programs
  `((java-mode java-ts-mode) .
    ("jdtls"
    :initializationOptions
    (:bundles ["/home/torstein/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/0.51.1/com.microsoft.java.debug.plugin-0.51.1.jar"]))))
```

