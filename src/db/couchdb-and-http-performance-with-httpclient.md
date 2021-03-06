title: testing the performance CouchDB
date: 2012-10-07
category: db
tags: couchdb

When testing the performance CouchDB it's apparent that the main
hurdle here, is the HTTP create + tear down. Hence, anything that can
re-use the HTTP connections will boost performance.

I did some tests on what it meant for performance that I changed
various things in my <a
href="http://hc.apache.org/httpcomponents-client-ga/">HTTP client
setup</a> and the findings were all not that cheerful
- albeit interesting.  no real difference between using
multi threaded <a
href="http://hc.apache.org/httpclient-3.x/apidocs/org/apache/commons/httpclient/HttpConnectionManager.html">HttpConnectionManager</a>
and the standard one (when running against one host) as
HTTPClient will still re-use the client's connection if the
consecutive request goes to the same host (yes, even if
you've called <a
href="http://hc.apache.org/httpclient-3.x/apidocs/org/apache/commons/httpclient/HttpConnectionManager.html#releaseConnection(org.apache.commons.httpclient.HttpConnection)">releaseConnection</a>).


I gained at least one second (down from 8.5 to 7-8 seconds) by
replacing```HttpMethod.getResponseAsString```
with```HttpMethod.getResponseAsStream```, using <a
href="http://commons.apache.org/io/apidocs/org/apache/commons/io/IOUtils.html">
commons-io/IOUtils </a> to consume it.


There was no real gain to use many threads fetching
statistical data in concurrent threads as the main bottle
neck was the initial GET of statistical data.


CouchDB doesn't support gzip encoding of the content. When
querying large datasets, this becomes a problem.


Putting nginx in front which did gzipping of the
content. This turned out not to help significantly, running
pure curl from the command line only showed a mere ~2 second
improvement from 7 to over 5 second. The total running time
including Java space (single connector).


In Java space, it was a nice discovery that HTTP client 4.x
has built in support for gzip (if you use a certain
implementation of HttpClient), the sad thing about it is
that the API has changed quite a bit from 3 to 4 and it'll
take you a mouthfull to change your code to use it.

