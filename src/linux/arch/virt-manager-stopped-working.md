title: virt-manager stopped working after upgrade
date: 2022-04-05
category: linux
tags: arch, linux

Today, `virt-manager` refused to start any VM:

```text
Error starting domain: internal error: Failed to load module

'/usr/lib/libvirt/storage-file/libvirt_storage_file_fs.so':
/usr/lib/libvirt.so.0: version `LIBVIRT_PRIVATE_8.2.0'

not found (required by
/usr/lib/libvirt/storage-file/libvirt_storage_file_fs.so)
```

It turned out it was because `libvirt` was upgraded and it didn't restart its deamon:
```text
$ grep -w libvirt /var/log/pacman.log
[2022-04-04T09:37:24+0200] [ALPM] upgraded libvirt (1:8.1.0-4 -> 1:8.2.0-3)
```
      
To fix this, I just restarted `libvirtd`:
```text
# systemctl restart libvirtd
```

With that wee restart, `virt-manager` couldn't start my VM again 🎉
