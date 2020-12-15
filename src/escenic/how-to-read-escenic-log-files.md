title: How to read Escenic Content Engine Log Files
date: 2017-10-06
category: escenic
tags: escenic, tomcat, solr

## tl;dr

To watch all log files related to ECE, run the following in a terminal:

```
$ tail -f /var/log/escenic/engine1-{tomcat,messages,catalina.out} \
          /opt/tomcat-engine1/logs/access.$(date --iso).log \
          /opt/tomcat-engine1/logs/localhost.$(date --iso).log
```

## Introduction

Knowing your way around the log files used by or indirectly related to
the Escenic Content Engine will enable you to quickly get an overview
of your system as well as identify root causes of misbehaving
components.

This is a no-nonsense guide to the most important log files that you
should consult whenever there is something in ECE which doesn't work
to your satisfaction.

## In depth

On a standard Escenic Content Engine system, each ECE instance will
have the following log files of interest. In this example, the ECE
instance is called engine1:

```
/var/log/escenic/engine1-messages
/var/log/escenic/engine1-catalina.out
/var/log/escenic/engine1-tomcat
/var/log/escenic/engine1-gc.log.0.current
/opt/tomcat-engine1/logs/access.2016-10-10.log
/opt/tomcat-engine1/logs/localhost.2016-10-10.log
```

Often you will find a search instance on the same machine, in which
case it has the same list of files, only with the search1 prefix.

### engine1-messages

This is the main log file. In here you will find messages from ECE
which are "controlled" errors, that is, errors that ECE has full
control over. The messages are written using the log4j logging
framework, utilising the various logging levels such as DEBUG, ERROR
and WARN.

You can modify on the fly which Java classes (or packages) that write
to this log file on which logging level, by visiting
http://localhost:8080/escenic-admin/debug on your ECE host(s). To make
changes persistent, you modify trace.properties, typically in
`/etc/escenic/engine/common/trace.properties`.

### engine1-catalina.out

This is where standard output is redirected. In here you shouldn't
find any messages from ECE (if you haven't added some
`System.out.println(..)` statements in your own Java code), but
instead messages from 3rd party libraries that are writing to standard
out or standard error while bootstrapping.

### engine1-tomcat or localhost.$(date --iso).log

When there are "uncontrolled" errors, they tend to end up in this
file. This happens typically if there's a severely misconfigured
system where ECE makes an assumption about a sane world and this turns
out to be utterly wrong. In here you'll also see errors from Tomcat
itself, e.g. class loader or JAR scanning issues.

If your `/var/log/escenic/engine1-tomcat` is empty, you're probably
running a more recent version of Tomcat means you must check
`/opt/tomcat-engine1/logs/localhost.$(date --iso).log` instead.

### engine1-gc.log.0.current

Consult this log file for information on how the JVM runs the garbage
collection on your system.

### access.&lt;date&gt;.log

This is the Tomcat access log, similar to the famous access log of the
Apache web server (typically found under
`/var/log/apache2/access.log`). Each time someone access your Tomcat,
e.g. access the ECE webservice, you will get an entry in this file.

The Tomcat access log is located under
`${CATALINA_BASE}/logs/access.<date>.log` instead of
`/var/log/escenic/engine1-tomcat-access-<date>.log` or similar since
this is something we cannot control using Tomcat's logging
configuration.

### Going further: add logging statements of all SQL queries

There's an easy way to get the JDBC driver to log all SQL statements
that it executes. These statements are complete with value, i.e. no ?s
instead of the values that other mechanisms (like Hibernate) provide
. To add this to your trace.properties, typically in
`/etc/escenic/engine/common/trace.properties`:

```bash
######################################################################
# sql logging
log4j.appender.SQL=org.apache.log4j.RollingFileAppender
log4j.appender.SQL.File=/var/log/escenic/${com.escenic.instance}-sql
log4j.appender.SQL.MaxFileSize=100MB
log4j.appender.SQL.MaxBackupIndex=1
log4j.appender.SQL.layout = org.apache.log4j.PatternLayout
log4j.appender.SQL.layout.ConversionPattern = %d [%t] %-5p %c- %m%n

log4j.category.jdbc.sqlonly=ERROR, SQL
log4j.category.jdbc.sqltiming=ERROR, SQL
log4j.additivity.jdbc.sqlonly=false
log4j.additivity.jdbc.sqltiming=false
```

The second thing you need, is to add log4jdbc driver to your classpath
and restart ECE:

```
$ cp log4jdbc4-1.2.jar /opt/tomcat-engine1/lib
$ ece -i engine1 restart
```

You should now get SQL statements logged to
`/var/log/escenic/engine1-sql`.

