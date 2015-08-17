date:    2012-10-07
category: db
title: MySQL

My MySQL notes.

## Create database

    mysql> create database db_name;
    mysql> grant all on db_name.* to user@'%' identified by 'my_password';
    mysql> grant all on db_name.* to user@'localhost' identified by 'my_password';


## Read SQL from a file

There's two scenarios here, doing it from the standard
command line and doing it from within the mysql shell. To do
the latter, you simply use the```source``` command:

    mysql> source create_my_db.sql

and to run it from the shell, you'll simply do

    $ mysql < create_my_db.sql

## Different BLOB types and sizes

I was surprised to find that there are several BLOB types in
MySQL, with the standard type called "BLOB" only capable of
holding 65 kilobytes!

To get BLOB columns to actually hold something useful, like a normal
JPEG picture, you need to use either the MEDIUMBLOB or LONGBLOB
type. On dev.mysql.com there's a <a
href="http://dev.mysql.com/doc/refman/5.0/en/storage-requirements.html">
complete overview of the different types and sizes </a>

## Backing up the MySQL server

It's easy to backup the DB and compress it at the same time
by issuing the following command:


    $ mysqldump -u myuser -h localhost -pmypassword mydb | gzip -9 > mydb-db.sql.gz


To give you an idea of the size of this, I have a 6.2 GB database,
which in gzip-ed form after the dump takes 329 MBs.


Getting it back is then just a matter of:


    $ zcat mydb-db.sql.gz | mysql -u myuser -h localhost -pmypassword mydb -


## Changing the length of a column

In my case, I needed to change a column from being a VARCHAR
with 255 characters to allow 300 characters. What I needed
to do was:

    mysql> alter table mytable modify mycolumn VARCHAR(300);


## Not being able to login remotely

    $ mysql -u myuser -pmypassword -h myhost mydb
    ERROR 2003 (HY000): Can't connect to MySQL server on 'myhost' (111)


This is because mysql on doesn't listen to other hosts than
localhost, this is the default on Debian. To enable remote
access, edit:```/etc/mysql/my.cnf``` and the line:

    bind-address            = 127.0.0.1


To allow only access through one IP/interface, set this
variable to this IP, or comment it out to allow access to
all hosts (less secure of course).

## Starting a running counter on a given value

    mysql> alter table my_table auto_increment = 200;


## Run commands directly from the shell prompt

    $ mysql mydb -e "show master status"


This will output the results diretly in the shell so that you
instantly can use it, piping the output to another process as you'd do
with any other shell command.

## Check the encoding and collation for the entire DB schema

```
select * from information_schema.schemata where schema_name = "ece5db";
```

## Check the encoding and collation for a given column

```
mysql> select table_schema, table_name, column_name, character_set_name, collation_name
       from information_schema.columns
       where table_name = 'URIAlias'
       and column_name = 'uri';
+--------------+------------+-------------+--------------------+-----------------+
| table_schema | table_name | column_name | character_set_name | collation_name  |
+--------------+------------+-------------+--------------------+-----------------+
| ece5db       | URIAlias   | uri         | utf8               | utf8_general_ci |
+--------------+------------+-------------+--------------------+-----------------+
1 row in set (0.00 sec)
```

For all encoding geeks out there: The column name is character set,
but the value in the column is an encoding 😃

## Change the collation for a given column

```
mysql> alter table URIAlias
       modify uri
         varchar(250)
         character set utf8
         collate utf8_general_ci;
```

