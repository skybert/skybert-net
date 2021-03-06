date: 2018-09-11
category: emacs
tags: java, emacs
title: Enterprise Java Development in Emacs

<img class="right" src="/graphics/emacs/emacs.png" alt="png"/>

My [current Java
setup](https://gitlab.com/skybert/my-little-friends/blob/master/emacs/.emacs#L603)
utilises [lsp-java](https://github.com/emacs-lsp/lsp-java) and
[dap-java](https://github.com/yyoncho/dap-mode) which together gives
me a good Java coding and debugging experience in Emacs, including
code navigation, auto completion, documentation lookup, on the fly
de-compiling 3rd party libraries and remote debugging an application
servers.

Everything works pretty much out of the box, once you've wired up
`lsp-java` and `dap-java`, it'll figure out your Maven project by
itself and download whatever it needs in the background. I've used
this setup for a good while now on a code base with around 5000 Java
files and 65 Maven modules and the performance is impeccable.

You can see my setup in action in the screencast below.

<iframe class="centered" width="560" height="315" src="https://www.youtube-nocookie.com/embed/4z2Ywregkig" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" class="centered" allowfullscreen="true"> </iframe>


## Support for Lombok

```lisp
(setq lsp-java-vmargs
      (list
         "-noverify"
         "-Xmx1G"
         "-XX:+UseG1GC"
         "-XX:+UseStringDeduplication"
         "-javaagent:/path/to/lombok-1.18.6.jar"))
```

## Trouble shooting

If `lsp-java` doesn't work, a good place to start is to look in the
Eclipse server log file:
```text
$ tail -f ~/.emacs.d/workspace/.metadata/.log
```

### java.lang.NoSuchMethodError: java.nio.ByteBuffer.limit(I)Ljava/nio/ByteBuffer;

You need to make the language server use Java 9 and it must be
OpenJDK:

```lisp
(setq lsp-java-java-path
      "/usr/lib/jvm/java-9-openjdk-amd64/bin/java")
```
See [this ticket over at
jira.mongodb.org](https://jira.mongodb.org/browse/JAVA-2559) for a
good explanation of why these errors happen


### java.security.InvalidAlgorithmParameterException

```text
java.security.InvalidAlgorithmParameterException: the
trustAnchors parameter must be non-empty
```

The easiest solution is to just use OpenJDK instead of Oracle Java to
run the Eclipse server (I just did `apt-get install
openjdk-9-jdk`), you can set this in your `.emacs` by setting
`lsp-java-java-path`, see above.


### NoClassDefFoundError: javax/annotation/processing/AbstractProcessor
```
!MESSAGE Problems occurred when invoking code from plug-in: "org.eclipse.core.resources".
!STACK 0
java.lang.NoClassDefFoundError: javax/annotation/processing/AbstractProcessor
	at java.base/java.lang.ClassLoader.findBootstrapClass(Native Method)
	at java.base/java.lang.ClassLoader.findBootstrapClassOrNull(ClassLoader.java:1248)
	at java.base/java.lang.System$2.findBootstrapClassOrNull(System.java:2123)
```

The problem was that by having Lombok on the boot classpath it would
interfere with the annotation processing mechanism in the Eclipse
server. [The
remedy](https://gitlab.com/skybert/my-little-friends/commit/f8aec7f3d47a48e6117a78c086ff13f6e5d29b7d)
was to remove `-Xbootclasspath/a:/path/to/lombok-1.16.18.jar` and only
specify Lombok in the `javaagent` parameter.

### Wipe the slate clean 
To remove all generated files and caches related to LSP, do:
```text
$ rm -rf ~/.emacs.d/workspace \
         ~/.emacs.d/.cache/lsp
```

This can be worth trying before going mad about something not working.

Also, there's a [minimal .emacs config on the lsp-java
website](https://github.com/emacs-lsp/lsp-java#quick-start) that you
can try without your own configuration to ensure your problems are not
due to your own (combination of) configuration.

## Other Java extensions for Emacs I've used

- [meghanada](https://github.com/mopemope/meghanada-emacs), 2017
- [emacs-eclim](https://github.com/emacs-eclim/emacs-eclim), 2012-2016
- JDEE, 1999-2005
- malabar
