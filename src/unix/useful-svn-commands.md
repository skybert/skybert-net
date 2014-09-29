title: Useful svn commands
date: 2014-01-23

Here are some of my favourite svn commands.

## Create a branch from trunk

    $ svn copy http://svn.skybert.net/my-project/trunk \
      http://svn.skybert.net/my-project/branches/my-branch

## Merge branch back into trunk

    $ cd trunk
    $ svn merge --reintegrate http://svn.skybert.net/my-project/branches/my-branch

## Cherry pick a single revision from trunk into your branch

Here, I cherry pick revision 252723 from trunk into my release-1 branch.

    $ cd branches/release-1
    $ svn merge -c 252723 http://svn.company.com/project/trunk

## Keep your branch up to date with changes in trunk

    $ cd branches/my-branch
    $ svn merge http://svn.skybert.net/my-project/trunk

## Resolving merge conflicts

When Subversion cannot figure out the conflict by itself, it’ll ask you:

Select: (p) postpone, (df) diff-full, (e) edit, (r) resolved,
        (mc) mine-conflict, (tc) theirs-conflict,
        (s) show all options:

I recommend pressing dc (display conflict), this will show you the
different versions of the conflicting fragments with the shortcuts you
need to press to select either of them: tc (their version) or mc (my
version).

## View the diff of a commit

    $ svn diff -r <revision>

## To just see the files that were changed, so:

    $ svn diff --summarize -c <revision>

## Reverting a revision

    $ svn merge -c -<revision>

You can think of it as subtracting (hence the minus sign) a commit.

## Seeing incoming changes

If you want to see which changes to your working copy a svn update
will do, you can type the following command:

    $ svn log --diff -r BASE:HEAD

