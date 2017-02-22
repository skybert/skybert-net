title: Making Your BASH Programs Run Faster
date: 2017-02-16
category: bash
tags: unix, bash, performance


## Use BASH builtins whenever possible 

Forking out a sub process is expensive, therefore, try to use the
builtin features whenever possible. For instance, using the builtin
String manipulation features in BASH can save you many seconds (or
even minutes!) on your running time of larges BASH programs.

```bash
# This is slow
file_name=$(basename "${file}")

# This is fast
file_name=${file##*/}
```

```bash
# This is slow
dir=$(dirname "${file}")

# This is fast
dir=${file%/*}
```

With just these two enhancements, I reduced the running time of one
BASH program from over 8 minutes to under 4 minutes. More than twice
as fast!


