title: Running JAX-RS applications on Tomcat
date: 2015-08-11
category: java
tags: java, tomcat

Running JAX-RS applications on vanilla Tomcat is not straight forward
if you don't know the caveats. The short story is that you'll need to
include extra runtime JARs and must set up a servlet in `web.xml` to
bootsrap JAX-RS even though you're using an
[javax.ws.rs.core.Application](https://docs.oracle.com/javaee/6/api/javax/ws/rs/core/Application.html)
class.

These are the crucial bits I set up to run my JAX-RS
[javax.ws.rs.core.Application](https://docs.oracle.com/javaee/6/api/javax/ws/rs/core/Application.html),
`net.skybert.bookends.ws.BookendsWS`, on
[Apache Tomcat 8.0.24](http://tomcat.apache.org). Also note that this
CXF servlet did _not work_ on Tomcat 7.0.63 (for that version of
Tomcat, you'll need to search out a different servlet to bootstrap
JAX-RS).

There are different servlets that you can ues to bootstrap JAX-RS in
your webapp. I found CXF to be the easiest to use:

## POM
```
<dependency>
  <groupId>org.apache.cxf</groupId>
  <artifactId>cxf-rt-frontend-jaxrs</artifactId>
  <version>3.1.2</version>
</dependency>
```

## WEB-INF/web.xml

This is the real pain of not using a JEE container (like JBoss or
TomEE) but only a servlet container; you must wire up JAX-RS in your
web application descriptor:

```
<servlet>
  <servlet-name>CXFServlet</servlet-name>
  <display-name>CXF Servlet</display-name>
  <servlet-class>
    org.apache.cxf.jaxrs.servlet.CXFNonSpringJaxrsServlet
  </servlet-class>
  <init-param>
    <param-name>javax.ws.rs.Application</param-name>
    <param-value>
      net.skybert.bookends.ws.BookendsWS
    </param-value>
  </init-param>
  <load-on-startup>1</load-on-startup>
</servlet>

<servlet-mapping>
  <servlet-name>CXFServlet</servlet-name>
  <url-pattern>/*</url-pattern>
</servlet-mapping>
```

## The javax.ws.rs.core.Application implementation, BookendsWS

Remember to implement the `getClasses()` method:
```java
@Override
@SuppressWarnings("unchecked")
public Set<Class<?>> getClasses() {
     return new HashSet<Class<?>>(Arrays.asList(Pong.class, Root.class));
}
```

## Want something that just works?

[tomee.apache.org](Apache TomEE) has much more of a plug and play
experience, much like you'd find with [JBoss](http://jboss.org).

Using TomEE, you can just implement your
`javax.ws.rs.core.Application` and annotate your REST classes
correctly and deploy the webapp. It just works, no need `web.xml` or
extra runtime libraries are necessary.

JBoss will give you the same plugin and play experience, but if you
really want to use Tomcat, just with the plug and play feature, TomEE
will fit the bill perfectly.
