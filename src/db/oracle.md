date:    2012-10-07
category: db
title: My Oracle notes
tags: oracle

On this pages is some problems I've had with Oracle and
their solutions, hopefully someone else can also find the
hints useful :-)

## Running a script from the command line

    $ sqlplus myuser/mypass@mydb @/tmp/myscript.sql


## Listing top tokens in an index

    select token_text, token_count
    from dr$xml_index$i
    where token_count > 100000;


## Redefining a job

    exec dbms_job.remove(27);
    VARIABLE jobno number;
    execute
    dbms_job.submit(
      :jobno,
      'DBMS_UTILITY.ANALYZE_SCHEMA(
        "db_user",
        "ESTIMATE",
        null,
        35,
        "FOR ALL INDEXES"
      );',
      sysdate,
      'trunc(sysdate+1)+5/24'
    );

You can then see the jobs running using:

    select job, what, failures, broken, next_date, total_time from all_jobs;


## Error 46 initializing SQL*Plus

    Error 46 initializing SQL*Plus
    Internal error


The environment variable http_proxy must be valid, my error was that
the $http_proxy was at the time being not valid, what then was needed
was to unset the variable

       unset http_proxy

## Error 6 initializing SQL*Plus

    root@somehost:~# /u01/app/oracle/product/8.1.7/bin/sqlplus "/as sysdba"
    Message file sp1<lang>.msb not found
    Error 6 initializing SQL*Plus
    root@cmstest381:~# /u01/app/oracle/product/8.1.7/bin/sqlplus
    Message file sp1<lang>.msb not found
    Error 6 initializing SQL*Plus


The environment variable needs to be set:
    export ORACLE_HOME=/u01/app/oracle/product/8.1.7


## Environment variable cannot be evaluated

    ORA-07217: sltln: environment variable cannot be evaluated.


Another environment variable is needed:

    export ORACLE_SID=mysid


## Getting a sensible date format in SQL*Plus

A thing that bugs, is the standard date format that
does not include the time. To set a sensible format, write
the following at the SQLPlus command prompt:

    alter session set NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';


## Setting the width in SQL*Plus
    set lin <width>

## Specifying timestamp

    select * from mytable
    where thetimefield > timestamp'2005-04-14 12:00:00';


## Starting a running counter on a given value

    drop sequence my_table_seq;
    create my_table_seq increment by 1 start with 1000;


