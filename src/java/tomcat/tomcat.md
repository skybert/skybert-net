date:    2012-10-07
category: java
title: Apache Tomcat
tags: tomcat, performance

<img src="http://tomcat.apache.org/images/tomcat.gif"
alt="tomcat"
style="float: right;"
/>

Below are some small notes I've jotted down when working
with Tomcat.

## Performance tuning
### Calling Context#getAttribute()

We have experience performance problems becaues of this method:

```
org.apache.catalina.core.ApplicationContext.findAttribute(String)
``` which is synchronised. Thus, limit your
application's usage of this method.

## Cannot find javax/servlet/Filter

I all of a sudden started getting this exception on my
Tomcat 6.0.10:


SEVERE: Exception starting filter authenticationFilter
java.lang.NoClassDefFoundError: javax/servlet/Filter



Touching the
```$CATALINA_HOME/lib/servlet-api.jar``` seemed to
miraculously fix the problem.


