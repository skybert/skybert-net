title: Coming to Arch from Debian
date: 2014-03-06
category: linux
tags: arch

Here are some things I've noticed as different and interesting when starting using
Arch after 12-13 years of using Debian GNU/Linux.

## Where are the system logs?

There are very few familiar logs in ```/var/log```. To know what's going
on, you can tail the system log  by using the ```journalctl```command:

    $ journalctl -f

## Finding all files installed by a package
On Debian, ```dpkg -L <package>```is a great way of finding the files
belonging to a particular package.

On Arch, the equivalent is:

    $ pacmas -Qlq <package>

## Finding the package owning a file
I like the speed with which I can find which packages
owns a particular file. On Debian, all that it takes is ```dpkg -S <file>```.

On Arch, the equivalent is:

    $ pacmas -Qo <file>


## How to do an apt-get upgrade
Staying up to date on security patches as well as up to date software
packages in terms of features (what you'd do ```apt-get update && apt-get upgrade```
for on Debian) is easily accomplished with:

    # pacman -Syu

Note that Arch is a rolling release distro, so there's no
differentiation between ```apt-get upgrade```and ```apt-get dist-upgrade```
in Arch parlance.

## Where are the changelogs?
One thing I find _much_ better on Debian is the availability of
changelogs. Whatever the package, I know I can always find its
documentation, including the changelog in ```/usr/share/doc/<package>```.

With Arch however, there is no such thing. There is a command, ```pacman
-Qc <package>``` which gives you the change log if it's available, but
no packages I've tried (including big ones such as ```coreutils```,
```firefox```and ```emacs```) have any, so at the time of writing, my
conclusion is that there is no changelogs available on your Arch
system.

The best source for Arch change logs I found is browsing the Git (or
SVN to Git) <a href="https://projects.archlinux.org/svntogit/packages.git">repository available at projectsarchlinux.org</a> So, to
browse the changelog for ```firefox```, you may browse:
<a href="https://projects.archlinux.org/svntogit/packages.git/log/trunk/PKGBUILD?h=packages/firefox">projects.archlinux.org/svntogit/packages.git/log/trunk/PKGBUILD?h=packages/firefox</a>.

However, I settled for a different approach since I like to have
everything available at the command line. After all, that's where I do
all the package management. Therefore, I clone and track the
```packages``` Git repository where all the Arch build descriptors are
hosted:

    $ git clone  git://projects.archlinux.org/svntogit/packages.git arch-packages

Then, to see the Arch changes to a given package (not the upstream
changes, mind you), I do:

    $ cd arch-packages
    $ git log -p firefox/trunk

Using the ```-p```parameter I got the diff as well as the commit message
of each individual commit.

As with regular Git repositories, I keep it updated with:

    $ cd arch-packages
    $ git pull

## Restarting a network interface
Here, I restart an interface (profile):

    # netctl restart my-home

## Enabling and starting a daemon
Whenever you install a daemon, say the Percona database server, it's
enabled and started automatically for you. On Arch, not so. The
server is only installed, not started.

To enable boot time startup of the Percona database (it's a collection
of performance related patches on top of MySQL) and starting it at the
current session, I did the following (including installing the actual
server to be sure you've got the context):

    # pacman -S percona-server percona-server-clients
    # systemctl enable mysqld.service
    # systemctl start mysqld.service

Of course, a lot of the new-iness here, is that Arch uses [[http://www.freedesktop.org/wiki/Software/systemd/][systemd]] per
default and Debian does not (although it's available in the APT
repositories).

## Where is netstat?
Netsat isn't installed by default. To get it, you'll need to install
```net-tools```:

    # pacman -S net-tools

Note that search for netstat will only yield the
```netstat-nat```package which most probably isn't what you want.
