title: Creating a New Document Using AJAX
date:    2012-10-07
category: db
tags: couchdb

The couchapp framework comes with some excellent libraries for
managing your Couch DBs. If you're developing a couchapp, the
URIs to the needed JS will be along the lines:

    <script src="/_utils/script/json2.js"></script>
    <script src="/_utils/script/jquery.js"></script>
    <script src="/_utils/script/jquery.couch.js"></script>

To create a new document, you can then just do:

    <script type="text/javascript">
      var hitData = {
      "publication_id" : "1",
      "content_id" : "66",
      "section_id" : "22",
      "created_at" : "",
      "uri" : "/hit.html"
      };

      var $db = $.couch.db("memento");
          $db.saveDoc(hitData);
    </script>

