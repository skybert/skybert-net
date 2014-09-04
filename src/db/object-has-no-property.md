title: Creating CouchdDB documents yields strange "lib" exception
date:    2012-10-07
tags: couchdb
category: db

I was puzzled about this exception I got when calling
n
    $db.createDoc(myArray);


I got this error message in my browser and couchdb debug log
(```/var/log/couchdb/couch.log```):


    The document could not be saved: Object has no property "lib".

    {"_id":"_design/memento","_rev":"45-2ea48ca87e0763f81adec1bd7c4b0224","vendor":
    {"couchapp": {"evently": {"profile": {"profileReady":
    {"after":"function(e, p) {\u000a $$(this).profile =

    [... continuing for 100s of lines ...]


I was further puzzled that executing the "Compact & Cleanup..." tools
in Futon seemed to (temporrarily) remedy the problem. However, I got
this error promptly back in my face so I had to find the cause of it.


It turned out that the include line in my ```validate_doc_update.js```
was pointing to a non existing library. Since this Javascript is run
on each create, update & delete operation, it failed with an (awfully
long and garbled) error message.

Thus, look out that the include lines in ```validate_doc_update```
exists relative to where the script itself resides. In my case, I had
to change

    var v = require("lib/validate").init(newDoc, oldDoc, userCtx, secObj);

to:

    var v = require("vendor/couchapp/lib/validate").init(newDoc, oldDoc, userCtx, secObj);

