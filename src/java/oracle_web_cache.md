date:    2012-10-07
category: java
title: Oracle Web Cache
tags: oracle, performance

My oracle web cache notes.

## Segfaults all the time

At a customer site, we had the problem that Oracle Web
Cache segfaulted all the time (every day) and thus
restarted itself. This was evident under high load (more
than 1500 connections per second). The Oracle Webcach
tracedump looked like this:

```
<Reason>
Caught SIGSEGV
Error Number: 0
Signal Code: SEGV_MAPERR
Faulting Address: 0x0
</Reason>
```

It turned out that the
kernel parameters where not set (optimally) for oracle web
cache. The following steps were needed on this RedHat
Enterprise Linux ES release 3 running the RedHat patched
2.4.21 kernel.

    # echo 100 32000 100 100 > /proc/sys/kernel/sem
    # echo 131072 > /proc/sys/fs/file-max


To make these changes permanent, you need to add them to
```/etc/sysctl.conf```

```
# kernel parameters for Oracle Web Cache
kernel.shmall = 2097152
kernel.shmmax = 2147483648
kernel.shmmni = 4096
kernel.sem = 100 32000 100 100
fs.file-max = 131072
net.ipv4.ip_local_port_range = 1024 65000
net.core.rmem_default = 262144
net.core.rmem_max = 262144
net.core.wmem_default = 262144
net.core.wmem_max = 262144
```

The oracle user also had to have the correct ulimit commands. Be
careful that these are not overridden somewhere else, such
as```/etc/bashrc```, ```/home/oracle/.bash_profile``` or
```/home/oracle/.bashrc```

    ulimit -u 16384 -n 131072


Furthermore, it's important that the
```/etc/security/limits.conf``` allows the user(s)
to set what has been made possible in the above steps (here
it could of course be "oracle" instead of "*".
:


    # /etc/security/limits.conf

    # Oracle Webcache
    *               soft    nproc         2047
    *               hard    nproc         16384
    *               soft    nofile        2048
    *               hard    nofile        131072


## Setting up a new site

1. Site definitions - define your new site

2. Session Binding - you may use the default or add cookie based session binding.

3. Site to Server Mapping - map which servers behind the OWC that shall
  correspond to the different sites you have defined.

4.  caching, personalization ... (the new site may iniherit the
settings of former sites).



