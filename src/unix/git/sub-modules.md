title: Making another repository directory a part of your Git repo
date: 2014-12-12
category: vcs
tags: vcs, git

Say you want the contents of a given folder in your project to point
to a different Git repo's (top folder).

Create a file called ```.gitmodules``` in your projects top folder:

    [submodule "src/main/other"]
    path = src/main/other
    url = ssh://git@git.example.com/other.git

Then do:

    $ git submodule init
    $ git submodule update

The contents of your project's folder ```src/main/other``` is now
"linked" to the Git repo called ```other```.

When you later want to update the submodule, you'll need to switch to
its desired branch and then pull in the changes:

    $ cd src/main/other
    $ git checkout master
    $ git pull

