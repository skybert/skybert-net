title: Awesome print function
date: 2016-03-31
category: bash
tags: unix, bash, java, logging

This little gem here will print the method and line number from which
the printing statement is made, giving you as developer or operator
much more valuable debugging output.

The gem is:

```bash
print() {
  echo $(basename $0):${BASH_LINENO[0]}:${FUNCNAME[1]}"()" "$*"
}
```

It starts of by outputting the script that is executed using the
familiar `$(basename $0)` construct. Then on to the exciting part: The
first element of the `BASH_LINENO` array will contain the line number
and the second element in the `FUNCNAME` array will hold the calling
method. The `$*` simply outputs all the arguments that are passed to
the `print()` method.

Here's a demo application which checks out some source, compoiles it
and starts a dev server, providing the user with information as it
goes along:

```bash
#! /usr/bin/env bash

print() {
  echo $(basename $0):${BASH_LINENO[0]}:${FUNCNAME[1]}"()" "$*"
}

checkout_source() {
  print "Checking out $1 ..."
}

compile_source() {
  print "Compiling source in $1 ..."
}

start_dev_server() {
  print "Starting dev server on port $1 ..."
}

main() {
  checkout_source https://github.com/eclipse/che.git
  compile_source che
  start_dev_server 8080
}

main "$@"
```

Running this command will give you both debug messges and trace of
exactly from which file, line number and method they are being issued:

```bash
$ callee-test.sh
callee-test.sh:17:checkout_source() Checking out https://github.com/eclipse/che.git ...
callee-test.sh:21:compile_source() Compiling source in che ...
callee-test.sh:25:start_dev_server() Starting dev server on port 8080 ...
```

If you're running this in something like the Emacs compile buffer, you
can even click on the logging statements to jump to the source code
where they are issued.

Pretty cool, eh?

## What about Java?

Interestingly, Java also has a way to do this. AFAIK, log4j and other
logging frameworks don't use it, but you can:

```java
private static void print(final String pMessage) {
  System.out.println(
      Thread.currentThread().getStackTrace()[2].getFileName() + ":" +
      Thread.currentThread().getStackTrace()[2].getLineNumber() + ":" +
      Thread.currentThread().getStackTrace()[2].getMethodName() + "() " +
      pMessage);
}
```
