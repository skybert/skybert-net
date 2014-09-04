title: Flushing Varnish from the command line
date:    2012-10-07
category: unix
tags: varnish, http, performance

This will purge everything from the cache on Varnish
3.x. For Varnish 2.x, use```purge.url``` instead of
```ban.url```

    $ varnishadm -T :6082 "ban.url /"


Strictly speaking, this will not flush everything
immediately, but will instead come into effect for all
consecutive requests to your cache. But these are just
techincal pernicketies, in practice, you can think of this
as flushing your cache, partially or entirely.


The argument to```ban.url``` is a "contains" regular
expression, so if you e.g. just want to purge
```somepicture.jpg```, you can just pass
```somepicture.jpg``` to the Varnish command.

