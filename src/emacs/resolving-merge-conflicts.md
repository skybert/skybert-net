title: Diffing and merging in Emacs
date: 2016-03-11
category: emacs
tags: emacs, vcs, p4

## Diffing files you've got open in your Emacs
```
M-x ediff-buffers
```

## Diffing revisions of a file

<kbd>C-x</kbd> <kbd>v</kbd> <kbd>=</kbd> (`vc-diff`)

You can also view the changes with `ediff` using <kbd>M-x</kbd>
`ediff-revision`

## Inside an ediff session
Once inside an ediff session, put focus in the `ediff` navigator and
use e.g.:

- <kbd>n</kbd>/<kbd>p</kbd> - next/previous hunk
- <kbd>a</kbd> - apply version A's hunk
- <kbd>b</kbd> - apply version B's hunk
- <kbd>r</kbd> - revert, undo the applying of the A/B hunk.
- <kbd>q</kbd> - quit ediff session

## Resolving merge conflicts in files with merge conflict markers
Out of the box Emacs gives us an easy interface to working with merge
conflicts, called `smerge` (as in "simple merge").

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

## P4 specific setup
in `.p4enviro`:

```bash
P4MERGE=/home/torstein/bin/p4-emacs-merge
```
in `.emacs`:

```lisp
(server-start)
```

in `/home/torstein/bin/emerge` (Gentoo users, note the full path ;-)

```bash
ancestor=$1
theirs=$2
yours=$3
merge_result=$4

emacsclient -e "(ediff-merge-files-with-ancestor \"${yours}\" \"${theirs}\" \"${ancestor}\" () \"${merge_result}\")"
emacsclient "${merge_result}"
```

The full source of p4-emacs-merge can be found here:
https://github.com/skybert/my-little-friends/blob/master/bash/vcs/p4-emacs-merge

### P4 specifc post-merge notes

After you're finished with the `ediff` session and you're back at the
`p4`/shell prompt, choose `ae` (accept edit) Here's one merge
conflict, with the two version presented (p4 "yours" is A and p4
"theirs" is B):

<a href="/graphics/2016/2016-03-10-ediff-merge-before.png">
<img
  src="/graphics/2016/2016-03-10-ediff-merge-before.png"
  alt="ediff before"
  style="width: 900px;"
  />
</a>

Now, I want "their" version, so I hit <kbd>b</kbd>. Emacs then replaces the
merge conflict markers/block with the contents of the B hunk:

<a href="/graphics/2016/2016-03-10-ediff-merge-after.png">
  <img
    src="/graphics/2016/2016-03-10-ediff-merge-after.png"
    alt="ediff after"
    style="width: 900px;"
  />
</a>

