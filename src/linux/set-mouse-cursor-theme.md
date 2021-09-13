title: Set mouse cursor theme
date: 2021-07-30
category: linux
tags: linux, x

Get a list of all valid cursor theme names:
```bash
find /usr/share/icons -name cursors | 
  while read d; do sed -rn 's#Name = (.*)#\1#p' $(dirname $d)/index.theme; done |
  sort -u
```

Try it out with:
```text

```

