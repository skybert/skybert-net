date:    2012-10-07
category: emacs
title: Reading and Sending Email

<a href="http://www.nongnu.org/viewmail/">View Mail (VM)</a>
is an excellent mode for Emacs to read and send email. I find
it to be much better as an email client than Emacs' built-in
news &amp; mail client, Gnus. Here, I will describe how I've
set it up to read and send email using my GMail account, but
these instructions can of course be applied for other setups
too. At the bottom, I've also described how I've <a
href="#install">installed the latest release of VM from
source</a>.


If you just want to jump to a copy and pastable code snippet
to put into your```.vm```, <a
href="#complete-dot-vm">jump to this section</a>. If you'd
like a run through of the different settings, you can read on
:-)

## VM basics

These are the settings I use for basic things like VM
appearance and basic behaviour.

## Reading your GMail inbox
## Sending your mail using GMail

These are the settings I use for sending email through the
GMail SMTP server, however, these settings can of course be
applied to other SMTP servers too, it's mostly a matter of
figuring out the server, the port and the authentication
method used by the SMTP server and put those into Lisp/VM
friendly phrases in your```.vm```

<h2><a name="complete-dot-vm">To sum it up</a></h2>

These are all the settings I use to send and receive mail
using my GMail account.

## Install VM from Source

Since I really wanted the latest version of VM, I installed it
from source rather than using the pre-prepared package from my
distribution. It's really easy, though:

### Download the tarball

Head over to <a href="https://launchpad.net/vm">VM's page on
Launchpad</a> and download the tarball.

### Extract, build and install it

Since I've got several Emacsen on my computer, I specified
which the build file should use for compailing
against.```/usr/bin/emacs``` is the standard one,
installed with the```emacs23``` Debian package.


Before installing VM, I had already installed the <a
href="http://packages.debian.org/squeeze/emacs23">emacs23</a>
(of course), <a
href="http://packages.debian.org/squeeze/bbdb">bbdb</a> (for
automagic address book), <a
href="http://packages.debian.org/squeeze/w3m-el">w3m-el</a>
(for displaying HTML email - and surfing inside Emacs if you
fancy it) and <a
href="http://packages.debian.org/squeeze/stunnel4">stunnel4</a>
(for reading and sending messages securely using SSL)
packages. I.e.:

    # apt-get install emacs23 bbdb w3m-el stunnel4


With that out the way, you're ready to get smashing with VM:


    $ cd /tmp
    $ tar xzf vm-8.2.0a-gnu23.tgz
    $ cd vm-8.2.0a
    $ ./configure \
--with-other-dirs="/usr/share/emacs/site-lisp/bbdb/lisp;/usr/share/emacs/site-lisp/w3m"\
--with-emacs=/usr/bin/emac
    $ make
    $ su -
    # make install


That's it, you can now continue to the top of this article to
add VM to your load path and set up the email connectivity.

