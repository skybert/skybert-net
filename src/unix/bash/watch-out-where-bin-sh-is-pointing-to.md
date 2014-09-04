title: Watch Out Where Bin Sh Is Pointing To
date:    2012-10-07
category: bash

I recently helped a fellow on a discussion forum who had
problems because his shell script failed:

    the-script.sh: 29: Syntax error: "(" unexpected


I suggested that his shebang,```#!/bin/sh``` was
pointing to <a
href="http://en.wikipedia.org/wiki/Debian_Almquist_shell">DASH</a>
instead of <a
href="http://en.wikipedia.org/wiki/Bash_(Unix_shell)">BASH</a>,
which indeed turned out to be the problem. I was then asked to
explain the difference between the two. Thinking of it, this
is quite confusing as```/bin/sh``` <em>used to</em>
always point on Linux sytems and I'll therefore explain it
here as well, with the hope that it'll enlighten some
frustratede BASH programmers out there :-)

## My explanation to the above error message

&ldquo;The language you have used to program your script is BASH (see
<a href="http://linux.die.net/man/1/bash">man bash</a>),
whereas the program you ask the OS to interpret your script
through (you can think of the interpretre as the equivalent of
a compiler if you're used to languages such as C and Java), is
DASH, which is a different language.


Both BASH and DASH inherit from the old Bourne shell (SH), but
BASH is far more powerful, both as a shell and as a
programming language. DASH is a much more light weight shell
which is chosen as the default on Debian based operating
systems (including Ubuntu) because it consumes less system
resources.


This is why the link```/bin/sh``` points to
```/bin/dash``` and not
```/bin/bash```. If you
want to make the OS interpret your script as a BASH script,
you must therefore add```/bin/bash``` to the
interpreter header. Even better is defining it as:

    #! /usr/bin/env bash


That way, the OS will find BASH independent of where on the
file system it is installed. On most Linux distributions it's
usually installed under
``````/bin/bash``````,
though. Still using```#! /usr/bin/env``` is a good
habit for all interpreted languages such as bash, python and
perl.&rdquo;

