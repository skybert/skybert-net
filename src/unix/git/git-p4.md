title: Using Git as a frontend to Perforce
tags: vcs, git, p4
category: vcs
date: 2015-05-06

After using Git for both my work and leaisure programming for more
than three years, it was hard to go back to p4. hence, I wanted to set
up git so that I could use it as an interface to p4 in the same way
that `git-svn` had serverd me so well for the last year, saving me
from the sad valley of Subversion.

Since `git-p4` was removed from Debian a good while back, I had to
manually install it on my Debian stable system:

```
# wget http://git.kernel.org/cgit/git/git.git/plain/git-p4.py?id=master -O /usr/local/bin/git-p4
# chmod +x /usr/local/bin/git-p4
```

After adding `/usr/local/bin` to my `PATH` variable, `git p4` worked
like any other `git` plugin.

```
$ git p4
```

I also downloaded the man pages for `git p4` and included it in the
`MANPATH`:

```
# wget http://git.kernel.org/cgit/git/git-manpages.git/plain/man1/git-p4.1?id=master \
       -O /usr/local/man/man1/git-p4.1
$ grep MANPATH ~/.bashrc
export MANPATH=/usr/local/man/man1:$MANPATH
```

With this in place, `man git-p4` works as it should.

## Cloning a depot project with full history

```
$ git p4 clone //depot/escenic/engine/trunk@all
```

## Updating the Git project with the latest changes from p4

This puts your changes ontop of the latest, pulled down changes:

```
$ git p4 rebase
```

This just includes the latest changes from p4

```
$ git p4 sync
```

So far, I've just used `git p4 rebase` for everything.

## When it's not possible to git p4 submit

```
$ cd ~/src/git/moria
$ files=$(git show 15857cab8a21f48cffa2b92a650f6d37723efec6 | \
  sed -n 's#diff --git a/\(.*\) b/.*#\1#p')
```

The `files` variable now holds the files belonging to my Git commit.

```
$ echo "$files"
moria-core/pom.xml
moria-core/src/main/java/org/moria/core/servlet/ArticleRedirectProcessor.java
moria-core/src/main/java/org/moria/core/servlet/RedirectProcessor.java
moria-core/src/main/java/org/moria/core/servlet/SectionResolverProcessor.java
moria-core/src/test/java/org/moria/presentation/servlet/SectionResolverProcessorTestCase.java
```

Now, I shift to my `p4` workspace and checkout these files`:

```
$ cd ~/src/p4/moria
$ for el in $files; do p4 edit $el; done
```

Then, copy the contents from my `git` directory:
```
$ for el in $files; do cp ~/src/git/moria/$el $el; done
```

The `p4 diff` should now be the same as my previous `git log --patch`:

```
$ cd ~/src/p4/moria
$ p4 diff ...
```
