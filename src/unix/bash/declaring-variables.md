title: Declaring Variables with Type Safety in BASH
date: 2017-01-27
category: bash
tags: bash

Contrary to popular belief, BASH has some type safety.

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
