title: Seeing the SQL Hibernate produces
date: 2014-11-05
category: java
tags: java, hibernate, sql

# For Hibernate 3

## With minimal changes to your system

```
# gives you the SQL with placeholder question marks where the values go
log4j.logger.org.hibernate.SQL=DEBUG

# gives you the values corresponding to  the question mark placeholder numbers
log4j.logger.org.hibernate.type=TRACE
```

## With somewhat larger changes to your system
Use [https://code.google.com/p/log4jdbc/](log4jdbc) which gives you
the full SQL without any fuss.

Just turn on these log categories:

    log4j.category.jdbc.sqlonly=DEBUG
    log4j.category.jdbc.sqltiming=DEBUG



