title: Unblocking Java webstart Apps from the Command Line
date: 2015-09-22
category: java
tags: java, security

If you try to start a Java webstart application like this:
```
$ javaws http://localhost:82/studio/Studio.jnlp
```

And get blocked by the Java security mechanism:

<img src="/graphics/2015/blocked-by-java-security.png"
     alt="blocked by java sec"
     class="centered"
     />

You'd normally have to go through the tedious process of locating the
Java Control Panel, click on the security tab, click on the exception
list icon, click "add a new URL", enter the URL, click ok, click
"confirm I know what I'm doing" and finally close the bulky control
application.

If you, like me, work with lots of java webstart apps from many
sources that Java doesn't approve of, this becomes an irritation.

The command line to the rescue: You can solve it by simply adding the
URL to the security exception list text file like this:

```
$ echo http://localhost:82 >> ~/.java/deployment/security/exception.sites
```

This is **so** faster than clicking through the Java Control Centre
dialogues 😃


