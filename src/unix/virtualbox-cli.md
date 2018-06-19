title: Controlling VirtualBox from the command line
date: 2017-03-27
category: unix
tags: unix, virtualbox

My virtual machine is called `centos`.

## List virtual machines

```
$ vboxmanage list vms
```

## Start a virtual machine

```
$ vboxmanage startvm centos --type headless
```

## List snapshots of a virtual machine

```
$ vboxmanage snapshot centos list
```

## Restore a snapshot

Stop the machine if it's running, then restore a snapshot identified
either by its name or its ID. You can get both from issuing
`vboxmanage snapshot centos list`:

```
$ vboxmanage controlvm centos poweroff
$ vboxmanage snapshot centos restore a927529c-60fd-47c2-af98-4a0d38eea642
```

