title: Debugging in Production: what has been deployed?
date: 2016-07-04
category: java
tags: java

I want to know what version of the class `com.example.MyApp` has been
deployed. I know that the old version of the class had one `makeWorld`
method which takes an `Object` as argument whereas the new version has
two `makeWorld` methods, the second of which also takes a `UriInfo`
object.

Now, I want to find out which version is currently running in the
application server. I only have SSH access to the box, and I cannot
set up remote debugging.

With the stage set, I `ssh` into the server and issue the following
commands:

```
$ cd /opt/tomcat/webapp/myapp
$ javap -p -cp WEB-INF/lib/myapp-1.0.jar com/example/MyApp | grep makeWorld
  public com.example.World makeWorld(java.lang.Object, javax.ws.rs.core.UriInfo);
  public com.example.World makeWorld(java.lang.Object);
```
