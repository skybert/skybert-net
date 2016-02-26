# Test Driven Development in BASH

> A talk by <a href="">torstein @ escenic</a>

---

# Why unit tests?

---

## confirm
that you've actually fixed the bug

---

## add
new features without breaking old

---

## re-factor
with confidence

---

## promotes
modular, de-coupled code

---

## TDD makes
you think about the user

---

# How a shell script starts

---

## just
a few lines

---

## and add some
variables

---

## hang on
perhaps it takes a parameter?

---

## wait a minute
could it make eggs too?

---

## of course
I want logging

---

## and make sure
it runs as the correct user

---

# Code structure
- bin
- lib
- test

---

## example - The add-two command
```
bin/add-two
lib/add-two-lib.sh
test/add-two-test.sh
```

---

## xunit

---

### write
your own

---

### what's out there

---

#### shunit2

```sh
assertEquals
assertFalse
assertNotEquals
assertNotNull
assertNotSame
assertNull
assertSame
assertTrue
fail
failNotEquals
failNotSame
failSame
```

---

```sh
## @override shunit2
setUp() {
  source "$(dirname "$0")/../lib/$(basename "$0" -test.sh)-lib.sh"
}

## @override shunit2
tearDown() {
  :
}

test_add_2_to_3_yields_5() {
  local expected=5
  local actual=
  actual=$(add_two 3)
  assertEquals "${expected}" "${actual}"
}
```

---

## Seeing is believing

Check out source at <a
href="https://gitlab.com/skybert/gone">https://gitlab.com/skybert/gone</a>

---

### CI on Jenkis

<img src="tdd-bash-ci-jenkins.png"
     alt="tdd-bash-ci-jenkins"
     title="BASH CI on Jenkins"/>

---
