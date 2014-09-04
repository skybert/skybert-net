date:    2012-10-07
category: unix
title: Some of My Favourite wget Tricks
tags: http, network, performance

## Simple Load Testing with wget

To do a <em>simple</em> load test,```wget``` can be used
like this to download full pages, recursively (depth five) and
repeat everything 30 times. This simple load test is a useful
starting point to iron out the most obvious performance
issues.


Once this doesn't pose any problem, time is ripe to start using more
serious stress testing tools like <a
href="http://www.hpl.hp.com/research/linux/httperf/"> httperf </a> and
<a href="http://www.joedog.org/index/siege-home"> siege </a>

```
$ for i in $(seq 30); do
    wget -o /dev/null \
    -p \
    http://mysite.com \
done
```


## Populating Your Caches with wget

This is how I populate my caches, both application caches,
distributed memory caches and cache server caches are simply
populated with```wget```. This will traverse the site
recursively with the default depth```5``` and delete the
files after downloading them.


```
$ wget -o /dev/null \
  -r \
  --delete-after \
  http://mysite.com
```

Please note that if you give```/dev/null``` to the```-O``` parameter
(big 'o'), ```--delete-after``` actually remove the```/dev/null```
file - if your OS and user rights allow it! The command above is safe,
though. Just wanted to warn you as I've done this mistake before ;-)

## Timing Your Site Delivery Time

This is how I time the delivery time of the web sites. It's
important to time it many times, as you may hit the server(s)
at the bad time when they're doing garbage collections,
invalidate their caches etc. Thus, I always to 10 fetches to
determine the delivery speed:


```
$ for i in $(seq 30); do
  time wget -p \
  --delete-after \
  -o /dev/null \
  http://mysite.com/
done
```


