title: Using CouchDB from the Command Line
date:    2012-10-07
category: db
tags: couchdb

To post an antry to my couch using```wget```:

    $ wget -S \
      --header "Content-type:application/json" \
      -O - \
      --post-data '{"created_at" : "'`date --iso-8601`'", "publication_id" : "3", "content_id" : "45", "section_id" : "77" }'  \
      http://127.0.0.1:5984/memento/


## I've found curl to be less co-operative

    $ curl \
      'http://127.0.0.1:5984/memento/_design/memento/_view/most-popular-on-section?startkey=[%223%22,%2277%22,%2223%22]&endkey=[%223%22,%2277%22,%2224%22]'
    curl: (3) [globbing] illegal character in range specification at pos 87


Running the same with```wget``` works.

