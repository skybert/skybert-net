date:    2014-06-02
category: emacs
tags: java, eclipse, emacs
title: Java in Emacs using eclim

<img class="right" src="/graphics/emacs/emacs.png" alt="png"/>

## - Enterprise Java Development in Emacs

## Code completion

This is my favourite feature of <a
href="https://github.com/senny/emacs-eclim"> emacs-eclim </a>, the
ability to get real, 100% correct auto completion of everything,
without clever hacks like ```hippe-expand``` and vanilla
```auto-complete-mode```:

<img src="/graphics/emacs/2013/eclim-code-completion.png" alt="code completion"/>
## On the fly syntax checking

Since very few of us can remember all the nuts and bolts of
the vast Java class library, not to mention all the brilliant
and esoteric 3rd party APIs out there, Emacs offers just the
thing we need: on the fly syntax checking. It will underline
plain compilation errors in red, whereas Java warnings will be
underlined with yellow marker:

<img src="/graphics/emacs/2013/eclim-java-warning.png" alt="eclim java warning"/>
## Jump to source

When navigating huge source trees, this feature is
indispensable (even though things like```file-cache```
and```find-dired``` provide decent generalised file
lookups):

<img src="/graphics/emacs/2013/eclim-jump-to-source-before.png"
alt="jump to source before jumping"/>

When invoking```eclim-java-find-declaration```, you're
instantly taken to the class in question (here open in a new
buffer):

<img src="/graphics/emacs/2013/eclim-jump-to-source-after.png"
alt="jump to source after jump"/>
## Showing all references

It's often useful to see all references to a given method or
class. Put your point at the class name or method in question
and call the command```eclim-java-find-references```:

<img src="/graphics/emacs/2013/eclim-find-references.png" alt="find references"/>
## Refactoring

Java developers love refactoring, especially changing the name
of variables and methods is something many of us do all the
time. Emacs will happily do all of the work for you if you
just navigate to the method, class or variable in question
invoke
```eclim-java-refactor-rename-symbol-at-point```:

<img src="/graphics/emacs/2013/eclim-refactoring-before.png" alt="refactoring before"/>

Emacs will then make all the required changes in all files in
the project:

<img src="/graphics/emacs/2013/eclim-refactoring-after.png" alt="refactoring after"/>
## Getting help wherever you are

Put your pointer on the class or method you want and call
```eclim-java-show-documentation-for-current-element```:

<img src="/graphics/emacs/2013/eclim-show-javadoc.png" alt="show javadoc"/>
## Showing class inheritance

Emacs will quite happily show you a class' or an interface's
inheritance hiearchy if you invoke
```eclim-java-hierarchy```:

<img src="/graphics/emacs/2013/eclim-show-class-inheritance.png" alt="show inheritance"/>
## Importing classes &amp; organising imports

Emacs will import any missing classes and re-organising the
imports while it's at it when you call
```eclim-java-import-organize```:

<img src="/graphics/emacs/2013/eclim-import-before.png"
alt="before importing missing classes"
/>

For the most part, this will work without an itch, the exception being
ambiguities like```java.util.List``` and```java.awt.List```:

<img src="/graphics/emacs/2013/eclim-import-after.png"
alt="after importing missing classes"
/>

## Correcting problems

A feature which makes Java IDEs so appealing is that they
suggest fixes to various problems in your code. In fact, this feature
has gotten so good, many Java developers rely on it as a way
of programming. Instead of creating methods and variables
before using them, they instead rely on the IDE to create them
as they refer to new methods or field members.


Many will be very surprised to find that Emacs now also has
this feature, here's an example where the code refers to a
not yet written method:

<img src="/graphics/emacs/2013/eclim-correct-problem-method-doesnt-exist.png"
alt="referring to non existent method"
/>

Invoking```eclim-problems-correct``` opens up another
buffer in which you may preview the different suggestions and
before applying them with the suggested fix's number
(```0-9```):

<img src="/graphics/emacs/2013/eclim-correct-problem.png"
alt="eclim problems correct"
/>

After hitting```0```, the method is added to the
correct class:

<img src="/graphics/emacs/2013/eclim-correct-problem-success.png"
alt="problem corrected"
/>
## Maven integration

Using the excellent <a
href="http://www.thaiopensource.com/nxml-mode/">nxml-mode</a>,
Emacs gives you both on the fly syntax checking (or XML
validation if you will) and auto completion when editing your
POM files:

