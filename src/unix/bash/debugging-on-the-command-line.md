title: Debugging BASH scripts on the command line
date: 2016-12-28
category: bash
tags: bash, unix

## tl;dr

Get detailed debugging information about `your-commnad.sh` by setting
the `PS4` variable like the one below and then running `bash -x
your-command.sh`.

```
export PS4='# ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]}() - [${SHLVL},${BASH_SUBSHELL},$?] '
```

## In depth

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

The trick is to set an environment variable to instruct `bash` go give
you the information you want. The xtrace format is governed by the
`PS4` variable. Here's what I've got in my `~/.bashrc`:

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

Each line that's evaluated by the `bash` interpreter is printed first
with the full path to the source file, followed by line number and
`function`. Then there are three numbers: number of instances of the
`bash` interpreter, number of subshells (a `function` is a subshell
too) and the exit code of the previous command. Finally, the BASH
statement is printed. For further information see `main bash`.

Notice that `bash` will take the first character of `PS4` and add it
once more for each consecutive sub shell. Since I have `#` as the
first character of `PS4`, I can see the call depth by counting the
number of `#`s.

<img
  src="/graphics/2016/2016-12-29-emacs-bash-cli-debugging.png"
  alt="bash cli debugging in emacs"
  class="centered"
/>  

Running this from within an `emacs` compile buffer, each line is
clickable (Emacs just ignores the leading `#`s), taking you to the
right line in the right script file. You can also keep hitting
<kbd>Ctrl</kbd> + <kbd>`</kbd> to step through each line of your
program. Pretty neat, eh?

## Inspect sub processes of a running BASH program

You can inspect what any running BASH program, regardless of it
running in the above mentioned debug mode, by using `pstree`. For
this, get a hold of the PID of your program, e.g. by doing `ps aux |
grep -w bash`, then pass it as the argument to the `pstree` command:

```
~ $ pstree -p -a 17693
bash,17693 /usr/local/bin/che 6.2.0-4
  └─bash,17698 /usr/local/bin/che 6.2.0-4
      └─wget,17699 --continue --quiet --http-user foo --http-password bar https://maven.example.com/com/example/app/6.2.0-4/app-6.2.0-4.zip
```

See `man pstree` for more information on what `pstree` can do for you.

Happy debugging!
