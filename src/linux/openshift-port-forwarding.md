title: OpenShift Port Forwarding
date: 2024-11-01
category: linux
tags: linux

I want to connect to a MariaDB server running inside one of my pods:

First, I get the pod id:
```text
$ oc get pods | grep -w db
foo-db-75df5b9949-x9zcj :3306
```

Now, I forwarded the MariaDB server port to a random local port:

```perl
$ oc port-forward foo-db-75df5b9949-x9zcj :3306
Forwarding from 127.0.0.1:39219 -> 3306
Forwarding from [::1]:39219 -> 3306
Handling connection for 39219 
```

Finally, I could use my local `mariadb` client to connect to the
MariaDB running inside my Openshift cluster:

```text
$ mariadb \
    --host=localhost \
    --port=39219 \
    --user=${FOO_DB_USER} \
    --password=${FOO_DB_PASSWORD} \
    --database=${FOO_DB_SCHEMA}

Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 36
Server version: 11.4.3-MariaDB-ubu2404 mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [foodb]>
```

Cool, eh? Happy SQLing!
