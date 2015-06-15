
# Git for Perforcers

A talk by <a href="">torstein @ escenic</a>

---

## A Tour of Git

Let's start with a wee tour of [Git](https://git-scm.com/)

---

## Initialise a new repo

```
$ mkdir git-for-p4ers
$ cd git-for-p4ers
$ git init
```

---

## Add a file

```
$ echo 'O Captain! my Captain! our fearful trip is done,' > poem.txt
$ git add poem.txt
$ git commit
```
---

## Create a branch for the daily development

This roughly corresponds to our `trunk` today.

```
$ git checkout -b develop
$ echo "The ship has weather’d every rack, " \
  "the prize we sought is won," \
  >> poem.txt
$ git status
$ git diff
$ git commit -a -m "The ship is not doing so well."
```
---

## Create a 5.7 release branch based on the master branch

```
$ git checkout master
$ git checkout -b release/5.7
$ echo "The port is near, the bells I hear, " \
  "the people all exulting," \
  >> poem.txt
$ git commit poem.txt -m "The port is near."
```
---

## Create a 5.8 release branch based on the master branch

```
$ git checkout master
$ git checkout -b release/5.8
$ echo "While follow eyes the steady keel, " \
  "the vessel grim and daring;" \
  >> poem.txt
$ git commit poem.txt -m "Steady keel."
```
---

## Discovered a memory leak in CS for version 5.7!

```
$ git checkout release/5.7
$ git checkout -b hotfix/memory-leak-cs
$ echo 'But O heart! heart! heart!' >> poem.txt
$ git commit -m "Fixed memory leak in CS using hearts" poem.txt
```

Again, the convention is that bug fix branches are prefixed `hotfix/`.

---

## QA has OKed the fix, merge it into the 5.7 branch

```
$ git checkout release/5.7
$ git merge hotfix/memory-leak-cs
```
---

## The fix really works, the customers are dying for getting it into 5.8 too

```
$ git checkout release/5.7
$ git log                   # take note of the SHA
$ git checkout release/5.8
$ git cherry-pick <sha>
```
---

## Back to regular development

```
$ git checkout develop
$ git checkout -b feature/vf-100-npe-in-ece
```
A good practice is to create a new feature
branch for each JIRA issue.

---

## Commit all the time, squash and push regularly

```
$ echo "O the bleeding drops of red," >> poem.txt
$ git commit -m "Another drop" poem.txt
$ echo "Where on the deck my Captain lies," >> poem.txt
$ git commit -m "Captain lies" poem.txt
$ echo "Fallen cold and dead." >> poem.txt
$ git commit -m "Cold and dead" poem.txt
```
---

## I'm not sure my colleagues need all those commits...

Squash and re-arrange commits, improve the commit messages:

```
$ git rebase -i
```

```
pick 100a6ad Another drop
squash e4dffae Captain lies
squash 27300b1 Cold and dead
```

```
$ git push
```
---

## Ready for release or named build

```
$ git pull
$ git checkout release/5.7
$ git tag 5.7.1
$ git push --tags
```
---

## Big differences P4 vs Git

---

## Big difference: no central server

This will probably take some time to sink in:

> There is no server.

---

## Big difference: no central server

```
$ git remote -v
```

- Everyone can be a server
- Everyone can be a client of each other's (local) repos.

---

## So what's Stash then?

- Yes, it's server which can act as a remote
- But you don't need it.
- You can just as well pull and push from a colleague
- Or a different Stash server
- Or a Github repo

---

## THIS takes time to sink in 😊


---

## Big difference: commit is local

```
$ git commit pom.xml -m "Removed unused dependency."
$ git push
```

- `git commit` as often as you want locally.
- Once you're done with a (part of a) feature, re-arrange, combine
  (squash) and rewrite your commits to your ❤'s desire.
- Once in a while `git push` your changes for the world to see.

---

## Big difference: branches are cheap

    $ git checkout -b feature/vf-2134-xml-support

- Everyting in one place
- Create as many as you want
- Delete them at will
- Merge or cherry pick between them

---

## Big difference: blobs are stored once

