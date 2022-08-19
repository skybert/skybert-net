title: MariaDB fails to start because mysql.db doesn't exist
date: 2022-08-19
category: linux
tags: arch, garuda, database, mysql


```text
# pacman -Sy mariadb
# systemctl enable mariadb
# systemctl start mariadb
```

But that failed. 

```text
# journalctl -xeu  mariadb.service
```

Gave a hint:

```text
[ERROR] Fatal error: Can't open and lock privilege tables: Table 'mysql.db' doesn't exist
```

It turned out that the MySQL system tables and users weren't
created. To remedy that, I did:

```text
# mysql_install_db --user=mysql --ldata=/var/lib/mysql
```

Now, after restarting mariadb, it ran as it should:

```text
# systemctl restart mariadb
# systemctl status mariadb
● mariadb.service - MariaDB 10.8.4 database server
     Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; preset: disabled)
     Active: active (running) since Fri 2022-08-19 12:53:40 CEST; 1s ago
```

Really strange this is necessary. On CentOS, RHEL, Debian and Ubuntu
this is done automatically for you.
