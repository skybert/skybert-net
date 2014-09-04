title: Serious Programming in BASH
date:    2013-09-23
category: bash

Most people use BASH scripting as a quick and dirty way of
doing things, often nothing more than a listing of commands
with some variable substitution. Some brave soles go further
and add for loops and perhaps group some code into a
function.


However, BASH can do <em>so</em> much more, it's possible to
create structured, complex and beautiful BASH programs if you
utilise some of BASH hidden powers as a programming
language. Below, I give some of useful tips which should boost
your BASH scripts onto the next level.


- <a href="strings">String manipulation</a>

- <a href="functions">Using functions</a>

- <a href="loops">Looping through lists with and without indexes</a>

- <a href="variables">Variables, local and global.</a>

- <a href="arrays">Arrays</a>

- <a href="dictionaries">Using dictionaries, also known as hash
maps</a>

- <a href="exit-hooks">Writing your own program exit hooks</a>

- <a href="how-to-improve-performance"> Significantly improve the
performance of your BASH scripts </a>


## Arithmetics using floating point numbers

BASH supports floating point numbers internally, but you need
to pipe the output to```bc``` to display it properly,
i.e.:

    $ echo 10 / 3 | bc -l
    3.33333333333333333333


If you, like me, think two decimals looks nicer, you must add
this string (yes, it looks a bit funny):

    $ echo "scale=2;" 10 / 3 | bc -l
    3.33

## Getting the call trace

BASH gives you full control over the call stack inside your
programs. Here is a method which prints the call trace:

    function print_call_trace()
    {
      # skipping i=0 as this is print_call_trace itself
      for ((i = 1; i < ${#FUNCNAME[@]}; i++)); do
        echo -n  ${BASH_SOURCE[$i]}:${BASH_LINENO[$i-1]}:${FUNCNAME[$i]}"(): "
        sed -n "${BASH_LINENO[$i-1]}p" $0
      done
    }


Now, if we use it to track the call stack in this wee program
were two methods call eachother:

    function one()
    {
      two "with some argument";
    }

    function two()
    {
      print_call_trace "something went wrong"
    }

    one "a nice start paramater=" /tmp

We get the following call stack:

```
myscript.sh:17:two():   print_call_trace "something went wrong"
myscript.sh:12:one():   two "with some argument";
myscript.sh:20:main(): one "a nice start paramater=" /tmp
```

This makes debugging your hundreds of lines of BASH scripts a
doodle, right? ;-)

## Getting auto completion and source code navigation

If you're an Emacs user, I cannot recommend enough that you
use <a
href="http://cx4a.org/software/auto-complete/">auto-complete-mode</a>
for completion of member variables and method names and <a
href="/emacs/navigating-source-code/">etags for navigating
your source code</a>. Using etags, there's no problem
navigating a BASH project consisting of hundreds of BASH in
many different directories.

## Variable assignment with default values

BASH is extremely flexible with regards to assigning value to
a variable if a given variable is set, letting you fall back
to a default value if not. Where BASH really rocks, though, is
that it allows you to have a default/fallback value on the
default/fallback value!


Consider:


apple=apple
orange=orange
fruit=${apple-${orange}}

=>
apple



Now, if we comment out the apple variable so that it's not set,
we instead get:


    apple=apple
    orange=orange
    fruit=${apple-${orange}}

    =>
    orange



Now, let's put a fallback value on the fallback value:

    apple=apple
    orange=orange
    banana=banana
    fruit=${apple-${orange-${banana}}}

    =>
    banana



Pretty cool, eh?

## Debugging

If find for the most part, that running bash with the
```-x``` switch is the best way of debugging a script:

    $ bash -x my-bash-script

## How to grep from standard error

Sometimes, you want to operate on the messages sent to
standard error (for instance grep for a certain error
code). To do this, you must re-map the standard out and
standard error:


    $ command-with-error 2>&1 | grep "Error code"


One use case for this, is if you want to grep the output from
the```java -version``` command. For some reason, this
non error output is printed to standard error instead of
standard out (!):


    $ java -version 2>&1 | grep version
    java version "1.6.0_31"

## return true;

There, I hope I've managed to encourage you to approach BASH
programming with fresh eyes and a new perspective. The <a
href="http://tldp.org/LDP/abs/html/">Advanced Bash-Scripting Guide</a>
is a primer on the subject and a good choice for further reading. I've
also found great joy in reading <a
href="http://steve-parker.org/sh/bourne.shtml">Steve Bourne's classic
from 1978</a> as well as <a href="http://cfajohnson.com/shell/">Chris
F. A. Johnson's blog</a>


Happy BASHing!

