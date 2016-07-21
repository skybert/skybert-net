title: Querying Solr using the HTTP API
date: 2016-07-21
category: java
tags: java, solr

## Querying multi value fields

Here, I have a multi value field `author`:

```xml
<field
  name="author"
  type="string"
  indexed="false"
  stored="true"
  multiValued="true" />
```

To query for documents with a given author, you cannot (for some reason
I don't understand) use a reqular `q=author:John`, instead  you must
a query filter `fq`:

```
fq=(author:0+OR+John)
```

The URL then looks like this, example here given with `curl`:

```
$ curl 'http://search:8983/core1/select?q=*:*&fq=(author:0+OR+John)&wt=json&indent=true
```

If you want to apply more parameters to the search to narrow down the
results, you can include the regular single valued fields in the `q`
parameter as normal. For example, here I want to include only the
documents that have the `contenttype` field set to `story`:

```
$ curl 'http://search:8983/core1/select?q=contenttype:story&fq=(author:0+OR+John)&wt=json&indent=true
```

An in case you were wondering, yes you need the first `0+OR`, or else
it doesn't work 😉

Happy searching!
