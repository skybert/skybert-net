title: Finding Missing Images After Migration
date:    2012-10-07
category: escenic

Pictures in Escenic Content Engine consist of two things: a
content item with fields for meta information. This content
item is what you search for in Content Studio and what you can
desk on your pages and relate to your articles.


These content items live in the database. However, the image
files themselves live on the file system of the server running
the ECE. There is one original image, typically stored under

```
/var/lib/escenic/engine/binary/2012/5/16/19/mypicture.jpg
``` and several generated image versions, typically stored
under
```
/var/cache/escenic/images/mypub/145/incoming/article594308.ece/ALTERNATES/w300/mypicture.jpg
```


Now, if you've imported a DB dump from another system and
don't have the corresponding picture files so the server can
find them, ECE will return status code```500``` (yes,
not 404 as this is considered an inconsistent state of the
system, take the discussion on <a
href="http://forum.vizrt.com">forum.vizrt.com</a>


To find all images on a given page which return
```500``` and thus are missing after a DB import, I do:

```
$ curl -s http://mysite.com/ | \
sed 's#&gt;&lt;#&gt;\n&lt;#g' | \
grep "&lt;img" | \
cut -d'"' -f2 | \
grep ^http | \
while read f; do  \
if [ $(curl -s -I $f | grep "HTTP/1.1 500" | wc -l) -gt 0 ]; then
  echo $(basename $f); fi  ;
done
```


The next step, is to go on the system which has all the
picture, find these pictures and```rsync``` them over
to the new system.
