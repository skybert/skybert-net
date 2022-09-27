title: Getting two way clipboard between host and guest with virt-manager and Spice
date: 2022-09-27
category: linux
tags: linux, virtual, kvm


## Host

```text
host $ su -
host # pacman -S virt-manager
```

On the settings page for your virtual machine, ensure that you have a
channel for Spice (I got this automatically with the Arch
`virt-manager` package):

```text
Device type: spicevmc
Target type: virtio
Target name: com.redhat.spice.0
```



## Guest

```text
host  $ ssh guest
guest $ su -
guest # apt-get install spice-vdagent
guest # systemctl enable spice-vdagent
guest # systemctl start spice-vdagent
```


## Two way clipboard

That's it. I can now copy text from Firefox running in the virtual
machine and paste it into Chrome running on my host machine.
