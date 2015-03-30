title: Formatting Python Dates According to Locale
date: 2015-03-30
tags:  python, locale
category: python

When you want format a date in a language/locale specific manner, you
can use Python's standard
[locale](https://docs.python.org/2/library/locale.html)
module. [locale](https://docs.python.org/2/library/locale.html) uses
the underlying OS' locale features. If you're familar with how UNIX
handles locales, you'll be right at home with Python.

For instance, for displaying formatted dates in Norwegian, you'll need
to have that locale installed on your machine. For a
[Debian](http://debian.org) or [Arch](http://archlinux.org) based
system, this means making sure `nb_NO.utf8` is enabled in
`/etc/locale.gen` and then runnnig `locale-gen`:

```
# vim /etc/locale.gen
# locale-gen
$ locale -a | nb_NO
nb_NO.utf8
```

If you now start a new shell, you should be able to list and use the
new `nb_NO.utf8` locale. In the example below, the default locale is
`en_GB.utf8`, so the `date` command says "Mon" for "Monday", whereas
it says "ma." for "mandag" when I specify the Norwegian locale:

```
$ date
Mon 30 Mar 18:36:56 CEST 2015
$ LC_ALL=nb_NO.utf8 date
ma. 30. mars 18:36:42 +0200 2015
```

With this in place, we're ready to get locale/language formatted dates
in Python:

```
#! /usr/bin/env python3
import locale
import datetime

d = datetime.datetime(2015, 11, 15, 16, 30)

locale.setlocale(locale.LC_ALL, "en_GB.utf8")
print(d.strftime("%A, %d. %B %Y %I:%M%p"))
'Tuesday, 15. November 2015 04:30pm'

locale.setlocale(locale.LC_ALL, "nb_NO.utf8")
print(d.strftime("%A, %d. %B %Y %I:%M%p"))
'tirsdag, 15. november 2015 04:30'
```


