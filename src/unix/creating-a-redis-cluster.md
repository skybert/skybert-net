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
$ mkdir {7000..7005}
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

`redis-cli` asks if it's ok that some of the nodes are on the same
node as the controller, to which we answer `yes`:

```
>>> Performing hash slots allocation on 6 nodes...
Master[0] -> Slots 0 - 5460
Master[1] -> Slots 5461 - 10922
Master[2] -> Slots 10923 - 16383
Adding replica 127.0.0.1:7004 to 127.0.0.1:7000
Adding replica 127.0.0.1:7005 to 127.0.0.1:7001
Adding replica 127.0.0.1:7003 to 127.0.0.1:7002
>>> Trying to optimize slaves allocation for anti-affinity
[WARNING] Some slaves are in the same host as their master
M: 9d522bed9ddd5f18f0a3088f3e73f158a50d552c 127.0.0.1:7000
   slots:[0-5460] (5461 slots) master
M: 2a4b5c846a7bb5079b63761c63f2a65b25a409e2 127.0.0.1:7001
   slots:[5461-10922] (5462 slots) master
M: 68f4e865b92defb9cad0227b2a73f593d3795e9c 127.0.0.1:7002
   slots:[10923-16383] (5461 slots) master
S: 4c7354de2dd034ab54f7abc5b93e0ca5103de195 127.0.0.1:7003
   replicates 68f4e865b92defb9cad0227b2a73f593d3795e9c
S: 753f007b2ebd1c52e6a024723da49e1390bffe63 127.0.0.1:7004
   replicates 9d522bed9ddd5f18f0a3088f3e73f158a50d552c
S: 8bb1de7e0680ad290882eb77537bb03cfe725a55 127.0.0.1:7005
   replicates 2a4b5c846a7bb5079b63761c63f2a65b25a409e2
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join
.
>>> Performing Cluster Check (using node 127.0.0.1:7000)
M: 9d522bed9ddd5f18f0a3088f3e73f158a50d552c 127.0.0.1:7000
   slots:[0-5460] (5461 slots) master
   1 additional replica(s)
S: 753f007b2ebd1c52e6a024723da49e1390bffe63 127.0.0.1:7004
   slots: (0 slots) slave
   replicates 9d522bed9ddd5f18f0a3088f3e73f158a50d552c
M: 2a4b5c846a7bb5079b63761c63f2a65b25a409e2 127.0.0.1:7001
   slots:[5461-10922] (5462 slots) master
   1 additional replica(s)
S: 4c7354de2dd034ab54f7abc5b93e0ca5103de195 127.0.0.1:7003
   slots: (0 slots) slave
   replicates 68f4e865b92defb9cad0227b2a73f593d3795e9c
M: 68f4e865b92defb9cad0227b2a73f593d3795e9c 127.0.0.1:7002
   slots:[10923-16383] (5461 slots) master
   1 additional replica(s)
S: 8bb1de7e0680ad290882eb77537bb03cfe725a55 127.0.0.1:7005
   slots: (0 slots) slave
   replicates 2a4b5c846a7bb5079b63761c63f2a65b25a409e2
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered.
```

This will create one replica for each of the masters. So the above
will create 3 masters and 3 replicas. This means Redis has _some_
redundancy, but if both the master and its replica goes down, the
other nodes will not be able to recover the data.

If you download the Redis source code, you can find a [script that
does all of this for
you](https://github.com/redis/redis/blob/unstable/utils/create-cluster)
(but what's the fun in that 😉).

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