<img src="/graphics/emacs/2013/nxml-maven-pom-auto-completion-and-syntax-checking.png"
alt="Using nxml mode for editing POMs"
/>

Wherever you are in your Java project, you can always invoke
```eclim-maven-run``` to run any of the Maven
goals. Any errors, be that compilation or unit test failure,
can be clicked on for instant viewing of the offending code in
the editor:

<img src="/graphics/emacs/2013/eclim-run-maven.png" alt="eclim run maven"/>

## Source control

The source code control integration in Emacs is second to
none. It's extremely fast and supports just about all systems
out of the box.


You don't have to worry about which backend you're using,
Emacs will let you do all the checkins, checkouts,
annotations, diff-ing and so on using the same commands,
regardless if you're using CVS, Subversion, Perforce, Git or
Mercurial.


Here, I'm viewing the commit log (by running ```vc-print-log```) for
one Java class while viewing the diff (by hitting```d``` when
navigating the commits with```n``` and ```p```) of one of the commits
in the bottom buffer.

<img src="/graphics/emacs/2013/vc-git-log-and-diff.png"
alt="version control in Emacs"/>

## One the fly display of Checkstyle and PMD violations

<a href="http://checkstyle.sf.net">Checkstyle</a> and <a
href="http://pmd.sf.net">PMD</a> are two tools often used in
java projects. Checkstyle is for checking the code adheres to
the project's coding standard (e.g. the Sun Java coding
standard) and PMD detects unused code, bad design patterns,
unnecessary constructs as well as duplicate code segments in
your source tree.


Using <a href="http://flymake.sf.net/">flymake</a> and a <a
href="https://github.com/skybert/my-little-friends/blob/master/bash/my-java-flymake-checks">wee
command I wrote</a>, it's easy to get this into Emacs.


Having PMD, Checkstyle &amp; friends running under Flymake
also doesn't hinder your work in Emacs. Flymake runs in the
background and doesn't block any thread in Emacs. It just
updates the error/warning highlighting whenever it's ready. I
find that running PMD with all checks enabled and Checkstyle
running with a full Sun coding standards checks set,
Emacs/flymake is snappy enough, with new updates coming in 1-2
seconds after I save the file (the old check markings are left
until the new are available).


One PMD check I'm particular found of, is
```javabeans```. It will spot if you have a getter but
no setter for a member variable, or more importantly, if you
have misspelled your getter or setter. This is the kind of bug
you will often first spot in runtime when your JSON
serialisation isn't working and you wonder why on earth isn't
it?

<img src="/graphics/emacs/2013/flymake-checkstyle-and-pmd.png"
alt="Checkstyle and PMD checks in Emacs"/>
## Editing popular Java world XML files

Emacs and```nxml-mode``` will give you on the fly syntax checking and
auto completion for all popular XML file formats in the Java
world. I've enjoyed error free editing of iBATIS, Struts, DWR, Spring,
Tomcat, Resin, Escenic Ant &amp; Maven XML files using <a
href="https://github.com/skybert/my-little-friends/tree/master/emacs/.emacs.d/xml">these
Relax NG RNC files</a> with```nxml-mode```

## Installation

To get the code completion, code navigation, javadoc lookup and so on
working, we need to set up this call flow:

<img src="/graphics/emacs/2013/emacs-eclim-eclipse.svg" alt="emacs to
eclim to eclipse call flow" />

### Eclipse

First things first, you need to get <a
href="http://www.eclipse.org/downloads/packages/eclipse-ide-java-developers/junosr1">Eclipse
IDE for Java Developers</a>, at the time of writing
(2012-12-01), I'm using the version called Juno SR1, or
```4.2.1```, which I put in
```/opt/eclipse-4.2.1``` with a symlink
```/opt/eclipse``` pointing to it:

    $ ls /opt/eclipse
    lrwxrwxrwx 1 root root 14 Sep 29 00:57 /opt/eclipse -> eclipse-4.2.1

### eclim

Next stop is the excellent "Eclipse to Any Editor" bridge
called <a href="http://eclim.org">eclim</a> (its first class citizen
is Vim, but we can use it for Emacs too). It lets us get all
the goodness of Eclipse (code completion, refactoring, syntax
checking++) in our beloved editor with no extra configuration,
hacks or fuss.


