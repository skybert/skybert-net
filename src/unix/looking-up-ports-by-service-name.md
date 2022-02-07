title: Looking up Ports by Service Name
date: 2022-02-07
category: unix
tags: unix, linux

If wonder what ports are the default for a given service, you can look
them up by inspecting the `/etc/services` file which is present on
most Unix systems, including macOS. E.g. if you wonder which port is
the default for `SSH`, you can do:

```text
$ grep -w ssh /etc/services 
ssh                22/tcp
ssh                22/udp
ssh                22/sctp
..
```

The other way works too. Say you wonder which services are related to
`389` and `636`, you can do:

```text
$ egrep -w '389|636' /etc/services 
ldap              389/tcp
ldap              389/udp
ldaps             636/tcp
ldaps             636/udp
```

I find having `/etc/services` at my fingertips extremely useful, hope
you do too!
