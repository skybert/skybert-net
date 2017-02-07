title: Declaring Variables with Type Safety in BASH
date: 2017-01-27
category: bash
tags: bash

Contrary to popular belief, BASH has some type safety if you declare
your variables with `typeset` or `declare`.

## Rant

These two BASH builtins, `typeset` and `declare` are synonyms, but
since `typeset` also works in Korn Shell (`ksh`) I use that keyword to
make my code a bit more portable. Perhaps silly since I also advocate
writing pure BASH and not worry about following the POSIX Utilities
spec as BASH is such a much richer language than `sh` and it's
available on all platforms I care about these days. In any case,
onwards:

## Integers

```bash
typeset -i age=20
printf "Age is %s\n" "${age}"
typeset -i age=foo
printf "Age is %s\n" "${age}"
typeset -i age=85
printf "Age is %s\n" "${age}"
```

Running this produces:
```text
$ ./declaring-variables.sh 
Age is 20
Age is 0
Age is 85
```

As you can see, BASH guarantees that the variable stays an integer
even if some piece of code assigns a string to it.

## Lowercase string

```bash
typeset -l always_lowercase=FOO
```

BASH guarantees that all strings written to this variable are stored
as lowercase:

```bash
$ echo "${always_lowercase}"
foo
```

## Uppercase string

```bash
typeset -u always_uppercase=bar
```

BASH guarantees that all strings written to this variable are stored
as uppercase:

```bash
$ echo "${always_uppercase}"
BAR
```

## Arrays

As you probably already know, you declare arrays with `declare -a` or
`typeset -a`. What you may not know, is that you can also make the
variable a constant, making modifications of this variable a runtime
error:

```bash
typeset -a -r COMPASS=(
  "north"
  "west"
  "south"
  "east"
)

for direction in "${COMPASS[@]}"; do
  printf "%s\n" "${direction}"
done

COMPASS=(
  "down"
  "up"
  "nowhere"
  "somewhere"
)

for direction in "${COMPASS[@]}"; do
  printf "%s\n" "${direction}"
done
```

Running this produces:

```text
$ ./declaring-variables.sh 
north
west
south
east
declaring-variables.sh: line 25: COMPASS: readonly variable
```

I bet you didn't know BASH had these features, I for sure didn't! 😉
