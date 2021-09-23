title: Counting Threads Created in the JVM
date: 2021-09-23
category: java
tags: java

Here, I wanted to find out how many threads related
`java.net.HttpClient` were created in the JVM:

```text
$ jstack $(pidof java) | grep '"HttpClient'
"HttpClient-1-SelectorManager" #19 daemon prio=5 os_prio=0 cpu=35.95ms elapsed=772.93s tid=0x00007fb72c0b7000 nid=0x2b46 runnable  [0x00007fb770a02000]
"HttpClient-2-SelectorManager" #20 daemon prio=5 os_prio=0 cpu=361.35ms elapsed=772.92s tid=0x00007fb72c0d5800 nid=0x2b47 runnable  [0x00007fb770701000]
"HttpClient-2-Worker-2" #23 daemon prio=5 os_prio=0 cpu=736.50ms elapsed=772.78s tid=0x00007fb714012800 nid=0x2b4a waiting on condition  [0x00007fb7703fe000]
```

Here, you can see that `2` of the threads belong to the same
`HttpClient` instance. You can tell because they have the same root in
the thread name, `HttpClient-2-..` and they have the same memory
address, `0x00007fb7703fe000`.
