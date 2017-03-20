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

