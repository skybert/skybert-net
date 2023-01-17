title: Grant a single user access to your x session
date: 2023-01-17
category: unix
tags: unix

Say you're logged into your laptop as `lisa` and want to give another
user on the same machine access to your X session, i.e. open graphical
applications. For years, I disabled X's authentication mechanism
alltogeter with:

```text
$ whoami
lisa
$ xhost +
```

The `john` user could now start graphical appliations:
```text
$ whoami
john
$ export DISPLAY=:0
$ xeyes &
```

However, there's a better way. To grant *only* `john` access to your
graphical dispaly, instead do:


```text
$ whoami
lisa
$ xhost +SI:localuser:john
```

Now, as `john`, export the display to the local one and start the
graphical application:

```text
$ whoami
john
$ export DISPLAY=:0
$ xeyes &
```

You can turn off access to your X server by:
```text
$ xhost -
```
