title: Hard links 
date: 2019-11-01
category: unix
tags: unix, java

Most of the time, we use symbolic links. Today, however, I wanted to
use hard links so that I could trick Docker to use my JAR libraries
whenever I updated them in my Java project.

But I'm getting ahead of myself. First off, hard links works like
this: We have two files with fortune cookies:

```text
$ echo 'Hello world' > fortune.txt
$ echo 'Bye world' > fortune2.txt
```

We can now create a file `latest.txt` which is a hard link to
`fortune2.txt`. Whatever I do with `latest.txt`, I essentially do on
`fortune.txt`:

```
$ ln -v fortune2.txt latest.txt
'latest.txt' => 'fortune2.txt'
```

The two files both contain the same content:

```text
$ cat fortune2.txt
Bye world
$ cat latest.txt
Bye world
```

Indeed, since we asked `ln` to create a hard link, they also refer to
the same file on disk (as you may know, the file name and path that we
humans refer to point to some wild place on the hard drive, identified
by an `indode`, hence the `2` links):

```
$ stat fortune2.txt latest.txt | grep inode
Device: 10301h/66305d   Inode: 9970925     Links: 2
Device: 10301h/66305d   Inode: 9970925     Links: 2
```

Now, let's use this knowledge to update a JAR archive:

First, we'll create a JAR file with one file inside of it
`fortune.txt` and then create a hard link to it:

```text
$ jar cf foo.jar fortune.txt
$ ln -v foo.jar bar.jar
```

Now, I can treat `bar.jar` just as if I was using `foo.jar`. They
contain the same file(s):

```
$ jar tf foo.jar | grep fort
fortune.txt
$ jar tf bar.jar | grep fort
fortune.txt
```

So far, so good. Now, let's update `foo.jar` to include another file:
```text
$ jar uf foo.jar fortune2.txt
$ jar tf foo.jar | grep fortun
fortune.txt
fortune2.txt
$ jar tf bar.jar | grep fortun
fortune.txt
```

Woooot?! Why does `bar.jar` have the old contents? Shouldn't it have
the same contents of `foo.jar`? That's the whole point of hard links!

The reason of course, is that these are indeed two different files:
```text
$ stat foo.jar latest.jar | grep inode
Device: 10301h/66305d   Inode: 9970971     Links: 1
Device: 10301h/66305d   Inode: 9970970     Links: 1
```

This proves that when we ask `jar` to `u`pdate an archive, it actually
creates a new archive with the additional content, then _replaces_ the
original jar with the new one. Since the new JAR has the same name as
the old, the user is given the impression that the command indeed
`updated` the archive.

Logical when you know it, but very confusing when you don't. This, I
believe, is one of the reasons why most folks prefer symbolic links as
they give you what you mean instead of what you say.

Happy linking!
