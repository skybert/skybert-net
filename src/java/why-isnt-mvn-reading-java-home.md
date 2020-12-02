title: Maven doesn't read JAVA_HOME
date: 2020-12-02
category: java
tags: java, maven

```
$ echo $JAVA_HOME
/usr/lib/jvm/oracle-java8-jdk-amd64/bin/java
$ which java
/usr/lib/jvm/oracle-java8-jdk-amd64/bin/java
```

```
$ java -version                                                                                                                          "1.8.0_144"
Java(TM) SE Runtime Environment (build 1.8.0_144-b01)
Java HotSpot(TM) 64-Bit Server VM (build 25.144-b01, mixed mode)
```

But Maven refuses to use it:
```
$ mvn -version
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: /opt/apache-maven-3.6.3
Java version: 11.0.9, vendor: Debian, runtime: /usr/lib/jvm/java-11-openjdk-amd64
Default locale: en_GB, platform encoding: UTF-8
```

## strace to the rescue
```
$ strace -e read mvn -version
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260A\2\0\0\0\0\0"..., 832) = 832
read(10, "#!/bin/sh\n\n# Licensed to the Apa"..., 8192) = 5741
read(11, "JAVA_HOME=/usr/lib/jvm/default-j"..., 8192) = 35
```

## and some bash
And then some `bash` debugging:
```
$ bash -x $(which mvn)
+ '[' -z '' ']'
+ '[' -f /etc/mavenrc ']'
+ '[' -f /home/torstein/.mavenrc ']'
+ . /home/torstein/.mavenrc
++ JAVA_HOME=/usr/lib/jvm/default-java
```

