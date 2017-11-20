title: Using a Windows Printer from the Command Line
date: 2017-11-13
category: linux
tags: linux, printing, cups

Getting a Windows network printer to work from Linux can be
difficult. That is, it normally works just fine, but if it doesn't
work, using the CUPS interface at
[http://localhost:631](http://localhost:631) or the graphical
`system-config-printer`client is tedious.

Recently, I had the case that the IT department had changed the
addressing scheme for a network printer and our old configuration,
both on macOS and Linux didn't work.

Testing printing from the command line was a lot easier to try out all
the different combinations with work groups, hostname and queue
name. Besides, it's fiddly to set user credentials in both standard
CUPS (you put it in the URL) or in the graphical client (illogical sub
dialogues, removes context++).

Turns out, the CLI is the most userfriendly and powerful interface of
them all. 

To print a local file called `my.pdf` on a Windows printer with
hostname `printer.company.com` on the queye called
`printer-queue-name` which is in the Windows work group `<workgroup>`
and requires Active Directory credentials for `<user>`, do:

```
$ smbclient \
  -W <workgroup> \
  -U <user> \
  //printer.company.com/printer-queue-name \
  -c "print my.pdf"
Enter user's password: 
Domain=[MYWORKGROUP] OS=[Windows Server 2012 R2 Standard 9600] Server=[Windows Server 2012 R2 Standard 6.3]
putting file my.pdf as my.pdf (381.3 kb/s) (average 381.3 kb/s)
```

On Debian based systems, the `smbclient` can be installed with:
```text
# apt-get install smbclient
```

Happy printing!
