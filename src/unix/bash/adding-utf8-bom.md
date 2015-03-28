title: Adding UTF-8 BOM from the command line
category: bash
tags: unix, bash, sed, utf-8, encoding
date: 2015-03-16

```
$ sed -i '1s/^/\xef\xbb\xbf/' file-encoded-with-utf8.txt
```
