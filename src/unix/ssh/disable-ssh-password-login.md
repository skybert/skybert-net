title: Disable SSH Password Login
date: 2022-07-05
category: linux
tags: linux, security, ssh

I recommend using SSH key based authentication to all your Unix
servers. There's a good [rationale for this written
here](https://security.stackexchange.com/a/3898).

To ensure users use SSH keys to log into your server, turn off
`PasswordAuthentication` like so:

```text
# echo PasswordAuthentication no > /etc/ssh/sshd_config.d/disable-password-login.conf
# systemctl reload sshd
```

Now, if the user doesn't have a private key that matches the entries
in `~/.ssh/authorized_keys` on the server when logging in, he'll get
no password prompt anymore:

```text
$ ssh foo@ssh.example.com
foo@ssh.example.com: Permission denied (publickey).
```
