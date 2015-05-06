title: Using Git as a frontend for Perforce
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


