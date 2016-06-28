title: Git
date:    2012-10-07
category: vcs
tags: git, vcs

## Renaming a branch

    $ git branch -m <current name> <new name>

## Set up your own a git repository on your server

This is how you set up your own git repository on Unix/Linux
server with SSH access.

### Locally on your laptop

First set up git in your local project source folder:


    $ cd ~/src/myproject
    $ git init
    $ find . | xargs git add
    $ git commit
...write a nice commit message



Then, create a git repo directory structure based  on your sources
(we always call this something ending with```.git```


    $ cd ~/src/
    $ git clone --bare myproject myproject.git


Copy it to your server, e.g.:

    $ scp -r ~/src/myproject.git ssh://user@myserver:~/src/

You (and your colleagues) can now use it on your machine(s):

    $ cd ~/src

move the old sources out of the way just in case:
    $ mv myproject myproject.orig

then, fetch them from the server:

    $ git clone ssh://user@myserver:~/src/myproject.git

You can now work as you're used to with e.g. <a
href="http://github.com">github</a>,```git pull```, ```git push```
will all work as you're used to.


## Deleting a (remote) branch

The first command deletes the branch locally and the second "pushes" the
delete to the reomote server.

    $ git branch -D <branch name>
    $ git push origin --delete <branch name>

