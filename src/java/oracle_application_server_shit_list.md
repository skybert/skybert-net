date:    2012-10-07
category: java
title: My Oracle Application Server Shit List
tags: oracle

<p class="reg">
Things that are HUGELY annoying when working with Oracle
Application Server.

## Creating a new OCJ4 instance throws password expcetions

When creating a new OC4J instance with
```./bin/createinstance -instanceName myInstance```
you're prompted for admin password of that instance, i.e. a
new passowrd. Now,
if you enter something different than the main Oracle admin
password, it throws tons of exceptions!


To make matters
worse, the instance is in spite of the exceptions
created. You can start it, but you can't do much more as
it's non functional. The only remedy here, is to stop it,
remove it and add it again - this time with the same
password as```oc4jadmin```

## You cannot install OAS without a graphical display

This is the most stupid thing - ever! You connot run the
installer with having X installed, and having access to
it. This is so stupid only a windows person could have made
it. How many Unix server programs have you installed that
require a GUI?

## Oracle's default connection pool does not handle a query that
fails.

Oracle's default connection pool does not handle a query that
fails. Instead, it gives a "socket write error".

## It's impossible to update jar files while OC4J is running

With all other app servers, you can upgrade a jar file
while the server is running, the new jar file first be
activated with a restart.


With OAS, you always need to take down the OC4J instance
when updating a library. This is <strong>hugely</strong>
annoying when working in <em>both</em> production and
development environments.

## It doesn't read properties files in CLASSPATH

Typically, you write your log4j (logging) configuration in
a properties file that is put in the appserver's
CLASSPATH. Editing the configuration is then only a matter
of editing the properties file.


With OAS, you have to put the properties file in a jar,
which then is put into the OC4J classpath. Now, when you
know that OC4J doesn't let you update jars while running,
you'll relaise the sad fact that you have to stop the OC4J
instance just to update your logging configuration!

## The logs don't rotate per default

You need to configure rotating of the logs for
<em>each</em> OC4J instance. This you must do in six
XML files - one is not enough. Furthermore, it's impossible
to rotate the main log file - for this you need two patches
(!) from Oracle. See <a
href="viewpage.py.cgi?computers+appservers+oracle_application_server">
my notes on OAS
</a>
for a walkthrough on how to enable rotation on all OAS
logs.

## You cannot install OAS into a directory which contain anything but letters

This means that a standard install directory name
of```program-version``` is impossible! So, instaed of installing OAS
into, say ```/opt/soa-10.0.1.3```, you have to go with something
simpler, e.g.  ``` /opt/oas ```.


Now, this means that you cannot have multiple
versions of OAS installed, and a symlink pointing to the
current one as you would with any other Unix program on
the globe!


To illustrate what I want:

```
/opt/oas-10.1.1.1
/opt/oas-10.2.1.1
/opt/oas -> /opt/oas-10.2.1.1
```


