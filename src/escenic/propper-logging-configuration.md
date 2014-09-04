title: Proper Logging Configuration
date:    2012-10-07
category: escenic
tags: java, logging

To set up proper logging with the Escenic Content Engine, I
use the following log4j configuration:

    log4j.rootCategory=ERROR, ECELOG
    log4j.appender.ECELOG=org.apache.log4j.DailyRollingFileAppender
    log4j.appender.ECELOG.File=/var/log/escenic/${escenic.server}-messages
    log4j.appender.ECELOG.layout=org.apache.log4j.PatternLayout
    log4j.appender.ECELOG.layout.ConversionPattern=%d %5p [%t] %x (%c) %m%n


I recommend putting this in
```/etc/escenic/engine/common/trace.properties``` and create symlinks
from a common class loader directory of the application server, e.g.:

    # cd /usr/share/tomcat6/lib
    # ln -s /etc/escenic/engine/common/trace.properties

