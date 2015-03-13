title: Creating and applying patches in Git
date: 2015-03-11
category: vcs
tags: git, vcs

## Creating patches from all comits from a given commit

     $ git format-patch <sha>

You'll now have one ```.patch``` file for each of the commits between
the commit SHA you entered and HEAD.

## Applying patch files

```
$ git am --interactive --ignore-space-change --ignore-whitespace --keep-cr --reject *.patch
```

