title: Pass BASH arrays by reference
date: 2021-01-04
category: bash
tags: bash, unix, linux

Today, I learned that you can pass arrays by reference in bash (like
you'd do in e.g. Java or Python)

There's one caveat, though. Any changes foo() makes to its local array
variable, is reflected in code also reading this variable, so passing
arrays by reference "makes" the variable global.

```bash
#! /usr/bin/env bash

## $1 :: name, passed by value
## $2 :: array, passed by reference
foo() {
  local name=$1
  local -n _array=$2

  printf "${FUNCNAME[0]} Pass by val, name: %s\\n" "${name}"
  local el=
  for el in "${_array[@]}"; do
    printf "${FUNCNAME[0]} Pass by ref, array el: %s\\n" "${el}"
  done

  _array=(baz)
}

main() {
  local _my_array=(0 one two three 4)
  foo "bar" _my_array

  for el in "${_my_array[@]}"; do
    printf "${FUNCNAME[0]} array el: %s\\n" "${el}"
  done
}

main "$@"
```


### Output of the above snippet

```text
foo Pass by val, name: bar
foo Pass by ref, array el: 0
foo Pass by ref, array el: one
foo Pass by ref, array el: two
foo Pass by ref, array el: three
foo Pass by ref, array el: 4
main array el: baz
```

As you can see, `foo()` manipulated the local variable `_my_arrray` in
`main()`.
