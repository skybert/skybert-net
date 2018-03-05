title: Tomcat Server Info
date: 2018-03-05
category: java
tags: java, tomcat

Tomcat has a class `org.apache.catalina.util.ServerInfo` which you can
run to find out the version of Tomcat, if you don't trust the
directory in which it is installed, of course 😉

```text
$ cd /path/to/tomcat/install
$ java -cp lib/catalina.jar org.apache.catalina.util.ServerInfo
Server version: Apache Tomcat/9.0.4
Server built:   Jan 18 2018 19:42:17 UTC
Server number:  9.0.4.0
OS Name:        Linux
OS Version:     4.9.0-3-amd64
Architecture:   amd64
JVM Version:    1.8.0_144-b01
JVM Vendor:     Oracle Corporation
```

Apart from `Server version`, I find `Server built` pretty
interesting. It's good to know how ancient the version I'm running is
😄
