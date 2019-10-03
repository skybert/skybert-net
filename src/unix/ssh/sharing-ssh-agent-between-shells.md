title: Sharing SSH agent between multiple shells
date: 2019-10-03
category: unix
tags: ssh, security, unix

If you're logged in with multiple shells on a machine and want to
reuse the SSH agent between them, there's an easy way that doesn't
involve anything but a line of BASH.

In your first shell, run `ssh-add` as normal to add the keys you need:

```text
$ ssh login.example.com
$ ssh-add
```

Then, in the other shell(s), re-use the SSH agent from the first shell with:

```bash
$ ssh login.example.com
$ export SSH_AUTH_SOCK=$(find /tmp/ssh-* -name "agent.*" -user
"$(whoami)" | tail -n 1)
```

Nice, secure and simple.
