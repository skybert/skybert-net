title: My old notes on KVM
date:    2011-01-23
category: linux
tags: kvm, virtualisation, debian

> These are more old notes on using KVM on Debian, written
> around 2011. Please see [this page on kvm](kvm) for my most recent
> notes on KVM.

## Setting up bridged networking

Be aware that you probably cannot do this using a wireless card as
most of these don't support bridging. I had the problem that
everything looked right until I did ```ifup eth0``` on the virtual
guest. Then my host connection to the internet died.


When using wired network on the host machine, the following
configuration in```/etc/network/interfaces``` works well for me. Note
that I've set up a static IP for the guest here as this is what I need
for running this in production:

```
# The primary network interface
iface eth0 inet dhcp
      post-up /etc/init.d/firewall start
      post-up ifup br0

# bridge for kvm
iface br0 inet static
      address 192.168.1.110
      network 192.168.1.0
      netmask 255.255.255.0
      broadcast 192.168.1.255
      gateway 192.168.1.1
      bridge_ports eth0
      bridge_stp off
      bridge_fd 0
      bridge_maxwait 0
      post-up sysctl -p /etc/sysctl.conf

```

The lines I've added to```/etc/sysctl.conf``` to get
it working with the KVM guests is:

```
# for KVM guests
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
```

## kvm quits, just saying "Aborted"

Running```strace -f``` in front of the ```kvm``` command showed that
it couldn't allocate the memory:

    # strace -f kvm  -net nic -net tap -m 1024 my.img
    [pid  8260] mmap(NULL, 1073881088, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM (Cannot allocate memory)


This could be verified by looking at```free -m```, which yielded only
111MB free. Freeing up some memory so that ```kvm``` had the 1024 MB I
allocated for it, solved the problem.

## KVM fails to bring up the qemu window

This is one of those where the error message doesn't have
anything to do with the actual error:

```
# kvm \
  -net nic,macaddr=00:00:00:00:00:04 \
  -net tap \
  -m 1024 /opt/virtual/palantir.img \
  -cdrom /home/torstein/tmp/debian-6.0.3-amd64-netinst.iso \
  -boot d
[..]
~~~~~~~~~~~~~~~~~~~~~~~~~~| DirectFB 1.2.10 |~~~~~~~~~~~~~~~~~~~~~~~~~~
(c) 2001-2008  The world wide DirectFB Open Source Community
(c) 2000-2004  Convergence (integrated media) GmbH
----------------------------------------------------------------

(*) DirectFB/Core: Single Application Core. (2011-10-17 12:04)
(*) Direct/Memcpy: Using libc memcpy()
(!) Direct/Util: opening '/dev/fb0' and '/dev/fb/0' failed
--> No such file or directory
(!) DirectFB/FBDev: Error opening framebuffer device!
(!) DirectFB/FBDev: Use 'fbdev' option or set FRAMEBUFFER environment variable.
(!) DirectFB/Core: Could not initialize 'system_core' core!
--> Initialization error!
Could not initialize SDL - exiting
```

As the error message hints at, there's indeed no framebuffer device on
my box, for that I had to pass ```vga=something``` on the LILO/GRUB
kernel parameter line. However, what's more interesting to me, is
<em>why</em> it tries touse the frame buffer instead of the nice
window it usually pops up.


And the reason? It was because my root user didn't have access to the
local X session. Duh! Hence, simply doing:

    $ xhost +

in a normal user shell remedied it. Man! This bugger made me scratch
my head, I was even reading through the Linux kerenl documentation on
framebuffers :-)

## Another error message for the same reason

I've also discovered that this error message also has the same remedy:

    Invalid MIT-MAGIC-COOKIE-1 keyCould not initialize SDL

