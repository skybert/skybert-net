title: virt-manager and virsh say network is not active
date: 2022-11-09
category: linux
tags: linux
    
    
```text
$ virsh start ece-install-tester
error: Failed to start domain 'ece-install-tester'
error: Requested operation is not valid: network 'default' is not active
```


```text
# virsh net-autostart --network default
Network default marked as autostarted
```


```text
# virsh net-start default
Network default started
```

```text
# virsh net-list --all
 Name      State    Autostart   Persistent
--------------------------------------------
 default   active   yes         yes
```

    
