date:    2012-10-07
category: tomcat
title: Issues with DBCP on Gentoo
tags: gentoo

<div style="float: right">
<img src="https://bugs.gentoo.org/extensions/Gentoo/web/gentoo_org.png"
alt="Gentoo"/>

I ran into the some problems a while back when setting up
connection pooling on Tomcat on Gentoo. It turned out that
this was <a
href="https://bugs.gentoo.org/show_bug.cgi?id=144276">a known
issue to Gentoo</a> when using the Gentoo packages.


To remedy this, I had to do:

    # cd /usr/share/tomcat-6/lib
    # ln -s /usr/share/commons-dbcp/lib/commons-dbcp.jar


And override the data source factory in the
```Resource``` definitions in my
```server.xml```:

    factory="org.apache.commons.dbcp.BasicDataSourceFactory"

<p>instead of the default:
    org.apache.tomcat.dbcp.dbcp.BasicDataSourceFactory


