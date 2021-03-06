title: Some lessons learned regarding CouchDB and disk usage
date:    2012-10-07
tags: couchdb
category: db

I started by using siege to post 1000s of documents with 14 fields &
values (the actual data my application will be using) and let it run
till I got a fair data set. After reducing the now ~710,000 document
big DB from 4.2GB to ~360MB, the "most popular articles on this
section within this time period" queries went from ~8s to
~0.05s. Fantastic.


I then unleashed siege again (100 parallel threads this time, creating
200 new documents each using the bulk endpoint (siege somehow didn't
want to work with my initial 1000 document big .json file, so I had to
reduce it to 200 to make siege not choke on it)) and wget (creating
random data, using the normal document endpoint), the queries
immediately started to climb upwards, 1s, 2s, 3s ... 80s and with no
sign of stopping.


To see if it was the simultaneous write and read that were causing the
longer query times, I stopped siege and wget on my test machine
(different host, going through the same network switch).


Since there had been quite a number of new documents, couch started
its checkpoint view updating leaving my couch unable to respond to any
queries for around 90s.


The query times then dropped down, stabilising on 0.06 to 0.08s when
querying the DB with now ~800,000 documents and result sets containing
~50 section IDs with ~2000 hits each. Great!


The climbing query times when doing so many updates is not a real
concern for me as I'll put a queue in front of couch which buffers up
the incoming write requests and fires up a bulk update every 30
seconds or so. As I wrote in my previous post, Couch seems more than
fast enough write-wise as long as the documents are provided in bulks.

<!-- It's possible to request stale data.

What does worry me, though, is that couch doesn't answer any query
while it's doing its view updates. Even with a nice cache server in
front which can serve old content till couch is finished updating its
views, I still find it a bit unsettling.

-->

The good news from my tests is that contrary to what I've heard
before, it does pay off to compact the database even though you only
have one revision per document. Choosing to compacting the database it
went from 4.2GB to ~360MB

