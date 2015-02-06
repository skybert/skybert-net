title: Cygwin
date: 2015-01-21

## Run X (in the background)
With X installed, you can get graphical UNIX applications on your
Windows desktop. Install the following packages from cygwin.exe:
- xorg
- xorg-xinit


To start X in the background, (create a shortcut which) runs the
following Windows command:

    c:\cygwin\bin\run.exe /usr/bin/bash.exe -l -c /usr/bin/startxwin.exe

If this doesn't work for you, just open a standard Cygwin (DOS) Window
and start ```startxwin``` from there.

## Better terminal
I recommend setting up X and let it run in the background. You can
then use a "real" terminal emulator that you're used to from Linux,
like ```urxvt```.

## WOT?
There are many odd things in the world of Windows. This is one, ~/ and
$HOME can be different (!):

    $ echo ~/
    //file05/users/torstein
    $ echo $HOME
    /cygdrive/c


## How to delete a Windows process from Cygwin

You must use ```/bin/kill -f``` instead of the shell built-in
``kill``` command. The latter of which only knows how to kill Cygwin
processes:

    $ /bin/kill -f <Windows  PID>

To find the PID of the Windows process holding a particular file, I
use ```handle.exe```. For instance, to kill the process holding the
Maven JUnit runner library, I do:

    $ /bin/kill -f $(handle surefirebooter | tail -1 | awk '{print $3;}')
