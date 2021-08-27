title: LXD containers don't start because of  snap-confine has elevated permissions
date: 2021-04-30
category: linux
tags: linux, containers, lxd, security

The error message looks like this:
```text
snap-confine has elevated permissions and is not confined but should
be. Refusing to continue to avoid permission escalation attacks
```

It's due to Apparmor and the kernel you're running. I remedied this
with:

```text
# apparmor_parser -r /etc/apparmor.d/*snap-confine*
# apparmor_parser -r /var/lib/snapd/apparmor/profiles/snap*
```
