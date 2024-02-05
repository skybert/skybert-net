title: RedHat Shit List
date: 2017-03-20
category: linux
tags: linux, redhat

## rpm doesn't accept wildcards

You can't remove multiple packages matching a certain criteria:

```text
# rpm -e escenic-*
```

Should remove all packages starting with `escenic-`, but it does not:

```text
# rpm -e escenic-*
error: package escenic-* is not installed
```

Thus, you must succumb to writing a `while` loop to get all those
packages removed:

```text
# rpm -qa | grep ^escenic- | while read p ; do rpm -e $p; done
```

## rpm packages can't contain common directories

DEB files can define directories, but the one-package-one-file is only
enforced on file level, not on directory level. This means that if
your package provides `/etc/foo`, the package can contain the `/etc `
directory without any problem on a DEB system. On an RPM system,
however, the package can't contain `/etc`.

You typically encounter this when you use `alien` to convert a DEB to
an RPM file. To fix it, you must first generate the `.spec` file, then
edit it (scripted or not) and then build your RPM.
