date:    2012-10-07
category: unix
title: RipIT
tags: music

For as long as I can remember, <a
href="http://nostatic.org/grip">Grip</a> has been my choice for
ripping audio CDs and encoding them as either Ogg Vorbis, flac
or MP3. However, today (2011-09-06), I discovered taht grip was
no longer available in Debian (my other machines still has it
installed since it's a couple of years since I installed their
OS afresh). Hence, I had to look for something else and <a
href="http://www.suwald.com/ripit/news.php">ripit</a> caught my
eye.


After a bit of reading in <a
href="http://www.digipedia.pl/man/doc/view/ripit.1/">its manual
pages</a>, I got it do do what I want: lower case file names,
underscores instead of spaces, output in my desired folder where
the album is a sub directory of the artist directory, easy
ripping and encoding using the Ogg Vorbis codec.


I'll probably do some more experimenting with it, but this line
got me what I wanted:

```
$ ripit -l \
  -u \
  -g Folk \
  -y 2011 \
  -o ~/music/ \
  --dirtemplate '"$artist/$album"'
```

As you might have guessed, the```-g``` and
```-y``` options are only necessary when those music meta
data cannot be fetched from CDDB, hence, you can normally omit
those.

