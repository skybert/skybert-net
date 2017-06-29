title: Get Git to Clean Up Your mess
date: 2017-06-29
category: vcs
tags: git, vcs, 

Often, my editor(s) leave behind some temporary or backup files that I
don't want: 

```
$ git status
On branch bugfix/VF-7129-resolver-web-service-returns-incorrect
Your branch is up-to-date with 'origin/bugfix/VF-7129-resolver-web-service-returns-incorrect'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	engine/engine-resolver/src/main/java/com/escenic/resolver/#ResolverServlet.java#
	engine/engine-resolver/src/main/java/com/escenic/resolver/.#ResolverServlet.java

nothing added to commit but untracked files present (use "git add" to track)
```

I *could* of course remove these with `rm -- <file>`, but it's much
faster and less error prone to use the `git` command. To have Git do
the house cleaning, just do:

```
$ git clean -f 
Removing engine/engine-resolver/src/main/java/com/escenic/resolver/#ResolverServlet.java#
Removing engine/engine-resolver/src/main/java/com/escenic/resolver/.#ResolverServlet.java

```

That's it, your project workspace is nice and clean again 😃
