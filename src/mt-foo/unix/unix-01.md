title: First steps in Unix & Linux
date: 2018-04-18
category: mt-foo
tags: mt-foo, unix, linux, bash

Welcome into the wonderful world of Unix. For simplicity's sake, we
can say that Unix and Linux are the same thing.

## Different types of users 👨‍👩‍👧‍👦

There are two kinds of users on Unix, the `root` user and regular
users. The `root` user is the equivalent of the `Administrator` on
Windows. It is allowed to do everything. Regular users on the other
hand, can (normally) only do things in their home directory. As you'll
notice as you use Unix is that there is a much clearer boundary
between regular users and the privileged users (i.e. `root`).

In code examples, `#` means: __Run this command as the root user__.

Whereas the `$` means: __Run this command as a regular user__. Lines
that neither start with a `$` nor a `#` are output from the command
above.

Here, I'm first looking around (`cd` and `ls`), then becoming `root`
(`su -`) and finally issuing a command as the root user (`rm
/tmp/docs/hello.txt`):

```text
$ cd /tmp/docs
$ ls
hello.txt
world.txt
$ su -
# rm /tmp/docs/hello.txt
```

If you ever wonder who you are, you can ask Unix:
```text
$ whoami
john
```

## No news is good news
A big difference from Windows and macOS is that Unix doesn't say
anything if the it succeeds. It only says something if something
__doesn't work__.

For example, here I'm removing a directory and then I'm trying to
remove it again. The first `rm` succeeds (no output) whereas the
second fails (has output):

```text
$ rm -r /tmp/music
$ rm -r /tmp/music
rm: cannot remove '/tmp/music': No such file or directory
```

## Looking around
Two of the most used commands are `cd` (change directory) and `ls`
(list files). Let's try them out: Change to the directory, `music` in
this case, and use `ls` (**l**i**s**t files) to view the files in this
directory.

```text
$ ls
music
$ cd music
$ ls
if_i_was_your_mother.mp3
```

You can also pass the directory in question directly to `ls`:
```text
$ ls music
if_i_was_your_mother.mp3
```

`ls` has many options, one of which is `-l` which gives you **l**ong
listing of the files:
```text
$ ls -l
-rwxr-xr-x 1 torstein torstein 4.1M Apr 18 13:29 if_i_was_your_mother.mp3
```


## Removing a file 📚

```text
$ rm file.txt
```

If it is a directory, we must add the `-r`ecursive flag to the
command:

```text
$ rm -r music
```

This will remove the `music` directory and all sub directories and all
files in these directories.


## Finding a file by name 🔍

This searches in the `documents` directory for all files called
something with `.txt`:
```
$ find documents -iname "*.txt" 
documents/travel/holiday-plans.txt
documents/finance/shops.txt
```

The star (or asterisk) is magical, it means __anything__. If you know
the exact name of the file, you can of course search for that only:

```text
$ find documents -iname "shops.txt"
documents/shops.txt
```

## Finding a file by its contents 🔍

Sometimes you want to find all text files containing a certain
string. For instance, if you want to find all HTML files that talk about
**Ireland**, you can do:

```text
$ grep Ireland *.html
booking.html:      Ireland is a popular destination.
shipping.html:      Shipping to Ireland costs 200 dollars more than to England.
```

`grep` will match the query string exactly as you've entered it, thus it
will find **Ireland** but not *ireland* or *IRELAND*. To make it
ignore the case of the letters, add the `-i` option (**i**gnore):

```text
$ grep -i ireland *.html
booking.html:      Ireland is a popular destination.
lower.html:       Everyone talks about ireland.
shipping.html:      Shipping to Ireland costs 200 dollars more than to England.
```



## Reading the documentation 📖

This is the trick to become good at Unix, learn to read the `man`
pages.  Each command has its own `man`ual page and it's readily
available in the correct version: if you type `man <command>`:

```text
$ man rm
```

The above will show you the `man`ual page for the `rm` command you
used above. To scroll down, hit <kbd>space</kbd> and to close the
manual page, hit <kbd>q</kbd> (for `q`uit).

To read the `man` page in a different language, use the `-L`
parameter. Here, we're viewing the `rm` man  pages in Italian:


```text
$ man -Lit rm
```

Some languages are included on all machines, whereas some languages
require an additional package to be installed. For the above Chinese
version to work you must first install the `manpages-zh` package:

```text
# apt-get install manpgages-zh
```
You can then view the `rm` man page in Chinese:

```text
$ man -Lzh_CN rm
```