I install all 3rd party sources in```/usr/local/src``` to differ them
from my own sources in```~/src```, thus:

    $ cd /usr/local/src
    $ git clone git://github.com/ervandew/eclim.git
    $ cd eclim
    $ ant clean deploy -Declipse.home=/opt/eclipse

This will install the```eclim``` plugin in our ```/opt/eclipse```
directory, with symlinks to the two eclim binaries in the root (that
looks a bit messy, doesn't it? Oh well, the important thing is that it
works :-)):

    $ ls /opt/eclipse/eclim*
    lrwxrwxrwx 1 torstein 8779 44 Dec  1 11:40 /opt/eclipse/eclim -> plugins/org.eclim_2.2.5.3-gaad35e4/bin/eclim
    lrwxrwxrwx 1 torstein 8779 45 Dec  1 11:40 /opt/eclipse/eclimd -> plugins/org.eclim_2.2.5.3-gaad35e4/bin/eclimd

If you like me, prefer launching```eclimd``` from a
dedicated shell, be sure to set up your workspace directory in
```.eclimrc``` if it's different from
```~/worskpace```. Here you can also assign more memory
to```eclimd```:

    # workspace dir
    osgi.instance.area.default=@user.home/src/workspace

    # increase heap size
    -Xmx256M

    # increase perm gen size
    -XX:PermSize=64m
    -XX:MaxPermSize=128m

If you're using a non default location for your workspace and
you don't set the workspace directory here, you'll probably
get confused as to when```eclim``` does and does not
find your projects. I for sure was!

### emacs-eclim

The last piece of the puzzle, is the excellent Emacs eclim
library which acts as a bridge between Emacs and the
```eclimd``` process.

At the time of writing (2012-12-01), there's no Emacs package
of```emacs-eclim```, hence, I put it with my other
Emacs modules that are neither installed with APT nor with
Emacs packages in```/usr/local/src/emacs```. Hence:

    $ cd /usr/local/src/emacs
    $ git clone https://github.com/senny/emacs-eclim.git

Finally, there's some Lisp to set it all up. I've put this in
my <a
href="https://github.com/skybert/my-little-friends/blob/master/emacs/.emacs.d/tkj-java.el">
~/.emacs.d/tkj-java.el </a>, but you can of course put it
anywhere you like, like```~/.emacs``` :-)

### Checkstyle &amp; PMD checks

First off, install checkstyle with ```#apt-get install checkstyle```
(if you're on a Debian based system, or else, get it with your package
manager, or set it up manually so that you have the```checkstyle```
command wrapper in your PATH) and make PMD available in```/opt/pmd```:

    $ unzip /tmp/pmd-bin-5.0.4.zip -d /opt
    $ cd /opt
    $ ln -s pmd-5.0.4 pmd
    $ ls -l /opt/pmd
    lrwxrwxrwx 1 torstein torstein 14 May  4 17:21 /opt/pmd -> pmd-bin-5.0.4/


Then, get my command <a
href="https://github.com/skybert/my-little-friends/blob/master/bash/my-java-flymake-checks">my-java-flymake-checks</a>
or write your own. Then put the following in your ```.emacs``` to wire
it up:

```
(require 'flymake)
(defun my-flymake-init ()
  (list "my-java-flymake-checks"
  (list (flymake-init-create-temp-buffer-copy
  'flymake-create-temp-with-folder-structure))))
(add-to-list 'flymake-allowed-file-name-masks
'("\\.java$" my-flymake-init flymake-simple-cleanup))
```

### Setting up a project to use eclim

After intsalling eclim, emacs-eclim and adjusting your Emacs
configuration, the time has come to make use of it all with your Java
project.  There are definitely more than one way of doing this, but
this is what I find the easiest:

```
$ cd my-project
$ mvn eclipse:eclipse -DdownloadSources -DdownloadJavadocs
```

The `-D` parameters are for downloading the sources of the project's
dependencies as well as downloading the related java doc. These two
parameters are not necessary. Now, in Emacs, ask eclim to create a
project:

``` M-x eclim-project-create ```

and enter the name of the project and its base directory. Mutli module
project works too. I'm currently using this on a three level deep
Maven project structure with more than 2000 java source files and it
works fine, albeit not perfect. In general, eclim will not help you
with anything if there's one file somewhere which doesn't compile.

And this is it. eclim *should* now be able to figure out which project
your current java file in Emacs belongs to.
