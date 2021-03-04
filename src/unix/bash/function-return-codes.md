title: Function return codes
date: 2021-03-04
category: bash
tags: bash, unix

In a bash function, return will return the status code of the previous
command. For many years, I thought it returned the default status,
i.e. `0`, but it does not.

```bash
foo() {
  ls /does/not/exist
  return
}

foo || {
  printf "Function 'foo' failed" 
}
```

So if you want `foo` to return `0`/success even when the `ls
/does/not/exist` fails, you must be explicit:

```bash
foo() {
  ls /does/not/exist
  return 0
}
```

Wish I'd learned about this sooner (took me around 22 years of bash
coding).
