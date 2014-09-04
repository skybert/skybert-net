date:    2012-10-07
category: windows
title: Creating an SSH key on Windows

I've been through this so many times with people running
Windows so that I want to put this down to paper.

## Install Cygwin &amp; its SSH Package

Install <a href="http://cygwin.com">Cygwin</a> and be sure
to check for the```openssh-client``` package while
running```setup.exe```

<img src="openssh.png"
alt="cygwin setup.exe"/>
<h2>
Generate the key using the Cygwin shell
</h2>

You can now run standard```ssh``` commands that you
see documented on the plethora of Linux and Unix websites on
the internet. Right now, the command you really want to run
is:
    $ ssh-keygen -t rsa



I recommend entering a password so that in case someone
steals your key, they still cannot use it.


This key, found in```~/.ssh/id_rsa.pub``` can now be
added to the```~/.ssh/authorized_keys``` file on the
servers on which you want to log into.

## But: Can't I just not use PuTTY to generate the keys?

PuTTY is an excellent SSH client, but I would not recommend
using its <a
href="http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html">
key generator</a> as I've seen so many cases where it doesn't
create proper keys for using with Linux/Unix OpenSSH servers.


This has at least been my experience with at least five
Windows users so I've stopped asking people to use PuTTY to
create their keys. It is probably possible to create proper
keys with PuTTY, but my experience is very bad with this and
I'd therefore recommend using Cygwin and
```ssh-keygen``` instead.

## Making use of your new key

Since you now have Cygwin and```ssh``` on your
machine, you can just use the Cygwin shell and follow the
standard Unix way and add the key with```ssh-add```
and use```ssh``` afterwards. If using Cygwin, I
seriously recommend using its```xterm``` as it gives
you a so much better shell than the Windows/DOS shell that
cygwin standard wise is launched inside in: better fonts,
better signal handling and <em>much</em> faster input and
output buffer.


If you prefer using PuTTY, there's a walkthrough on using <a
href="http://www.howtoforge.com/ssh_key_based_logins_putty">PuTTY
and its key agent</a> here. Rememer, you need to make a note
of where the key you generated inside Cygwin is on the Windows
file system, normaly, it's somewhere under
```c:\cygwin\```...

