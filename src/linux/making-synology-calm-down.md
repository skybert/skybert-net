title: Making my Synology NAS calm down
date: 2021-08-27
category: linux
tags: linux, nas

I logged into my NAS
```text
$ ssh 192.168.1.50
```

I then could identify what process was burdening the system:
```text
$ top
```

And it `P` to sort on CPU usage. It quickly became appearant it was
the face recognition software that was killing the ARMv8 processor. 

According to the interweb, it should be sufficient to disable the face
recognition album in `Synology Photos`. It was not. The NAS still ran
and re-ran the face extraction process which made it close to
unusable.

So, I decided to solve this the good old Unix way. I got a hold of the
PID (well, I could have gotten that from top, but it changes some
times, so I prefer using `ps`):

```text
$ ps auxww | grep synofoto-face-extraction
29746 root      20   0   93.6m   2.4m 0.000 0.488   0:12.63 S /var/packages/SynologyPhotos/target/usr/sbin/synofoto-face-extraction
```

and tried to tell it nicely to stop:
```text
$ sudo su -
# kill <pid>
```

When that didn't help, I used force:
```text
# kill -9 <pid>
```

Now, onto the clever bit: I replaced the Synology binary with my old
tiny program. To do this, I first took a backup of the original app:

```text
# cd /var/packages/SynologyPhotos/target/usr/sbin/
# mv synofoto-face-extraction synofoto-face-extraction.orig
```

Then, I created my own `synofoto-face-extraction`:

```bash
# vi synofoto-face-extraction
```

and entered the smallest program I can think of:
```bash
#! /bin/sh
exit 0
```

That means it will run an `sh` process and return immediately with a
successful exit code, `0`. The only thing left to do now, was to make
the command executable:

```text
# chmod +x synofoto-face-extraction
```

With this hack in place, my NAS finally calmed down. All programs that
want to call out to `synofoto-face-extraction` can do so as
before. And since it returns `0`, the programs using it are happy. Not
only that, all Synology apps and web interfaces instantly became
faster and easier to use too!

After months of CPU spikes no matter what the NAS was up, I can now
appreciate a resource monitor speaks of peace:

<a href="/graphics/2021/2021-08-27-synology-nas-calmed-down.png">
  <img
    src="/graphics/2021/2021-08-27-synology-nas-calmed-down.png"
    alt="Synology taking a breahter"
    class="centered"
  />  
</a>

