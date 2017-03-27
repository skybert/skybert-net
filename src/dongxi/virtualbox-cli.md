title: Controlling VirtualBox from the command line
date: 2017-03-27
category: unix
tags: unix, virtualbox

My virtual machine is called `centos`.

## Start a virtual machine
```
$ vboxmanage startvm centos --type headless 
```

## Restore a snapshot

Stop the machine if it's running, then restore a snapshot identified
either by its name or its ID. You can get both from issuing
`vboxmanage snapshot centos list`:

```text
$ vboxmanage controlvm centos poweroff
$ vboxmanage snapshot centos restore a927529c-60fd-47c2-af98-4a0d38eea642
```
