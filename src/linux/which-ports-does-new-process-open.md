title: Which hosts & ports does a command open?
date: 2018-08-13
category: linux
tags: linux, network, git

To see which ports a process opens, you can use `strace` like this:

```text
$ strace -f -e trace=network -s 10000 \
  git ls-remote -h -t git://github.com/fengyuanchen/datepicker.git 2>&1  | \
  grep -w connect | \
  grep -v NOENT
connect(3, {sa_family=AF_INET, sin_port=htons(9418), sin_addr=inet_addr("192.30.253.113")}, 16) = 0
connect(3, {sa_family=AF_UNSPEC, sa_data="\0\0\0\0\0\0\0\0\0\0\0\0\0\0"}, 16) = 0
connect(3, {sa_family=AF_INET, sin_port=htons(9418), sin_addr=inet_addr("192.30.253.112")}, 16) = 0
connect(3, {sa_family=AF_INET, sin_port=htons(9418), sin_addr=inet_addr("192.30.253.113")}, 16) = 0
```

The above command figures out which servers and ports the command `git
ls-remote -h -t git://github.com/fengyuanchen/datepicker.git` will
attempt to open.  As you can see, using git over the `git://` protocol
will access the git server, github.com in this case, on port `9418`.

`strace` is awesome, yeah?

## sherlock

Admittedly, the above is a mouthful to type, so I've written a command
called
[sherlock](https://gitlab.com/skybert/my-little-friends/blob/master/bash/sherlock)
which makes this easy and presents the output on a more human friendly
format:

```text
$ sherlock git ls-remote -h -t git://github.com/fengyuanchen/datepicker.git
192.168.1.53:53     dns.example.com:53
192.30.253.113:443  lb-192-30-253-113-iad.github.com:443
192.30.253.112:443  lb-192-30-253-112-iad.github.com:443
192.30.253.113:443  lb-192-30-253-113-iad.github.com:443
```
