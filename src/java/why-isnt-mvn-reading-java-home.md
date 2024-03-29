title: Maven doesn't read JAVA_HOME
date: 2020-12-02
category: java
tags: java, maven

I was going mad. No matter what I did, `mvn` would not read my Java
settings.

Of course, I had done what all articles on the interweb said, setting
`JAVA_HOME` to my preferred Java version, and yes, of course that was
a JDK and not a JRE:

```bash
export JAVA_HOME=/usr/lib/jvm/oracle-java8-jdk-amd64/bin/java
export PATH=$JAVA_HOME/bin:$PATH
```

The shell was happy with that change:
```bash
$ echo $JAVA_HOME
/usr/lib/jvm/oracle-java8-jdk-amd64/bin/java
$ which java
/usr/lib/jvm/oracle-java8-jdk-amd64/bin/java
```

And calling `java` (and `javac`) were all in agreement:
```bash
$ java -version
java_version "1.8.0_144"
Java(TM) SE Runtime Environment (build 1.8.0_144-b01)
Java HotSpot(TM) 64-Bit Server VM (build 25.144-b01, mixed mode)
```

However, Maven was acting up like a grumpy teenager, refusing to use
it:
```bash
$ mvn -version
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: /opt/apache-maven-3.6.3
Java version: 11.0.9, vendor: Debian, runtime: /usr/lib/jvm/java-11-openjdk-amd64
Default locale: en_GB, platform encoding: UTF-8
```

As you can see, it somehow picked up one of the other JDKs on my
system, located in `/usr/lib/jvm/java-11-openjdk-amd64`.

## strace to the rescue

After some time of fruitless reading of the Maven manual, blog posts
and Stack Overflow posts, I turned to my old trusted friend, `strace`:

```bash
$ strace -e read mvn -version
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260A\2\0\0\0\0\0"..., 832) = 832
read(10, "#!/bin/sh\n\n# Licensed to the Apa"..., 8192) = 5741
read(11, "JAVA_HOME=/usr/lib/jvm/default-j"..., 8192) = 35
```

Aha! When calling the `mvn` command, it `read` something that said
`JAVA_HOME` should be `/usr/lib/jvm/default-java`. And this
`/usr/lib/jvm/default-java` was the before mentioned JDK 11:

```bash
$ ls -l /usr/lib/jvm/default-java
lrwxrwxrwx 1 root root 25 Dec 30  2018 /usr/lib/jvm/default-java -> java-1.11.0-openjdk-amd64/
```


## and some bash
Next up was to debug the `mvn` command itself. Since this was a `bash`
command, debugging it was as easy as calling it with `bash -x`:

```bash
$ bash -x $(which mvn) -version
+ '[' -z '' ']'
+ '[' -f /etc/mavenrc ']'
+ '[' -f /home/torstein/.mavenrc ']'
+ . /home/torstein/.mavenrc
++ JAVA_HOME=/usr/lib/jvm/default-java
```

There, it was plain for the world (well, me) to see that it read
`~/.mavenrc` which had `JAVA_HOME` set. So, I (or some install script)
had set this once upon a time and I'd completely forgotten about it.

Now, finally, I'm in total control of my Maven runtime environment 😉

## Even faster
After thinking about this some more, I realise I could've arrived at
the solution with one step less, using the `-f` (follow) flag to
`strace` including all files in my `$HOME` directory, and excluding
files in the source code repository I was builing:
```
$ strace -y -f -e read mvn -f ~/src/foo/pom.xml 2>&1 | 
    grep $HOME |
    grep -v ~/.m2/repository |
    grep -v $HOME/src/foo
read(11</home/torstein/.mavenrc>, "JAVA_HOME=/usr/lib/jvm/default-java"..., 8192) = 85
read(11</home/torstein/.mavenrc>, "", 8192) = 0
[pid 24643] read(3<pipe:[247857]>, "/home/torstein\n", 128) = 15
[pid 24658] read(3<pipe:[246954]>, "/home/torstein\n", 128) = 15
[pid 24656] read(3<pipe:[246583]>, "/home/torstein/src\n", 128) = 19
[pid 24656] read(3<pipe:[246584]>, "/home/torstein\n", 128) = 15
```
