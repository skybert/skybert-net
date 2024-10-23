title: Microsoft Defender has Constant High CPU Load
date: 2024-08-06
category: linux
tags: linux, microsoft

The fan's been spinning for hours. The Microsoft Defender is a gift that keeps on giving:

<img
  class="centered"
  src="ksnip_20240806-084305.png"
  alt="Microsoft Defender constantly high CPU"
/>

The interweb suggested asking `mdatp` what's up, but that didn't really help either:

```text
# mdatp diagnostic real-time-protection-statistics --output json |
    python high_cpu_parser.py
```

A bit of
```
# strace -p <pid> -f
```

gave me a hunch, though:

```
FUTEX_WAIT_PRIVATE, 0, {tv_sec=0, tv_nsec=500000000}) = -1 ETIMEDOUT (Connection timed out)
```

This is a known pattern for multiple directory scans running. This
made me curious if I had multiple `wdavdaemon` processes running. And
lo and behold, I had.

It turns out,
```
# paru -Syu
```

had upgraded Microsoft Defender, but a restart:
```
# systemctl daemon-reload
# systemctl restart mdatp
```

didn't shut down the old process cleanly.

A `systemctl stop mdatp` and a good old `kill -9 <pid>` saved the
day:
```text
# systemctl stop mdatp
# kill -9 $(pidof wdavdaemon)
```

Now, there should be no `wdavdaemon` running:
```
# pidof wdavdaemon
#
```

And we can start Microsoft Defender again:
```
# systemctl start mdatp
```

Now, `mdatp` runs again and my CPU fan is quiet. 

```text
$ top -p $(pidof wdavdaemon | tr ' ' ',')
```

Lists only `wdavdaemon` processes each consuming less than a
percent. 

<img
   class="centered"
   src="ksnip_20240806-084259.png"
   alt="alt img text"
/>

Good grief.

