title: The World is Mean, So Your Load Tests Must Be Meaner
date: 2025-02-11
category: craftsmanship
tags: craftsmanship, testing, unix

It's amazing how your backend service works fine when testing it with
curl, postman or a frontend GUI, but fails all over the place when
unleashing a mean load testing tool like
[siege](https://www.joedog.org/siege-manual/) on it:

- DB pool exhaustion
- HTTP connector settings out of sync with other components
- Integrations with 3rd party systems stall
- Basically, with any scarce resource you thought the app would
  recycle when you write `connection.close()`, will potentially come
  back and bite you since your app spends longer _actually_ closing it
  than what you assume in your code.

The world is mean, so prepare your app by using a mean testing
tool. My favourite is
[siege](https://www.joedog.org/siege-manual/). In addition be an
excellent and scriptable shell command, it can sustain heavy load
creation much better than e.g. [JMeter](https://jmeter.apache.org/),
which I've on several occations seen freeze up when the going gets
rough.

- Allows you to create a URI file with all HTTP operations, including
  POSTing JSON.
- Allows passing as many HTTP headers as you want (so, including auth
  with bearer tokens).
- And last, but not least, it works on any platform, any server.

Here's a non-trivial example of using
[siege](https://www.joedog.org/siege-manual/) for testin both read and
write performance of a backend system:

```perl
$ siege \
    --concurrent=255 \
    --time 10S \
    --header="Authorization: Bearer eyhunter2.." \
    --header="X-Important-Id-For-App: foo-bar-baz" \
    --content-type=application/json \
    --json-output \
    --benchmark \
    --internet \
    --no-parser \
    --file /tmp/load-test.siege
```

The contents of `/tmp/load-test.siege`:
```perl
# Service discovery document, generated so can be expensive
http://localhost:8000/openapi.json

# Read book
http://localhost:8000/book/1

# Read a thousand books
http://localhost:8000/book/?count=1000

# Create book
http://localhost:8000/book POST {"title": "The Iliad", "author": "Homer"}

# Create library
attic_name="My loft"
http://localhost:8000/library POST {"name": "The Attic called ${attic_name}"}
```

As you can see in the library example, `siege` has rudimentary support
for variables too. Read the fine manual with [man
siege](https://man.archlinux.org/man/siege.1.en) and learn further
details about this excellent tool.

Happy load testing!

