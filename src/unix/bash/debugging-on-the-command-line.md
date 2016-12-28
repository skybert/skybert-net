title: Debugging BASH scripts on the command line
date: 2016-12-28
category: bash
tags: bash, unix

Say you've got this `my-command.sh`:

```bash
#! /usr/bin/env bash

source my-math-library.sh
add_one "$(add_two "$1")"
```

It imports `my-math-library.sh` which looks like this:
```bash
add_one() {
  echo $(($1 + 1))
}

add_two() {
  echo $(($1 + 2))
}
```

Running `my-command.sh` yields just the result:
```
$ my-command.sh 1
4
```

To see see exactly how `my-command.sh` arrived at that result you can
start the script with `bash -x`:
```
$ bash -x my-command.sh 1
+ source my-math-library.sh
++ add_two 1
++ echo 3
+ add_one 3
+ echo 4
4
```

You can also turn this on inside your `my-command.sh` with:
```bash
set -o xtrace
```

Now you can see each of the steps the `bash` interpreter executed and
what the values of all the variables were at the given times. The
pluses in the left margin also gives you an indication of how deep the
call stack is (in fact, how many sub shells you're down from the main
shell) .

This debug trace log is great, but it has a couple of shortcomings:
You don't see in which `.sh` the statements come from and you don't
see the line number on which the statements are written. Furthermore,
it's hard to see in which method a statement is written and it would
also be nice to get a
watch on the status codes returned from each of the statements.  

When your scripts get bigger and hairer, you really want more of this
context. Luckily, BASH can give all of this to you and it's easy — if
you know how.

The trick is to an environment variable to instruct `bash` go give you
the information you want. The xtrace format is governed by the `PS4`
variable. Here's what I've got in my `~/.bashrc`:

```
export PS4='# ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]}() - [${SHLVL},${BASH_SUBSHELL},$?] '
```

With this, I get xtrace debug output like this:

```text
$ bash -x my-command.sh 1
# my-command.sh:3: main() - [4,0,0] source my-math-library.sh
## my-command.sh:4: main() - [4,1,0] add_two 1
## my-math-library.sh:6: add_two() - [4,1,0] echo 3
# my-command.sh:4: main() - [4,0,0] add_one 3
# my-math-library.sh:2: add_one() - [4,0,0] echo 4
4
```

Notice that `bash` will take the first character of `PS4` and add it
once more for each consecutive sub shell. Since I have `#` as the
first character of `PS4`, I can see the call depth by counting the
number of `#`s.

Running this from within an `emacs` compile buffer, each line is
clickable (Emacs just ignores the leading `#`s), taking me to the
right line in the right script file. Pretty neat, eh?

Happy debugging!
