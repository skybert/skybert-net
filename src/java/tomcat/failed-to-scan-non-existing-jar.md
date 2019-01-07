title: Tomcat fails to scan JAR file that I never asked for
date: 2019-01-07
category: tomcat
tags: tomcat, java

With a recent Tomcat, 9.0.13, I was really puzzled with loads of
warnings about Tomcat being unable to scan a JAR file which I never
had reference nor did exist on the file system:

```text
org.apache.tomcat.util.
scan.StandardJarScanner.scan Failed to scan
[file:/opt/tomcat-engine1/escenic/lib/serializer.jar] from classloader
hierarchy
```

It turned out, with Tomcat 8.0.41 or thereabouts, it has started to
scan all manifests for other JARs and add these to the classpath. If
any of these cannot be found, a big fat warning and stack trace is
added to the Tomcat standard out log.

The remedy is to turn off scanning the `MANIFEST.MF` inside all JAR
files:

```text
$ vim conf/context.xml
```

```xml
<JarScanner scanManifest="false"/>
```

Now, I get about 400 lines less of spam in my logs and can concentrate
on the messages I actually care about 😃.

For further details on the JAR scanner component, see the [Tomcat
documentation](https://tomcat.apache.org/tomcat-9.0-doc/config/jar-scanner.html).
