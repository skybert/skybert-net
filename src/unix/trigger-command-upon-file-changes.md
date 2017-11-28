title: Trigger Command Upon File Changes
date: 2017-11-17
category: unix
tags: unix, testing, bash

I've recently experimented with having tests triggered automatically
whenever I change a particular file. I found this to significantly
improve my workflow. Instead of making a code change and then hitting
a shortcut (or typing a command) to run a unit test to verify that my
code change did what it was supposed to do, the test runs
automatically as soon as I press save in my editor.

I resisted the temptation of writing my own watcher using `stat` from
[GNU Coreutils](https://www.gnu.org/software/coreutils/coreutils.html)
and used
[inotify](http://man7.org/linux/man-pages/man7/inotify.7.html) and
[entr](http://man7.org/linux/man-pages/man7/inotify.7.html). Both
`inotify` and `entr` are so fast, even on large code bases, that I
have them watch whole modules in my Java project.

The first watcher I used was `inotify`:

```bash
$ inotifywait -q -m -e close_write -r ~/src/foo/foo-server/src |
  while read -r file event; do
    clear
    time mvn -o -q  -f
    ~/src/foo/foo-server/pom.xml test -Dtest=XMLTest*
  done
```

It worked great and the only real downside was that it's Linux
specific. `entr` on the other hand, runs on Linux, macOS, FreeBSD and
OpenBSD alike. Moreover, its syntax is simpler than `entr`, so it has
become my preferred file watcher:

```
$ find ~/src/foo/foo-server/src | 
  entr -c -p time mvn -o -q -f  ~/src/foo/foo-server/pom.xml test -Dtest=XMLTest*
```

## Running a selected set of unit tests with Maven
While running this, I learned another thing: From before I knew that
`mvn` can run a single test by using a `#`:
```
$ mvn test -Dtest=MyTestClass#oneTest`
```

But what if you want to run multiple tests or test classes? It's easy,
you just add a comma: 

```
$ mvn test -Dtest=MyTestClass,MyOtherTestClass`
```

As an added bonus `mvn` (or Surefire to be precise), support
wildcards, so you can do:

```
$ mvn test -Dtest=My*
```

to run both `MyTestClass` and `MyOtherTestClass`. Clever, eh?

Happy coding!
