title: Kafka Fails to Start
date: 2025-04-29
category: linux
tags: linux, kafka

After upgrading to Kafka 4 on [my Arch Linux
machine](/dongxi/the-way-i-work-in-2025/), Kafka would no longer
start:

```text
$ grep '2025.*upgraded kafka' /var/log/pacman.log
[2025-04-08T09:19:03+0200] [ALPM] upgraded kafka (3.9.0-1 -> 4.0.0-1)
```

## The error: No readable meta.properties files found

```perl
× kafka.service - Kafka server
     Loaded: loaded (/usr/lib/systemd/system/kafka.service; enabled; preset: disabled)
     Active: failed (Result: exit-code) since Mon 2025-04-28 16:50:56 CEST; 19h ago
   Duration: 992ms
 Invocation: ba41cd048f3e43e29559fcd7bf5ae786
    Process: 523358 ExecStart=/usr/bin/kafka-server-start.sh /etc/kafka/server.properties (code=exited, status=1/FAILURE)
   Main PID: 523358 (code=exited, status=1/FAILURE)
   Mem peak: 134.5M
        CPU: 1.429s

Apr 28 16:50:56 mithrandir kafka-server-start.sh[523358]: java.lang.RuntimeException: No readable meta.properties files found.
Apr 28 16:50:56 mithrandir kafka-server-start.sh[523358]:         at org.apache.kafka.metadata.properties.MetaPropertiesEnsemble.verify(MetaPropertiesEnsemble.java:480) ~[kafka-metadata-4.0.0.jar:?]
Apr 28 16:50:56 mithrandir kafka-server-start.sh[523358]:         at kafka.server.KafkaRaftServer$.initializeLogDirs(KafkaRaftServer.scala:141) ~[kafka_2.13-4.0.0.jar:?]
Apr 28 16:50:56 mithrandir kafka-server-start.sh[523358]:         at kafka.server.KafkaRaftServer.<init>(KafkaRaftServer.scala:56) ~[kafka_2.13-4.0.0.jar:?]
Apr 28 16:50:56 mithrandir kafka-server-start.sh[523358]:         at kafka.Kafka$.buildServer(Kafka.scala:68) ~[kafka_2.13-4.0.0.jar:?]
Apr 28 16:50:56 mithrandir kafka-server-start.sh[523358]:         at kafka.Kafka$.main(Kafka.scala:75) [kafka_2.13-4.0.0.jar:?]
Apr 28 16:50:56 mithrandir kafka-server-start.sh[523358]:         at kafka.Kafka.main(Kafka.scala) [kafka_2.13-4.0.0.jar:?]
Apr 28 16:50:56 mithrandir systemd[1]: kafka.service: Main process exited, code=exited, status=1/FAILURE
Apr 28 16:50:56 mithrandir systemd[1]: kafka.service: Failed with result 'exit-code'.
Apr 28 16:50:56 mithrandir systemd[1]: kafka.service: Consumed 1.429s CPU time, 134.5M memory peak.
```

## Trying to solve it

First up, was to figure out where Kafka reads its data log from:

```text
# grep ^log.dirs /etc/kafka/server.properties
log.dirs=/tmp/kraft-combined-logs
```

I then created this non-existant directory:
```text
# mkdir /tmp/kraft-combined-logs
```


And initialised the Kafka storage in this directory:
```text
# sudo -u kafka kafka-storage.sh format -t $(kafka-storage.sh random-uuid) -c /etc/kafka/server.properties --standalone
Formatting dynamic metadata voter directory /tmp/kraft-combined-logs with metadata.version 4.0-IV3.
```

That created these files, and it, at least to me, looked good: 
```text
# tree /tmp/kraft-combined-logs/
/tmp/kraft-combined-logs/
├── bootstrap.checkpoint
├── cleaner-offset-checkpoint
├── __cluster_metadata-0
│   ├── 00000000000000000000-0000000000.checkpoint
│   ├── 00000000000000000000.index
│   ├── 00000000000000000000.log
│   ├── 00000000000000000000.timeindex
│   ├── 00000000000000000059.snapshot
│   ├── leader-epoch-checkpoint
│   ├── partition.metadata
│   └── quorum-state
├── log-start-offset-checkpoint
├── meta.properties
├── recovery-point-offset-checkpoint
└── replication-offset-checkpoint

2 directories, 14 files
```

However, starting it from systemd still failed, although manually
starting it worked (wot?!!):

```text
# sudo -u kafka /usr/bin/kafka-server-start.sh /etc/kafka/server.properties
```

## Fixing it for real

It turned out that the reason it didn't work from systemd, was because
the binary logs were in `/tmp`, which was mounted like this:

```text
$ mount | grep /tmp
tmpfs on  /tmp type tmpfs (rw,nosuid,nodev,nr_inodes=1048576,inode64)
```

To change this, I did:
```text
# vim /etc/kafka/server.properties
```

And changed `log.dirs` to:
```conf
log.dirs=/var/lib/kafka
```

The directory was already owned and writeable by the `kafka` user, but
just to be sure I checked both that the systemd unit was started as
the `kafka` user and that the directory was owned by this user:

```text
# ls -ltra /var/lib/kafka
drwxr-xr-x 3 kafka kafka 4.0K Apr 29 13:23 /var/lib/kafka/
```

```text
# systemctl cat kafka | grep ^User=
User=kafka
```

I then, created new storage files for Kafka using the `kafka`
user. The command reads the target directory from
`/etc/kafka/server.properties`, so it was just another invocation of
the command from before:

```text
# sudo -u kafka kafka-storage.sh format -t $(kafka-storage.sh random-uuid) -c /etc/kafka/server.properties --standalone
```

With those two changes, Kafka now started successfully:

```text
# systemctl restart kafka
```

Yeah! 

## Fixing the logging

While at it, I fixed another thing, namely the logging. You see, Kafka
complained that:

```text
main ERROR Reconfiguration failed: No configuration found for '76ed5528' at 'null' in 'null'
```

This turned out to be log4j not being able to configure itself
properly.  To fix this, I told the systemd unit to use the log4j
configuraiton that is _actually_ in the Arch package, the YAML version
and not the old `.properties` version that's no longer there:

```text
# ls /etc/kafka/log4j*
lrwxrwxrwx 1 root root 35 Mar 20 00:24 /etc/kafka/log4j2.yaml -> /usr/share/kafka/config/log4j2.yaml
```

The systemd unit was clearly missing the correct log4j conf reference,
so I created an override:

```text
# systemctl edit kafka
```

At the top, I added:
```ini
[Service]
Environment=
Environment=KAFKA_PID_DIR=/run/kafka/
Environment=LOG_DIR=/var/log/kafka
Environment="KAFKA_LOG4J_OPTS=-Dlog4j.configurationFile=/etc/kafka/log4j2.yaml"
```

Now, reload systemd and restart the `kafka` unit:

```text
# systemctl daemon-reload
# systemctl restart kafka
```

And now, Kafka wasn't only running poperly, but also produced useful
log message, allowing me to turn on debug logging too to delve deeper.

Happy messaging!
