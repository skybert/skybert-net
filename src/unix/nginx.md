title: nginx
date:    2012-10-07
category: unix
tags: http

## Building from source

I needed the following development headers:

```
# apt-get install \
libncurses5-dev \
libpcre3-dev \
libreadline6-dev \
libssl-dev \
zlib1g-dev
```

When developing web sites with nginx, it's useful to have debug
enabled. As normal, I wanted self compiled software to go
in```/usr/local```

    $ cd ~/src/ngx_openresty-1.0.15.10
    $ ./configure --prefix=/usr/local --with-debug


## Debugging the srcache storage

Turn on debug in your```nginx.conf```:

    error_log  logs/error.log debug;


Then, you can grep for srcache in the error log (be sure to
turn this one off as it'll grow quite large):

```
$ tail -f logs/error.log
19612#0: *194 srcache_fetch decides to send the response in cache
19612#0: *194 srcache_fetch status line done
19612#0: *194 srcache_fetch header done
19612#0: *199 srcache_fetch: subrequest returned status 404
19612#0: *199 srcache_store bypassed because of unmatched status code 404 with srcache_store_statuses
```

## See all compiled-in features of your nginx

To see all the options that are compiled into your
```nginx```, pass the
```-V``` option to the
(sbin) binary:

```
$ nginx -V
nginx version: ngx_openresty/1.0.15.10
built by gcc 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
TLS SNI support enabled
configure arguments:
--prefix=/usr/local/nginx
--with-debug
--with-cc-opt=-O0
--add-module=../ngx_devel_kit-0.2.17
--add-module=../echo-nginx-module-0.38rc2
--add-module=../xss-nginx-module-0.03rc9
--add-module=../ngx_coolkit-0.2rc1
--add-module=../set-misc-nginx-module-0.22rc8
--add-module=../form-input-nginx-module-0.07rc5
--add-module=../encrypted-session-nginx-module-0.02
--add-module=../ngx_lua-0.5.0rc30
--add-module=../headers-more-nginx-module-0.17rc1
--add-module=../srcache-nginx-module-0.13rc8
--add-module=../array-var-nginx-module-0.03rc1
--add-module=../memc-nginx-module-0.13rc3
--add-module=../redis2-nginx-module-0.08rc4
--add-module=../redis-nginx-module-0.3.6
--add-module=../upstream-keepalive-nginx-module-0.7
--add-module=../auth-request-nginx-module-0.2
--add-module=../rds-json-nginx-module-0.12rc10
--add-module=../rds-csv-nginx-module-0.05rc2
--with-http_ssl_module
```

## Confusing srcache error message

I was very confused by this error message in the srcache module:

```
2012/07/13 12:26:50 [error] 18942#0: *145 srcache_store: skipped
because response body truncated: 54707 > 0 while sending to client,
client: 192.168.56.1, server: localhost, request: "HEAD /app/sports/
HTTP/1.1", upstream: "http://127.0.0.1:8080/app/sports/", host:
"myapp"
```

The explanation was simply that the HTTP request was ```HEAD``` and
the response body naturally was shorter (empty) than the declared
content length. How logical everything is when you know the answer...

