title: Inspecting the bits and bytes of a string
category: unix
date: 2015-11-05

```bash
$ echo -n "👻" | hexdump -C
00000000  f0 9f 91 bb                                       |....|
00000004
```
