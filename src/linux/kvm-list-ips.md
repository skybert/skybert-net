title: List IPs of the KVM VMs
date: 2023-04-11
category: linux
tags: linux, kvm, virtualization


First, find the name(s) of the KVM network. By default this is
`default`:

```text
$ virsh net-list
 Name      State    Autostart   Persistent
--------------------------------------------
 default   active   yes         yes
```

Then, list the IP addresses of the VMs using that network:

```text
$ virsh net-dhcp-leases default
 Expiry Time           MAC address         Protocol   IP address           Hostname   Client ID or DUID
------------------------------------------------------------------------------------------------------------------------------------------------
 2023-04-11 11:44:02   52:54:00:5d:97:ab   ipv4       192.168.122.151/24   debbie     ff:00:5d:97:ab:00:01:00:01:29:71:6a:0e:52:54:00:65:9a:7f
```

Note, the name listed is not the VM name, but the hostname the OS
inside the VM reports.
