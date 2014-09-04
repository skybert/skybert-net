title: Things I strongly dislike when developing software.
date:    2012-10-07
category: craftsmanship


## Developers that doesn't use the project build tool

Developers that doesn't use the project build tool because
the software "compiles in their IDE". Useful articles: <a
href="http://www.onjava.com/pub/a/onjava/2001/02/22/open_source.html">
onjava.com article
</a>

## People that do not quote their emails and news postings

Very few people these days knows the good practice of
quoting. Proper email quoting makes all email correspondence
easier and makes it possible to keep the overview of email
discussions with multiple participants. Email quoting is
described in RFC1855 (Netiquette Guidelines) and
<a href="http://www.massey.ac.nz/~tameyer/writing/quoting.html.">
a good overview on the topic can be read her.
</a>


The only email client that doesn't support quoting per
default is also the wold's most used one, namely Microsoft
Outlook. The ,
<a href="http://home.in.tum.de/~jain/software/outlook-quotefix/">
Outlook-Quotefix program
</a>
looks promising for Outlook users seeking to join the crowd
of net-etiquette concious people.

## Lines longer than 80 characters

I ususally stick to 72,
but 80 is an absolute maximum! Especially Window$ users
like to have their editor window maximised and "must"
therefore use the full width.

## Inconsequent coding style

Some people just don't have a clue what they're doing, they just write
some code. You can't in one stanza write <code
style="background-color:#cccccc">if<span
style="background-color:yellow">&nbsp;</span>(true)<span
style="background-color:yellow">&nbsp;</span>{```, then in the next
<code style="background-color:#cccccc">if(true){``` and then in the
third test <code style="background-color:#cccccc">if(<span
style="background-color:yellow">&nbsp;</span>true<span
style="background-color:yellow">&nbsp;</span>)<span
style="background-color:yellow">&nbsp;</span>{```.  It's ok to
disagree on coding style; but please be consequent!

## Inconsequent name giving

Again, some developers just don't care, sometimes a```LinkedList```
instance is called```linkedList``` and the ```MySuperDuperClass```
instance is called ```mc```. Either write long names (which I prefer)
or write short names or write minimalistic names. But be consistent!

## Tabs instead of spaces

Makes the code look different where you view it. A lot of developers
doesn't know there is a difference. All they know, is that it works
"on their computer".

## HTML and XHTML code that doesn't validate

Almost noone knows how to write proper X/HTML, which is ironic as it's
<em>so</em>. Thanks to very forgiving browsers, most
developers/designers don't care (and know) how to make the pages
validate. <a href="../../webdesign/how-to-write-html">I've written a
page on this topic</a> as it has frustrated me many times.

