title: fail2ban with systemd journal
date: 2025-02-05
category: linux
tags: linux, aws, security

The [fail2ban](https://github.com/fail2ban/fail2ban) package installed
on the Debian version offered by AWS has a default configuration that
depends on reading log files. This doesn't work when
e.g. [sshd](https://www.openssh.com/) writes failed login attempts to
the systemd journal rather than the traditional `/var/log/auth.log`.

The error looks like this:
```text
#  systemctl status fail2ban
× fail2ban.service - Fail2Ban Service
     Loaded: loaded (/lib/systemd/system/fail2ban.service; enabled; preset: enabled)
     Active: failed (Result: exit-code) since Wed 2025-02-05 19:43:14 UTC; 2s ago
   Duration: 82ms
       Docs: man:fail2ban(1)
    Process: 7698 ExecStart=/usr/bin/fail2ban-server -xf start (code=exited, status=255/EXCEPTION)
   Main PID: 7698 (code=exited, status=255/EXCEPTION)
        CPU: 80ms

systemd[1]: Started fail2ban.service - Fail2Ban Service.
..
fail2ban-server[8032]: 2025-02-05 19:51:15,947 fail2ban [8032]:  ERROR   Failed during configuration: Have not found any log file for sshd jail
..
systemd[1]: fail2ban.service: Main process exited, code=exited, status=255/EXCEPTION
systemd[1]: fail2ban.service: Failed with result 'exit-code'.
```

The fix is simple, though, just add the following to the enabled jail,
or set it in `/etc/fail2ban/jail.conf` to apply this to all jails:

```text
# vim /etc/fail2ban/jail.d/defaults-debian.conf
```

And add the line with `backend`:
```conf
[sshd]
enabled = true
backend = systemd
```

Now, restart `fail2ban` and check its status:
```text
# systemctl restart fail2ban
# systemctl status fail2ban
● fail2ban.service - Fail2Ban Service
     Loaded: loaded (/lib/systemd/system/fail2ban.service; enabled; preset: enabled)
     Active: active (running) since Wed 2025-02-05 19:52:34 UTC; 9min ago
       Docs: man:fail2ban(1)
   Main PID: 8041 (fail2ban-server)
      Tasks: 5 (limit: 1107)
     Memory: 16.3M
        CPU: 458ms
     CGroup: /system.slice/fail2ban.service
             └─8041 /usr/bin/python3 /usr/bin/fail2ban-server -xf start

systemd[1]: Started fail2ban.service - Fail2Ban Service.
..
fail2ban-server[8041]: Server ready
```

Finally, check `fail2ban` itself to see that the `sshd` jail is
working:

```text
# fail2ban-client status sshd
Status for the jail: sshd
|- Filter
|  |- Currently failed:	0
|  |- Total failed:	0
|  `- Journal matches:	_SYSTEMD_UNIT=sshd.service + _COMM=sshd
`- Actions
   |- Currently banned:	0
   |- Total banned:	0
   `- Banned IP list:	
```

As you can see, `fail2ban` is keeping tabs on failed ssh login
attempts and will put failed IPs in jail. Happy banning!
