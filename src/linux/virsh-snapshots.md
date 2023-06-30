title: KVM snapshots using virsh
date: 2023-06-30
category: linux
tags: linux, kvm, virtualization

## Create snapshot of your VM

To take a complete snapshot of the VM called `ece7`, do:

```text
$ virsh shutdown ece7
$ virsh snapshot-create-as --domain ece7 --name ece7-full-stack-working
```

## Restore your VM to a previous snapshot

To restore it, do:

```text
$ virsh shutdown ece7
$ virsh snapshot-revert --domain ece7
$ virsh start ece7
```

## List all snapshots of a given VM

To list all snapshots available for your VM, do:

```text
$ virsh snapshot-list --domain ece7
Name                      Creation Time               State
----------------------------------------------------------------
ece7-full-stack-working   2023-06-30 13:44:48 +0200   shutoff
```




