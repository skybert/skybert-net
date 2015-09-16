date:    2012-10-07
category: java
tags: tomcat, java, jsp
title: Be Aware of Quotes Inside Other Quotes

For example:

    <c:set var="myVariable" value="<%= myObject.get("key")%>"/>

Yields the following on several app servers (including Tomcat
6.0.28):

```
01-Apr-2011 12:24:57
org.apache.catalina.core.StandardWrapperValve invoke SEVERE:
Servlet.service() for servlet action threw exception
org.apache.jasper.JasperException: /my.jsp(25,44) Attribute
value myObject.get("key") is quoted with " which must be
escaped when used within the value
```

It turns out the JSP 2.0 specification clearly states that this is
illegal and thus all application servers that claim to be JSP 2.0
compliant will fail to compile such JSPs.


The funny thing with Tomcat, is that they changed the behaviour of
their JSP compiler in a maintenance release, namely 6.0.17 (with <a
href="https://issues.apache.org/bugzilla/show_bug.cgi?id=45015">a
regression bug fixed in 6.0.26</a>) as they then already claimed to be
JSP 2 compliant, but was not. Hence, this was a bug according to their
6.0.0 feature list and was thus <a
href="https://issues.apache.org/bugzilla/show_bug.cgi?id=45015">fixed
in 6.0.17</a> (and <a
href="https://issues.apache.org/bugzilla/show_bug.cgi?id=45015">again
in 6.0.26</a>, released 2010-03-11).


Thus, if you're using Tomcat and haven't upgraded it since
march last year, you stand the chance that your JSPs that run
flawlessly on your app server, not will do so on others'.


