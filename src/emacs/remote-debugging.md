date:    2012-12-08
category: java
title: Remote Debugging Java applications in Emacs

<div style="float: right">
<img src="../../graphics/emacs.png" alt="png"/>
</div>

Emacs can quite comfortably do debugging of Java applications
running on remote JVMs using the excellent <a
href="http://http://code.google.com/p/jdibug/">JDIbug</a>.


<a href="http://jdee.sf.net">JDEE</a> provides two other means
to debug applications, but I would recommend JDIbug any day of
the week. It's fast and provides a visual tree of
variables. Currently (2009-07-18 13:06), it has one drawback;
it cannot debug inner classes, but I'm sure this is something
that will be remedied in a later release.

<img src="../../graphics/jdibug_remote_debugging.png"
alt="remote debugging with JDIbug"/>

Given that you have the given source code in the
```jde-sourcepath``` variable, you can browse the call
stack leading up to the break point. Here, I am browsing the
state of one of Tomcat's classes when executing my
```test.jsp```

<img src="/graphics/emacs/jdibug_remote_debugging_browsing_the_call_stack.png"
alt="remote debugging with JDIbug"/>

If you are so inclined, you may browse <a
href="https://github.com/skybert/my-little-friends/blob/master/emacs/.emacs.d/tkj-jdibug.el">my
current JDIbug setup here</a>, it might change from time to
time.