- Having big-bloated-file.doc in 100 branches still stores it just
  once.

---

## Powerful re-writing of history

    $ git rebase

- Can split an existing commit into several commits (!)
- Can remove lines from a given file in a commit
- Can re-arrange the order of commits
- Can combine several commits into one
- Can re-write commit messages (of course)

---

## Word of caution

If you want to avoid trouble, don't use `git rebase` except for:

```
$ git rebase --interactive                      # or -i
```

There are no limits to how much you can mess up when using `git
rebase` 😊

---

## Blistering fast
- everything's local
- diff-ing, viewing logs, everyting is fast

---

## Who did that?

    $ git annotate <file>

---

## Searcing in history

Show me all commits mentioning UTF-8 somewhere in their multiline
commit messages:

    $ git log --grep UTF-8

---

## Searcing in history

Show me all commits mentioning UTF-8 authored by **lisa** that contain a
code diff that uses `HashMap`:

    $ git log --patch --grep UTF-8 --author lisa | grep HashMap

---

## Show me the change log with diffs

    $ git log --patch

---

## What have I not staged for commit?

    $ git status
    $ git diff

---

## How do I integrate a change into the 5.7 release branch?

Or how to `p4 integrate` a change if you will.

```
$ git checkout develop
$ git log                            # copy the commit SHA
$ git checkout release/5.7
$ git cherry-pick 4bba83875b0d04f3a3340f15f9864c46152c6c6b
```

---

## Branching model
<a href="http://nvie.com/img/git-model@2x.png">
  <img
    src="http://nvie.com/img/git-model@2x.png"
    alt="branching model"
  />
</a>

---

## Branching model - Escenic style

```
├── develop
│   ├── feature/vf-100-cs-memory-leak
│   └── feature/vf-200-search-for-author
└── release
    ├── 5.7
    │   ├── hotfix/apidoc-bug-javaws
    │   └── hotfix/npe-in-ws
    └── 5.8
```

`master` holds the latest release.

---

## Migrating from p4 to Git/Stash

```
$ git p4 clone //depot/escenic/engine/trunk@all engine
$ git remote add stash \
  https://username@our.stash.com:7999/escenic/engine.git
$ git push stash develop
```

---

## Recommended Git configuration

Add (at least) the following to your `~/.gitconfig`:

```
[user]
name = Walt Whitman
email = walt@withman.com

[branch]
autosetuprebase = always

[push]
default = current

[core]
excludesfile = ~/.gitignore
```

---

## Recommended Git configuration on Windows

If you're on Windows, also add:
```
[core]
# especially useful on Windows where the executable bit is
# constantly set making git list the file as modified.
fileMode = false
```

---

## Recommended Git configuration in the shell

`git` will launch whetere is in the `EDITOR` variable whenever you're
composing a commit message, are running interactive `rebase`, `add` or
the like:

```
$ echo EDITOR=vim >> $HOME/.bashrc
$ source $HOME/.bashrc
```

This works equally well in Windows/Cygwin, Mac OS X or Linux.

---

## Recommended Git configuration in the shell - II

There's pretty good auto completion for git in BASH
```
$ echo source /usr/share/bash-completion/completions/git \
  >> $HOME/.bashrc
```

---

## Recommended Git configuration in the shell - III

There's plenty of fancy BASH and ZSH prompts going around to give you
Git info relevant for where you are on the command line.

- [mediaoneright.com](http://mediadoneright.com/content/ultimate-git-ps1-bash-prompt)
- [code-worrier](http://code-worrier.com/blog/git-branch-in-bash-prompt/)
- I've written a wee git prompt that I use,
  [see get_git_status() and PS1](
  https://github.com/skybert/my-little-friends/blob/master/bash/.bashrc)

---


## Further reading

- Official online [Git books](https://git-scm.com/doc)
- [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)
- [git flow plugin](https://github.com/nvie/gitflow)
-
  [My git configuration](https://github.com/skybert/my-little-friends/blob/master/git/.gitconfig-work)
- [Global Git ignore file](https://github.com/skybert/my-little-friends/blob/master/git/.gitignore)
