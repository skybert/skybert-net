title: Delete Files Created Before Date
date: 2022-10-27
category: linux
tags: linux

Say you want to delete files in `/var/lib/files` created before `2022-01-01`:

```text
$ touch --date "2022-01-01" /tmp/from
$ find /var/lib/files -type f -not -newer /tmp/from -delete
```

## Delete friles between a from and to date

Say you want to delete files only created created in `2020`:

```text
$ touch --date "2020-01-01" /tmp/from
$ touch --date "2021-01-01" /tmp/to
$ find /var/lib/files -type f -newer /tmp/from -not -newer /tmp/to -delete
```

