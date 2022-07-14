title: How to see /etc files have been changed after installing the DEB
date: 2022-07-14
category: linux
tags: debian, linux, apt


DEB packages often contain configuration files installed under
`/etc`. To see if an admin has changed any package provided
configuration files, use the following command:


```bash
$ dpkg-query -W -f='${Conffiles}\n' '*' |
  awk 'OFS="  "{print $2,$1}' |
  md5sum -c 2>/dev/null |
  awk -F': ' '$2 !~ /OK/{print $1}'
```

Source: https://serverfault.com/a/90401
