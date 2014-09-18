title: Exit hooks
date:    2012-11-23
category: bash

When you want to add a command or a function to be called whenever
your script ends (and you'd like it to be more error proof than
calling the method at the end of your script file, you can do it like
this:

```
#! /usr/bin/env bash

function my_exit_hook() {
  echo "Cleaning up after you"
}

trap my_exit_hook EXIT
```

Pretty cool, eh? You can read <a
href="http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_12_02.html">more
on traps here</a>.

