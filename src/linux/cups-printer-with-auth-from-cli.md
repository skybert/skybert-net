title: Printing to a Windows Printer from the Command Line
date: 2017-11-13
category: linux
tags: linux, printing, cups

```
$ smbclient -W MYWORKGROUP -U <user> //printer.company.com/printer-queue-name -c "print my.pdf"
Enter user's password: 
Domain=[MYWORKGROUP] OS=[Windows Server 2012 R2 Standard 9600] Server=[Windows Server 2012 R2 Standard 6.3]
putting file my.pdf as my.pdf (381.3 kb/s) (average 381.3 kb/s)
```


