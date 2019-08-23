title: How to debug the Escenic search
date: 2019-08-23
category: escenic
tags: escenic

There are quite a number of components to investigate when search
isn't working in Escenic Content Engine / CUE Content Store. Here are
some of my notes on the subject and I hope it'll be of assistance to
brave consultants, admins and developers out there 😉

> I have created a content item with id `11`, but it doesn't show up
> in CUE when I search for it.

## Is the content item scheduled for indexing?

```sql
MariaDB [ecedb]> select * from SearchIndex where objectID=11;
+------------+----------+------------+---------------------+-----------+--------+--------------------+------+--------------------------------------+
| documentID | objectID | objectType | entryUpdated        | isDeleted | isTail | protectionDomainID | misc | uuid                                 |
+------------+----------+------------+---------------------+-----------+--------+--------------------+------+--------------------------------------+
|         25 |       11 | article    | 2019-08-23 17:28:31 |         0 |      0 |                  1 | NULL | 49b94a4e-9490-483e-a442-620cb31f1385 |
+------------+----------+------------+---------------------+-----------+--------+--------------------+------+--------------------------------------+
```

## Is it indexed in Solr?
My content item has `Store` in its title, so I perform a Solr search
for all documents that have `Store` in their title:

```text
$ curl 'http://debbie:8983/solr/editorial/select?q=title:Store&wt=json'
```

## What does the indexer-webapp say?

Head over to the web interface at
http://debbie:8180/indexer-webapp/admin and check that:

- The URI for the `indexer-webservice` is correct. This is where the
  `indexer-webapp` gets information about new items that should be
  indexed, e.g.  http://localhost:8080/indexer-webservice/index/ 
- The URI for the Solr web API is correct. This is where it will post
  new Solr documents (transformed from the documents it got from the
  `indexer-webservice`, e.g. http://debbie:8983/solr/editorial/update/

## What does the indexer state file say?

```text
$ cat /var/lib/escenic/engine/head-tail.index 
#Tue Jul 02 21:05:51 CST 2019
com.escenic.indexer.tail=before/-61667
com.escenic.indexer.head=after/98943
```

These IDs corresponds to the `documentID` in the `SearchIndex`
table. Since the `documentID` of our content item `11` is `25` and the
indexer is happy humming along, thinking that the `documentID` he last
indexed was `98943`, he'll not bother with this low `documentID`
`11`. We therefore have to issue a re-index.

## What does the indexer-webapp log say?
```text
$ tail -f /var/log/escenic/search1-messages
<response>
<lst name="responseHeader"><int name="status">400</int><int name="QTime">16</int></lst><lst name="error"><lst name="metadata"><str name="error-class">org.apache.solr.common.SolrException</str><str name="root-error-class">org.apache.solr.common.SolrException</str></lst><str name="msg">ERROR: [doc=com.escenic.section:3] unknown field 'org_unit_name'</str><int name="code">400</int></lst>
</response>
```

Here, Solr refrains from indexing the document since the Solr index
document constructed by `indexer-webapp` uses a field Solr hasn't in
its schema definition. 

The remedy is to update the Solr schema from the one provided by ECE.

## Legend

Solr is running on `debbie` on port `8983` and has a core called `editorial`.
