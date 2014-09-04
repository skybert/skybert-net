date:    2012-10-07
category: db
title: PostgreSQL

My PostgreSQL notes, both troubleshooting and SQL
commands.

## Alter table

Adding fields to a table. Also see
<a href="http://www.postgresql.org/docs/8.0/interactive/sql-altertable.html">
the PostgreSQL manual (alter table)
</a>


    alter table eventInstance
    add externalId varchar
    add scheduleId varchar;


## Running a script

Often, you want to write an sql script that creates the entire schema
etc, this can be easily done with:


    $ psql -U myuser -d mydatabase < myscript.sql



