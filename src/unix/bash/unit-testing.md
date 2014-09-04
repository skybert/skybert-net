title: Unit testing
date:    2012-10-07
category: bash

<cite>What?!! Unit testing in BASH? You must be
kidding!</cite> I can hear you say. However, unit testing your
BASH code is not only possible, but straight out useful when
your code grows and you want to limit regression bugs while
adding new features.


I've written a simple <a
href="https://github.com/skybert/my-little-friends/blob/master/bash/bash_unit">
BASH unit test library</a> which you can use like this,
following the same construct of
```message, expected,
actual``` parameters as <a
href="http://junit.org">JUnit</a> uses:


source /path/to/bash_unit

assert_equals "The fruit is wrong" "apples" "oranges"
assert_equals "One and one is two" 2 $(( 1 + 2 ))
assert_equals "One and one is two" 2 "three"



```bash_unit``` will output errors on the above tests:


FAILED: The fruit is wrong: Expected &lt;apples&gt;, but was &lt;oranges&gt;
FAILED: One and one is two: Expected &lt;2&gt;, but was &lt;3&gt;
FAILED: One and one is two: Expected &lt;2&gt;, but was &lt;three&gt;



As you can see,```bash_unit``` supports strings
and integers.


If you'd like to view the positives, you set the
```show_positives``` variable to
```1```:


show_positives=1
assert_equals "The fruit is wrong" "apples" "apples"
assert_equals "One and one is two" 2 $(( 1 + 1 ))
assert_equals "One and one is two" 2 2



Which then produces:


PASSED: The fruit is wrong: Expected &lt;apples&gt; and got &lt;apples&gt;
PASSED: One and one is two: Expected &lt;2&gt; and got &lt;2&gt;
PASSED: One and one is two: Expected &lt;2&gt; and got &lt;2&gt;



Happy unit testing!

