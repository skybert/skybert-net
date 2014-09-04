title: Mobiletech
date:    2012-10-07
category: escenic

## Your app server with Escenic Content Engine & Viz Mobile Expansion fails to start

If you see this in your app log:


    SEVERE: Servlet /myapp threw load() exception
    javax.servlet.ServletException: The Mobiletech License could not
    be initialized. Please contact support@mobiletech.no at
    com.mobiletech.dxf.core.servlet.DeviceRepoInit.init(DeviceRepoInit.java:53)


## Remedy

You need```frame-license.properties``` in your common
app server classpath (contact Mobiletech for a valid license)
and a correct
```myapp/WEB-INF/classes/config/core.properties``` for
each of your web applications

