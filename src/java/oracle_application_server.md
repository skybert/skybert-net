date:    2012-10-07
category: java
title: Oracle Application Server

This mighty beasts are quite cool once they get running ... some are
more mighty than others, I know!

## Listing the ports being used

To get a list of all ports and processes running in the
OAS, do

    ./opmn/bin/opmnctl status -l

## Accessing the appserver directly

The OC4J instances do not have an HTTP connector per
default. This means that out of the box, the only way to
access your webapp is through Apache (what Oracle has
branded "Oracle HTTP Server"). This is in production fine,
but when testing the appserver itself, you want to access
it directly, as you would access your Tomcat or Resin
appserver.


Look for an

```<OC4J_INSTANCE>/config/http-web-site.xml</coe>,
it should be there. Add a line to its configuration for
your webapp (you'll find the same line in your
```default-web-site.xml```.

```
<web-app
application="default"
name="mywebapp"
root="/mywebapp"
access-log="false"
/>
```


Then add a line like this in you
```server.xml```


<web-site default="false" patch="./http-web-site.xml"/>


## Logging
### Rotating logs

To enable rotating logs in OC4J, do the following: change
the```log``` element to use the odl logger instead
of the file logger. The ODL can, among other things, rotate
the logs. When going through the conifg files you will see
<em>either</em> an access-log element <em>or</em> a log
element.



If you find an```access-log``` element, comment it
out and replace it with```odl-access-log```. For
example:


<!--
Only have one logging system
<access-log
path="../log/default-web-access.log"
/>
-->
<odl-access-log
path="../log/default-web-access"
max-file-size="1000"
max-directory-size="10000"
/>



Likewise, if you find a <cdoe>file``` element as a
child of the```log``` element, replace it with
```odl```. For example:


<!--
Only have one logging system
<file path="../log/global-application.log"/>
-->
<odl
path="../log/global-application/"
max-file-size="1000"
max-directory-size="10000"
/>


#### Files you need to edit

-

```
    $ORACLE_HOME/j2ee/<OC4J instance>/conf/application.xml
```

-

```
    $ORACLE_HOME/j2ee/<OC4J instance>/conf/default-web-site.xml
```

-

```
    $ORACLE_HOME/j2ee/<OC4J instance>/conf/http-web-site.xml
```

-

```
    $ORACLE_HOME/j2ee/<OC4J instance>/conf/jms.xml
```

-

```
    $ORACLE_HOME/j2ee/<OC4J instance>/conf/rmi.xml
```

-

```
    $ORACLE_HOME/j2ee/<OC4J instance>/conf/server.xml
```


## Updating the configuration

After updating configuration, run the distributed
configuration manager and then restart the OC4J instanse you
have configured.


    $ORACLE_HOME/dcm/bin/dcmctl updateconfig


## Restarting the entire server

    $ORACLE_HOME/opmn/bin/opmnctl stopall
    $ORACLE_HOME/opmn/bin/opmnctl startall



Please note, that usually it is enough to isseu:


    $ORACLE_HOME/opmn/bin/opmnctl restartproc


