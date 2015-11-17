title: Improve Tomcat Startup Time
category: java
tags: java, tomcat, performance
date: 2015-11-13

Out of the box, my [Tomcat](http://tomcat.apache.org) version 7.0.62
with 8 webapps inside two different `<Host/>` containers booted in around
52 seconds. This article describes how I cut this to under 10 seconds.

<!--
2015-11-16 10:19:45,124 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 50405 ms
2015-11-16 10:20:49,170 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 53229 ms
2015-11-16 10:21:47,857 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 50797 ms
2015-11-16 10:22:51,162 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 52903 ms
2015-11-16 10:23:48,791 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 49401 ms
-->

## Remove websocket support

First off, I didn't need support for websockets, so I removed those
from my Tomcat alltogheter, any JAR or webapp Tomcat doesn't need to
pay attention to can only improve startup performance:

```
$ rm tomcat/lib/websocket-api.jar
$ rm tomcat/lib/tomcat-websocket.jar
```

<!--
2015-11-16 10:32:58,503 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 40902 ms
2015-11-16 10:33:56,121 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 37408 ms
2015-11-16 10:34:56,702 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 36803 ms
2015-11-16 10:35:58,811 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 37752 ms
2015-11-16 10:36:59,415 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 37209 ms
-->

Tomcat now started in around 37 seconds.

## Remove Servlet 3 scanning
The second thing I did to improve this startup time, was to remove the
Servlet 3 scanning. This was easily done by editing
`tomcat/conf/catalina.properties`:

```
org.apache.catalina.startup.ContextConfig.jarsToSkip=*.jar
```

<!--
2015-11-16 10:49:56,996 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 10759 ms
2015-11-16 10:50:59,043 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 11574 ms
2015-11-16 10:52:00,269 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 11643 ms
2015-11-16 10:53:01,004 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 11149 ms
2015-11-16 10:54:02,170 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 11189 ms
-->

Tomcat now started in around 12 seconds.

## Remove TLD scanning

Since my application uses TLDs in a number of context, I couldn't turn
off TLD scanning completely. However, I turned it off for all but a
few JARs where I know there exists TLDs (a little shell voodoo gave me
the answer).

To make this as easy as possible, I've create a
[wee shell script to create this exclusion string](https://github.com/skybert/my-little-friends/blob/master/bash/java/create-catalina-tld-jar-skip-list.sh),
let's you create this exclusion list by simply invoking it like this:

```
$ create-catalina-tld-jar-skip-list.sh /opt/tomcat-engine1
```

The result of this command, I added as the value to this configuration
option inside `tomcat/conf/catalina.properties`:

```bash
## Everything else except JARs containing TLDs (like jstl.jar):
org.apache.catalina.startup.TldConfig.jarsToSkip=file.jar,file2.jar...
```

<!--
2015-11-16 10:55:08,021 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 11259 ms
2015-11-16 10:56:08,652 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 10719 ms
2015-11-16 10:57:09,396 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 10320 ms
2015-11-16 10:58:10,822 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 10570 ms
2015-11-16 10:59:12,294 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 10851 ms
-->

All that jazz got me another second, Tomcat now started in just under
than 11 seconds.

## Load Engine and Host containers in parallel

I then skimmed off another couple of seconds by making the `<Host/>`
and `<Engine/>` containers load their children in parallel by setting
`startStopThreads=0`:

```xml
<Engine
  ..
  startStopThreads="0"
>
  <Host
    ..
    startStopThreads="0"
  >
```

The number of threads that will be started by the `<Engine/>` and
`<Host/>` containers will then be the same as the amount of CPUs on
your computer, as in:

```java
Runtime.getRuntime().availableProcessors();
```

With this change I gained another 2 seconds.

<!--
2015-11-16 11:01:11,286 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 8894 ms
2015-11-16 11:02:12,709 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 9109 ms
2015-11-16 11:03:13,617 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 8877 ms
2015-11-16 11:04:14,932 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 8970 ms
2015-11-16 11:05:17,455 [main] INFO  org.apache.catalina.startup.Catalina- Server startup in 10208 ms
-->

## All in all, a big win!

With all these tweaks in place, I reduced the Tomcat startup time
significantly from over 50 seconds to under 10 seconds. I now have
startup times at just under 9 seconds on average, a great improvement
indeed 😃

## YMMV

It should be noted that your mileage will vary depending on your
webapps.

For instance, where I could remove servlet 3 scanning completely
because I've configured my webapps in such a way I don't need the
automagic scanning by the app server, you would perhaps need to
include some JARs in which you want such scanning to occur. The
important point in such a case, is to only include the JARs where you
actually have such servlets.

## A note on how I measured the startup times

Since startup times can naturally fluctuate depending on the load on
the system, the CPU and memory available to the JVM booting Tomcat and
so on, I timed each configuration setting five times, like so:

```
for el in {0..4}; do my-tomcat-wrapper restart; sleep 60; done
```

I then used the average of these 5 restarts, which gave a good enough
estimate of the impact of my configuration change.

However, these tests have an important flaw: they don't consider files
that the operationg system holds in its own caches and buffers. I
didn't flush the operating system buffers and cache between each
attempt, but if you want to do this all the way for your own
benchmarking, you can perform the following between each change to the
Tomcat configuration mentioned above:

```bash
$ free
# sync && echo 3 > /proc/sys/vm/drop_caches
# sync && echo 2 > /proc/sys/vm/drop_caches
# sync && echo 1 > /proc/sys/vm/drop_caches
$ free
```

You will then probably see less deviation between the the 5 start up
times for each Tomcat configuration state.

Happy performance testing!

## Further reading

I recommend this
[article on the Tomcat Wiki](http://wiki.apache.org/tomcat/HowTo/FasterStartUp)
as well as the [Tomcat system properties reference](
http://tomcat.apache.org/tomcat-7.0-doc/config/systemprops.html)

