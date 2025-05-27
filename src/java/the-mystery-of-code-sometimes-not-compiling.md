title: The Mystery of Code Sometimes Not Compiling
date: 2025-05-07
category: java
tags: java, emacs

Java developers: If you're using the [Eclipse
LSP](https://projects.eclipse.org/projects/eclipse.jdt.ls) in your
editor and Maven on the command line, the former will cause problems
if you have annotation processors. Several editors use the Eclipse
LSP, including VS Code and Emacs.

If you're suffering from random errors with your Lombok, Protobuf or
other annotation processed magic beans, you can use this trick when
running `mvn` on the command line:

1. Pause Eclipse LSP processes: `pgrep -f org.eclipse.jdt.ls | xargs kill -STOP`
2. Run Maven as normal: `mvn install`
3. Resume Eclipse LSP processes: `pgrep -f org.eclipse.jdt.ls | xargs kill -CONT`

This took me a *long* time to figure out.

You can also put this in a shell alias, so you can just type `mci`
(short for `mvn clean install`):

```perl
alias mci="pgrep -f org.eclipse.jdt.ls |
  xargs kill -STOP ;
  mvn clean; mvn install ;
  pgrep -f org.eclipse.jdt.ls | xargs kill -CONT;
  xeyes"
```

Happy coding!
