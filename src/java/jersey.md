title: Jersey
date:    2012-10-07
tags: rest
category: java

If you get this exception with no other clues anywhere (even if it says
you should get more clues "in the logs"):

```
09-May-2011 15:37:38 org.apache.catalina.core.StandardContext
filterStart SEVERE: Exception starting filter Jersey Filter
com.sun.jersey.api.container.ContainerException: Fatal issues found at
class net.skybert.ws.RootResource. See logs for more details.
at com.sun.jersey.server.impl.application.WebApplicationImpl.newResourceClass(WebApplicationImpl.java:552)
at com.sun.jersey.server.impl.application.WebApplicationImpl.getResourceClass(WebApplicationImpl.java:517)
at com.sun.jersey.server.impl.application.WebApplicationImpl.processRootResources(WebApplicationImpl.java:1153)
at com.sun.jersey.server.impl.application.WebApplicationImpl.initiate(WebApplicationImpl.java:918)
at com.sun.jersey.server.impl.application.WebApplicationImpl.initiate(WebApplicationImpl.java:589)
at com.sun.jersey.spi.container.servlet.ServletContainer.initiate(ServletContainer.java:429)
at com.sun.jersey.spi.container.servlet.ServletContainer$InternalWebComponent.initiate(ServletContainer.java:278)
at com.sun.jersey.spi.container.servlet.WebComponent.load(WebComponent.java:566)
at com.sun.jersey.spi.container.servlet.WebComponent.init(WebComponent.java:211)
at com.sun.jersey.spi.container.servlet.ServletContainer.init(ServletContainer.java:333)
at com.sun.jersey.spi.container.servlet.ServletContainer.init(ServletContainer.java:672)
```


It might very well be that you have an annotated web service
method that lacks annotation on (one of) its parameters. In
mycase, I had annotations on the first parameter, but not the
second:

```
public Response getSomeResponse(@QueryParam("first") String pFirst,
String pSecond) {
^
Missing @QueryParam
```


And <cite>yes</cite>, I checked all the logs; the application
server log, the system out log and the LOG4J log, and
<cite>no</cite>, there were no more exception details ;-)


