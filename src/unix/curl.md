date:    2012-11-29
category: unix
title: Some of My Favourite curl Tricks
tags: bash, rest

## PUTing a file with curl

The most important parameters for PUTing a file are
```-T``` for the file and <cite>-X</cite> to specify
the```PUT``` HTTP method.

```
$ curl -I \
-u user:pass \
-T /tmp/user.xml \
-X PUT \
-H "Content-Type:application/atom+xml;type=entry" \
-H "If-Match:*"
http://myserver.com/users/id/10
```


Of course, it might be that you don't need the headers I
needed here, or that you need different ones. <cite>-H</cite>
is how you specify them in any case.

## Seeing what a site looks like as an iPhone

To see what the site looks like as a particular user agent,
e.g. an iPhone, you can do the below. I find this very useful
for testing the mobile version of web sites I'm developing.

```
$ curl \
  --header "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" \
  --dump-header - \
http://mywebsite.com/
```


I also add```--dump-header -``` to see the server
response headers, essential when setting up servers and
developing web applications :-)

## Working with PAC files

As far as I know, neither```wget``` nor
```curl``` has PAC support since PAC is implemented in
JavaScript and neither of the command line tools know anything
about that.


But fear not! There's a pretty good solution. It's possible to
both get PAC based HTTP proxy configuration, proxy password
protection and digest autentication working with your
favourite command line web ciient.


First, set the```http_proxy``` variable to the proxy
server that your PAC file resolves too. If your PAC offers
several proxies depending on the requested URL, you have to
script around it. There's```libproxy-tools```, but I
couldn't get it to work, hence, I just update the
```http_proxy``` variable whenever I need it:

    export http_proxy=http://&lt;user&gt;:&lt;password&gt;@proxyserver:&lt;port&gt;


If your proxy is using digest based authentication instead of
basic authentication, you must pass the
```--proxy-digest``` flag to curl.


The hostname you want to access does not need to be resolvable
by your local host, it's enough that it's resolvable by the
machine running the web proxy:

    $ curl --proxy-digest http://internal.mycompany.com/


If you look at the response headers, you'll see that
```curl``` needs to make two requests, one to get the
challenge from the proxy server, and one to let through the
request to the backend.


So there you are, you're now (almost) free from the shackles of
corporate world HTTP limitations!

