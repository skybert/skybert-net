title: Testing the Write Performance of CouchDB
date:    2012-10-07
tags: couchdb, performance
category: db

First off, I had <a
href="/bytes/2011/05/16/using-siege-to-test-the-write-performance-of-couchdb">to
get Siege to send the correct content type header</a>. Once
that was out of the way, I could go ahead and do my tests :-)


To conduct the tests, I created a```.json``` file with a typical
document I would use in my application:

    {
      "action_type_id" : "1",
      "content_id" : "123",
      "type" : "slideshow",
      "created_at" : "2011-05-16 12:42",
      "publication_id" : "3",
      "referrer" : "http://mysite.com/add/slideshow/to/one/of/these/blogs",
      "section_id" : "12",
      "target_content_id" : "132",
      "target_content_type" : "blog",
      "target_section_id" : "22",
      "target_user_id" : "44",
      "title" : "The title of the blog 123",
      "uri" : "/blog/123",
      "user_id" : "12"
    }



I then created a```.siege``` file for my beloved load testing tool to
use. It contained ony one line:

    http://127.0.0.1:5984/mydb POST < mydb_entry_example.json


I then unleashed siege:

    $ siege -c 100 -f mydb_entry_example.json.siege


The above gave me (running this locally, so network latency,
DNS lookup and so on, is not included here):

    Transactions:       76700 hits
    Availability:      100.00 %
    Elapsed time:      393.84 secs
    Data transferred:  6.95 MB
    Response time:     0.01 secs
    Transaction rate:  194.75 trans/sec
    Throughput:        0.02 MB/sec
    Concurrency:       2.82
    Successful transactions:       76700
    Failed transactions:           0
    Longest transaction:           0.20
    Shortest transaction:          0.00


In general, I found that couchdb could not sustain write load
over time when siege runs with much more than 100 concurrent
sessions. Cranking the number of concurrent TCP sessions,
yielded time outs and long error messages in the couchdb:

    [Mon, 16 May 2011 07:30:17 GMT] [error] [<0.20137.2>] Uncaught error in HTTP request: {exit,
    {timeout,
    {gen_server,call,
    [couch_query_servers,

## Testing CouchDB bulk update

To test CouchDB's bulk update entry point, you have to create
a container document which holds all the documents. This was
easily done with these three lines of BASH:

    $ echo '{"docs":[' > mydb_entry_example-bulk.json
    $ for i in {1..100}; do cat mydb_entry_example.json >> mydb_entry_example-bulk.json ; done
    $ echo ']}' >> mydb_entry_example-bulk.json


Remember that the container document "docs", also needs to pass the
input test of fields required by your application that you may have
fined in your ```validate_doc_update``` hook.


I created a```.siege``` file like the one for the normal updates:

    http://127.0.0.1:5984/mydb/_bulk_docs/ POST < mydb_entry_example.json


I could then run my bulk update tests, first a simple one
using```wget```:

    $ time wget -o /dev/null \
      -S \
      --header "Content-type:application/json" \
      -O /dev/null \
      --post-file=mydb_entry_example-bulk.json  \
      http://127.0.0.1:5984/mydb/_bulk_docs/

    real0m2.272s
    user0m0.004s
    sys0m0.000s

Interestingly enough, there was no time difference creating 100
documents this way or 1000. The reason why I kept the document at 100,
was that otherwise couchdb woud throw ```400``` error messages when
siege was unleashed on it.

Running siege was like before, just with different inut
parameters:

    $ siege -c 30 -f  mydb_entry_example-bulk.json.siege

Lifting it after a while gave these results:

    Transactions:        7328 hits
    Availability:      100.00 %
    Elapsed time:     1132.70 secs
    Data transferred: 59.42 MB
    Response time:    1.04 secs
    Transaction rate: 6.47 trans/sec
    Throughput:       0.05 MB/sec
    Concurrency:      6.74
    Successful transactions:    7328
    Failed transactions:        0
    Longest transaction:        1.76


These wee tests shows taht using bulk updates improves the CouchDB
wirte performacne and (locally on my system) suggests something
like```100 * 6.47 = 647``` writes per second, which isn't that bad :-)
As hinted at above, these numbers would probably have been better if
siege didn't choke on documents of a certain size (I initially ran it
with 1000 document big```.json```).

