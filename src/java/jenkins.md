title: Jenkins
date: 2016-06-06
category: java
tags: java, jenkins, unix, nfs

My notes on getting Jenkins to play nice.

## Device or resource busy
```
java.nio.file.FileSystemException:
/var/lib/jenkins/workspace/release-phase-2/src/common/.nfs000000000218264e00002879:
Device or resource busy`
```

First check what process is keeping this file open:
```
$ lsof /var/lib/jenkins/workspace/release-phase-2/src/common/.nfs000000000218264e00002879
COMMAND   PID    USER   FD   TYPE DEVICE SIZE/OFF     NODE NAME
less    22763 escenic    4r   REG   0,22     2531 35137102
  /var/lib/jenkins/workspace/release-phase-2/src/common/.nfs000000000218264e00002879
```

Then, figure out the actual file (the NFS file name was misleading
here) used. For this, I use the PID in the above listing:

```
$ ps up 22763
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
escenic  22763  0.0  0.0  10776   956 pts/0    S+   13:12   0:00 less common/pom.xml
```

If this is a server, which it normally is, you can have a look at the
output from `w` to find out from which host the user is connecting to
give a hint of who he/she is (if you're using common users for the
build server):

```
$ w | grep less
```
