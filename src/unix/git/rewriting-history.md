title: Rewriting History
category: unix
tags: git, unix
date: 2015-03-10

## Combining several commits into one (not pushed)

If you've set up remote tracking, this is as simple as:

    $ git rebase -i

Select to "squash" (`s`) commit(s) (up) into the previous commit:

    pick 908147acbe25f One commit
    s    34568147acbee Another commit, combine it with the previous one
    s    23568147gdfae Yet another commit, combine it with the previous ones

## Removing files from a commit

    $ git rebase -i 908147acbe25f

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

## Removing some lines from a file in a commit

    $ git rebase -i 908147acbe25f

Select to edit the commit you're interested in:

    edit 12e36ee

Then, remove the files from the given commit:

    $ git reset HEAD~1 file1 file2

Re-commit the commit using the existing commit message. This will
exclude `file1` and `file2`:

    $ git commit --amend

Now, do an interactive `git add`:

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

Finally, force push your changes to the remote(s) server:

    $ git push --force
