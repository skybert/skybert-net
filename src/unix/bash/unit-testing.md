title: Unit testing
date:    2012-10-07
category: bash
tags: bash, testing

> What?!! Unit testing in BASH? You must be kidding!

I can hear you say. However, unit testing your BASH code is not only
possible, but straight out useful when your code grows and you want to
limit regression bugs while adding new features.


I've written a simple <a
href="https://github.com/skybert/my-little-friends/blob/master/bash/common/bash_unit">
BASH unit test library</a> which you can use like this, following the
same construct of ```message, expected, actual``` parameters as <a
href="http://junit.org">JUnit</a> uses:

```bash
source /path/to/bash_unit

assert_equals "The fruit is wrong" "apples" "oranges"
assert_equals "One and one is two" 2 $(( 1 + 2 ))
assert_equals "One and one is two" 2 "three"
```

```bash_unit``` will output errors on the above tests:

```
FAILED: The fruit is wrong: Expected <apples>, but was <oranges>
FAILED: One and one is two: Expected <2>, but was <3>
FAILED: One and one is two: Expected <2>, but was <three>
```

As you can see,```bash_unit``` supports strings and integers.

If you'd like to view the positives, you set the ```show_positives```
variable to ```1```:

```
show_positives=1
assert_equals "The fruit is wrong" "apples" "apples"
assert_equals "One and one is two" 2 $(( 1 + 1 ))
assert_equals "One and one is two" 2 2
```

Which then produces:

```
PASSED: The fruit is wrong: Expected <apples> and got <apples>
PASSED: One and one is two: Expected <2> and got <2>
PASSED: One and one is two: Expected <2> and got <2>
```

Happy unit testing!

## Note

After writing this library and living happily with it for a long time,
I discovered [shunit2](https://github.com/kward/shunit2) and have used
it successfully the last couple of years.
