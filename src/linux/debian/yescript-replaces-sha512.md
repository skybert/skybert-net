title: yescript replaces sha512 for password hashing
date: 2021-08-25
category: linux
tags: linux, debian, security

The default password hashing algorithm has been changed in Debian (and
thus Ubuntu) with the Bullseye release. `pam_unix` has changed to
using `yescrypt` instead of `sha512`.

This went pretty fast. The change in `pam` went into `unstable`
February and it landed in `testing` in time for the release of
Bullseye in August and thus becoming `stable`:

> * pam-configs/unix: Default to yescript rather than sha512.  From a
>   theoretical security standpoint, it looks like yescript has
>   similar security properties, assuming (as we typically do in the
>   crypto protocol community) that sha256 is still reasonable.
>   However, in terms of practical resistant to password cracking,
>   particularly in terms of valuing space complexity as well as time
>   complexity, yescript is superior,


References:
* https://www.debian.org/releases/bullseye/mips64el/release-notes/ch-information.en.html#pam-default-password
* https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=978553
* https://tracker.debian.org/news/1226655/accepted-pam-140-3-source-into-unstable/
