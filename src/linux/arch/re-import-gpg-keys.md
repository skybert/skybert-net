title: Arch key could not be imported
date: 2024-05-27
category: linux
tags: arch

Got this error
```text
# pacman -S <package>
:: Import PGP key 45B429A8F9D9D22A, "Daurnimator <daurnimator@archlinux.org>"? [Y/n]
error: key "45B429A8F9D9D22A" could not be imported
error: required key missing from keyring
error: failed to commit transaction (unexpected error)
Errors occurred, no packages were upgraded.
```

So, I created backup of the old gnupg direcotry and moved it out of the way:
```text
[root@quanah ~]# mv /etc/pacman.d/gnupg /etc/pacman.d/$(date --iso)-gnupg
```

```text
[root@quanah ~]# pacman-key --init
gpg: checking the trustdb
gpg: [don't know]: invalid packet (ctb=00)
```

Found later out that resetting the keys was [documented on the Arch
wiki](https://wiki.archlinux.org/title/Pacman/Package_signing#Resetting_all_the_keys).
