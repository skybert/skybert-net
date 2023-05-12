title: Why is there no python command?
date: 2023-05-12
category: python
tags: python, ubuntu, linux

## Problem
I have a Python script with this shebang:
```text
#! /usr/bin/env python
```

However, when I run it, I get this error:

```text
/usr/bin/env: 'python': No such file or directory
```

How come? This used to work!

## Reason

From Debian 11 (bullseye) and its derivatives, like ubuntu 20.04 LTS,
none of the package Python scripts use `#! /usr/bin/python`, but
either `#!  /usr/bin/python2` or `#! /usr/bin/python3`. Thus, neither
the `python2` package nor the `python3` package create such a binary
or symlink.

## Solution

You can either create the symlink yourself:

```text
# ln -s /usr/bin/python3 /usr/bin/python
```

or install [a package that creates the symlink for
you](https://packages.debian.org/bullseye/python-is-python3):

```text
# apt-get install python-is-python3
```

Note, in Debian 11 and Ubuntu 20.04 there was also a
[python-is-python2](https://packages.debian.org/bullseye/python-is-python2),
but this will be removed in the upcoming Debian 12 (bookworm) and thus
in Ubuntu 22.04 LTS.

## Closing remarks
You should really change your shebangs to use `python2` or `python3`
since there are significant differences between the two. And of
course, if you are *still* using `python2`, you should consider
migrating to `python3`, the command `2to3` will give you a good
starting point.

Happy coding!
