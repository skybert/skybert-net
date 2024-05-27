title: Clearing the Arch Package Cache
date: 2024-05-27
category: linux
tags: arch

Just like on Debian, Arch will not clear its package cache:

```text
$ du -hs /var/cache/pacman/pkg/
103G	/var/cache/pacman/pkg/
```

Just like you can clear it with `apt-get clean` on Debian, you can do:
```text
# pacman -Scc
```

However, if you only pass it `-Sc`, it'll only remove the package
versions you _don't_ have installed:

```
[root@quanah ~]# pacman -Sc
Packages to keep:
  All locally installed packages

Cache directory: /var/cache/pacman/pkg/
:: Do you want to remove all other packages from cache? [Y/n]
```

Adding the second `c` makes it remove those archives too.

Happy cleaning!
