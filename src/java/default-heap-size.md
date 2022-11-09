title: Default Java Heap Size
date: 2022-11-08
category: java
tags: java

If you don't specify anything with `-Xmx` and `-Xms`, how much memory
will the operating system allocate to your Java process?

The default heap size was 64MB until Java 5. Since then, it's been
calculated runtime. To see what the JVM will pick for your system, you
can do:

```bash
$ java -XX:+PrintFlagsFinal -version 2>/dev/null |
  grep InitialHeapSize |
  awk '{print $4}' |
  numfmt --to iec
498M
```

To read more about how this value is calculated, see [Garbage
Collector
Ergonomics](https://docs.oracle.com/javase/6/docs/technotes/guides/vm/gc-ergonomics.html)
