title: Rewriting History in Git
category: vcs
tags: git, vcs
date: 2015-03-10

## Combining several commits into one

If you've set up remote tracking, this is as simple as:

    $ git rebase -i

Select to "squash" (`s`) commit(s) (up) into the previous commit:

    pick 908147acbe25f One commit
    s    34568147acbee Another commit, combine it with the previous one
    s    23568147gdfae Yet another commit, combine it with the previous ones

Once you quit the interactive rebase screen (which is vim in my case),
you'll be prompted for how to concatinate (or just rewrite) the
combined commit message for the now three combined (squashed) commits.

## Removing files from a commit

First, find the SHA of the commit to which you want to rewrite the
history. In this example, `acbe25f` is the first commit I'm
*not* interested in rewriting:

    12e36ee       This commit combines a lot of different changes
    acbe25f       Everything is safe and sound

    $ git rebase -i acbe25f

Select to edit the commit you're interested in:

    edit 12e36ee

Then, remove the files from the given commit:

    $ git reset HEAD~1 file1 file2

Re-commit the commit using the existing commit message, excluding the
two files:

    $ git commit --amend

Then, create a seperate commit for `file1` and `file2`:

    $ git commit file1 file2 -m "Split file1 & 2 out into their own commit."

Finish the rebasing:

    $ git rebase --continue

Finally, force push the changes to rewrite the changes on the (remote)
server too:

    $ git push --force

The `--force` is only needed if you're rewriting already pushed
commits. Naturaylly, `git push --force` is potentially **dangerous**
and heed must be taken.

## Removing some lines from a file in a commit

The first steps are just like above:

    $ git rebase -i acbe25f
    edit 12e36ee
    $ git reset HEAD~1 pom.xml
    $ git commit --amend

At this point, now do an interactive `git add`:

    $ git add -i
    staged     unstaged path
    1:        +8/-8        +8/-8 pom.xml

    *** Commands ***
    1: status         2: update     3: revert       4: add untracked
    5: patch          6: diff       7: quit         8: help


Select patch `p`,

Git will then ask you:

    Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]?

For the commits you want to include in the next commt, select `y`, for
the others you want to include in a different commit, select `n`.

Once you've answered yes and no to all the hunks, the hunks that
you've said "yes" to, are already staged for commit, so it's important
that you now just do a regular `commit` with `-a` or file name:

    $ git commit -m "Committed a couple of hunks in pom.xml"

If you now do a `git status` or `git diff`, you'll see that there're
still changes to be committed, i.e. the hunks you said `n` to in the
interactive add:

    $ git diff

I find that normally, at this point I can just commit the remaining
hunks in one commit (but you could of course repeat the interactive
add to split the file commt into even finer grained commits):

    $ git commit -m "Committed the remaining hunks in pom.xml"

Finally, force push your changes to the remote(s) server:

    $ git push --force

Again, this is will rewrite the server history, so heed must be
taken.
