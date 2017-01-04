title: Resolving Merge Conflicts in Emacs
date: 2017-01-04
category: emacs
tags: vcs, git, emacs

Out of the box Emacs gives us an easy interface to working with
merge conflicts, called `smerge` (as in "simple merge").

When there's a merge conflict, the version control system writes the
diff markers into the source files themselves and Emacs will highlight
these automatically. It will recognise which parts are "theirs" and
which are "mine" — as well as "ancestor" if you've set up 3 way merge.

<img src="/graphics/2017/2017-01-04-emacs-3-way-diff-git-merge.png"
  alt="resolving 3 way diffs in Emacs"
  class="centered"
/>

To select the version at the bottom, I just put my pointer on it, and
run <kbd>M-x</kbd> `smerge-keep-current`.


## Telling Git to give us 3 way diff instead of two way

By default git sets up 2 way diffs when there's a merge conflict ("my"
version of the file and "their" version). However, when resolving
merge conflicts, it's often useful to in addition see the most recent
common ancestor of the two versions of the file you're merging.

This is so useful, you may just want to set it globally for all your
projects by adding the following to your `~/.gitconfig`:

```
[merge]
    conflictstyle = diff3
```


### *)
Tested on version Emacs version 25.1
