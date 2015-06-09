
# Git for Perforcers

A talk by <a href="">torstein @ escenic</a>

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

- There are no clients.
- Everyone can be a server
- And everyone can be a client of each other's servers.

---

## So what's Stash then?

- Yes, it's server which can act as a remote
- But you don't need it.
- You can just as well pull and push from a colleague
- Or a different Stash server
- Or a Github repo

---

## THIS takes time to trickle in 😊

---

## Big difference: branches are cheap

- everyting in one place
- create as many as you want
- delete them at will
- merge them
- merge or cherry pick between them

---

## Big difference: blobs are stored once

- Having big-bloated-file.doc in 100 branches still stores it just
  once.

---

## Powerful re-writing of history

    $ git rebase

- Can split an existing commit into several commits (!)
- Can re-arrange the order of commits
- Can combine several commits into one

---

## Word of caution

If you want to avoid trouble, don't use `git rebase` except for:

```
$ git rebase --interactive                      # or -i
```

There are no limits to how much you can mess up when using `git
rebase` 😊


---

## Change: branches are cheap

    $ git checkout -b feature/vf-2134-xml-support

And voila, you've got your new feature branch.

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

## Show me the change log with diffs

    $ git log --patch

---

## What have I not staged for commit

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

One way:

---

## Further reading

- [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)
