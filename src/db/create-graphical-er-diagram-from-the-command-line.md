title: Create graphical er diagram from the command line
date: 2023-10-20
category: db
tags: db, mariadb, mysql


To create a graphical er diagram of your database from the command
line, you can use
[schemaspy](https://schemaspy.readthedocs.io/en/v6.0.0/home.html).

On Arch Linux, you can install it with:
```text
$ paru -S schemaspy
```

For other distros, Windows and Mac: If you don't find it in your
package manager for your system, you can download the JAR file from
their website, it's a one-JAR-file program.

You're now set to use it. You pass it the database type, connection
details and so on. It's worth noting that for MySQL and MariaDB, the
datbase namae passed in `-db <db>` and schema given in `-s <schema>`
is the same.

```text
$ schemaspy -o ~/mydb-er-website \
    -t mariadb \
    -host localhost \
    -db mydb \
    -s mydb \
    -u myuser \
    -p hunter2
```

Point your browser at `~/mydb-er-website/index.html` and you'll find a
website dedicated to your database, including nice PNGs of each table
and its immediate relationsships, as well as diagrams of the complete
database.
