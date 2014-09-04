title: fortune cookies
date:    2012-10-07
category: unix

Getting random quotes on Unix is <em>so</em> easy. Just install
the```fortune``` program. On Debian it's installed
in```/usr/games/fortune``` instaed of ```/usr/bin```, so be sure to
have ```/usr/games``` in your PATH variable.


Once it's there, you can just call it with ```fortune```. You'll get a
new, random quote each time you call it. It's easy to combine this
with your email client, adding a quote to the email signature or your
web page by wrapping it in a CGI script, like I've done here:

