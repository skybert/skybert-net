date:    2012-10-07
category: unix
title: Hardening Your SSH Server
tags: ssh, security

Here are some steps I recommend everyone doing when setting up
a server which is reachable on the internet. Below each point,
I list an example configuration applicable to Debian based
systems. These settings, however, may apply to any Unix or
Linux system, though, you just must make sure the paths
correspond to your system.

## Run it on a non standard port

This will make your server not show up in standard/shallow <a
href="http://nmap.org">nmap</a> scans and thus make script
kiddies move on to another server to attack than yours. Of
course, your server is still findable (and attackable), but it
requires just that more effort from the attacker's side, so a
lot of them will move on elsewhere if they're not destined to
targert <strong>you</strong>.

    # /etc/ssh/sshd_config

    Port 9900

## Do not allow root logins

I never stop being amazed of how many production systems that
runs with with this setting enabled.

    # /etc/ssh/sshd_config

    PermitRootLogin no

## Do not allow password logins

Password logins have two problems. One, people tend to use
insecure passwords, or are too bothered changing them
regularly. Secondly, every time the person logs on to your
server, he/she is at the risk of a key logger snatching the
password.


Instead, insist on using keys for logging on to your
server. Only clients having their public key in the
corresponding```.ssh/authorized_keys``` can log in to
your server.

    # /etc/ssh/sshd_config

    PasswordAuthentication no
    RSAAuthentication yes
    PubkeyAuthentication yes


## Only accept SSHv2

I believe this is standard on all new systems these days, but
just confirm that you do <em>not</em> accept SSHv1 connections
as these are not considered secure anymore.

    # /etc/ssh/sshd_config

    Protocol 2

## Put Clients That Fail a Log In in Jail

I recommend using <a href="http://fail2ban.org">fail2ban</a>
or similar for putting clients in jail for e.g. five minutes
every when they fail a couple of login attemts. This makes
brute force attacks so a lot more difficult.

    # vim /etc/fail2bain/jail.conf

And configure the ssh section like:

    [ssh]

    enabled = true
    port    = 9900
    filter  = sshd
    logpath  = /var/log/auth.log
    maxretry = 6



