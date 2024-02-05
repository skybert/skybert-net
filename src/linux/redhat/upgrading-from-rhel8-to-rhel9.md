title: Upgrading from RHEL8 to RHEL9
date: 2024-02-01
category: linux
tags: linux, redhat

## Install the leapp command

Note, `leapp` in itself isn't enough, you also need
`leapp-command(upgrade)`:

```text
# dnf install leapp 'leapp-command(upgrade)'
```


## Check if you can upgrade

```text
# leapp preupgrade
```

It'll output a summary of problems or things to look out for regarding
the upgrade. Be sure to read through it all. 

I had to make the following fixes before performing the upgrade:

```text
# sed -i s/^AllowZoneDrifting=.*/AllowZoneDrifting=no/ /etc/firewalld/firewalld.conf
# sed -i 's#PermitRootLogin yes#PermitRootLogin no#' /etc/ssh/sshd_config
```

## Perform the actual upgrade

```text
# leapp upgrade
```


## Reboot the system

```text
# reboot
```

## Select the new GRUB option to update the initramfs

RHEL has created an upgrade specific GRUB entry. It'll generate a new
`initramfs`, as well as upgading _loads_ of RPM packages.


## Verify that your update succeeded

```text
[torstein@rhel9 ~]$ grep PRETTY /etc/os-release 
PRETTY_NAME="Red Hat Enterprise Linux 9.3 (Plow)"
[torstein@rhel9 ~]$ uname -r
5.14.0-362.18.1.el9_3.x86_64
[torstein@rhel9 ~]$
```

As everyone knows, though, the _real_ test of a successful upgrade is
if you get the new RHEL 9 wallpaper when logging into GNOME, so here
you go: 😉

<img
  class="centered"
  src="/graphics/2024/rhel9-gnome.png"
  style="width: 1024px"
  alt="GNOME on RHEL9"
/>


