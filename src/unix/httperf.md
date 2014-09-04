date:    2012-10-07
category: unix
title: Some of My Favourite httperf Tricks
tags: performance

Performance testing a site with the same traffic pattern that
the site is actually getting from users is a huge plus. To do
this, we first ask Varnish to create an access log for us to
play with:

```
$ varnishncsa -d | \
  awk '{print $7}' | \
  tr "\n" "\0" \
  > /tmp/access_log-$(date --iso).httperflog
```


This httperf log can then be used to re-play the user traffic
when running httperf.

```
$ httperf \
--server example.com \
--wlog=y,/tmp/access_log-2012-06-04.log.httperflog \
--num-conns=2000 \
--rate=20 \
--num-calls=30 \
--hog
```

This will make```httperf``` set up ```2000``` TCP connections,
creating```20``` of them each second until it reaaches```2000```. It
will then make ```30``` requests (calls) inside each TCP connetions,
selecting a new URI from the httperf log file each time. When it
reaches the bottom of the file, it will start at the top (that's
the```y``` parameter). Lastly, it's agressively```hog```ging all the
TCP connections (i.e. local ports) it needs to get to```2000``` TCP
connetions.


Of course, you probably want to run```httperf``` from a different host
on a different network.

