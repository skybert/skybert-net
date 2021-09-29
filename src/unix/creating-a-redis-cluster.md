title: Creating a Redis Cluster
date: 2021-09-29
category: unix
tags: unix, caching, linux

I wanted to test out running a Redis cluster, this is what I did:

## Install redis itself

```text
# apt-get install redis
```

This gives you a running Redis instance on your machine. However, it's
only its binaries that we're really after here.

## Create six Redis nodes

```bash
$ mkdir {7000..70005
$ for el in {7000..7005}; do
  cat > $el/redis.conf <<EOF
port $el
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
EOF
  done
```

## Start the Six Redis nodes
```bash
$ for el in {7000..7005}; do
    (cd $el && nohup redis-server ./redis.conf & )
  done
```

## Create the Redis cluster
```bash
$ redis-cli \
  --cluster create \
    127.0.0.1:7000 \
    127.0.0.1:7001 \
    127.0.0.1:7002 \
    127.0.0.1:7003 \
    127.0.0.1:7004 \
    127.0.0.1:7005 \
  --cluster-replicas 1
```

This will create one replica for each of the masters. So the above
will create 3 masters and 3 replicas. This means Redis has _some_
redundancy, but if both the master and its replica goes down, the
other nodes will not be able to recover the data.

## Writing data on one node and retrieving it from another

```bash
root@redis:~# redis-cli -c -p 7001
127.0.0.1:7001> set user1 "john set on 7001"
OK
127.0.0.1:7001>
```

```bash
root@redis:~# redis-cli -c -p 7004
127.0.0.1:7004> get user1
-> Redirected to slot [8106] located at 127.0.0.1:7001
"john set on 7001"
127.0.0.1:7001>
```

Notice that, even though we queried a different node for the data we
wrote to `7001`, we were still redirected to `7001` when asking `7004`
for the data. This shows the high performance, sharding nature of how
Redis works - at the expense of redundancy/recovery. To mitigate this,
you can have more than one replica per master.

Happy caching!


