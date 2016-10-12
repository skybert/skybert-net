title: Scoping in BASH
date: 2016-09-30
category: bash
tags: bash, unix


## Callees inherit local variables

```bash
#! /usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
shopt -s nullglob

print() {
  echo $(basename $0):${BASH_LINENO[0]}:${FUNCNAME[1]}"()" "$*"
}

other_method() {
  print "I can read cache_dir=${cache_dir}"
}

main() {
  local cache_dir=/var/cache
  print "I have set cache_dir=${cache_dir}"
  print "Now calling other_method()"
  other_method
}


main "$@"
echo "$0 root here, now calling other_method"
other_method
```

Can you guess the output? I was very surprised the first time I saw
this:

```
$ ./scoping-test.sh 
scoping-test.sh:21:main() I have set cache_dir=/var/cache
scoping-test.sh:22:main() Now calling other_method()
scoping-test.sh:16:other_method() I can read cache_dir=/var/cache
scoping-test.sh root here, now calling other_method
scoping-test.sh: line 16: cache_dir: unbound variable
```
