title: Seeing the SQL Hibernate produces
date: 2014-11-05
category: java
tags: java, hibernate, sql

There are two approaches here, one is to configure log4j to log useful
information from Hibernate and the other is to use a JDBC driver
wrapper which gives you beautiful logging of everything JDBC related,
including the SQL which Hibernate produces.

## Log4j for Hibernate 4

This gives you, depending on the JDBC driver, among other things, both
the SQL and the parameter values:

```
log4j.logger.org.hibernate.engine.jdbc.internal.JdbcCoordinatorImpl=TRACE
```

It's up to the JDBC driver whether or not to implement the
```toString()``` method whith something sensible. The HSQL DB driver
yields great results here, whereas the JTDS driver does not.

## Log4j for Hibernate 3 & 4

```
# gives you the SQL with placeholder question marks where the values go
log4j.logger.org.hibernate.SQL=DEBUG

# gives you the values corresponding to  the question mark placeholder numbers
log4j.logger.org.hibernate.type=TRACE
```

## JDBC driver wrapper

Use [log4jdbc](https://github.com/arthurblake/log4jdbc) which gives
you the full SQL without any fuss.

Just turn on these log categories:

    log4j.category.jdbc.sqlonly=DEBUG
    log4j.category.jdbc.sqltiming=DEBUG



