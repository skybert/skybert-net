title: Querying Solr using the HTTP API
date: 2016-07-21
category: java
tags: java, solr, searching

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

## Creating one facet per day

Say you have a date time field called `creationdate`, and you would
like to search for all documents containing the string `moore` and you
want facets showing how many documents were created per day.

The intuitive way of doing this would be to ask Solr to facet on the
field: `?facet.field=creationdate`, however, this would give you
one facet per second, which is not what you want:

```text
$ curl 'http://search.example.com/solr/editorial/select?q=moore&wt=json&facet=true&facet.field=creationdate' | \
  jq .facet_counts
{
  "facet_queries": {},
  "facet_fields": {
    "creationdate": [
      "2018-12-24T12:42:49Z",
      1,
      "2018-12-24T12:47:52Z",
      1,
      "2019-01-02T15:16:28Z",
      1,
      "2018-11-29T15:37:46Z",
      0,
      "2018-11-29T15:37:47Z",
      0
    ]
  },
  "facet_ranges": {},
  "facet_intervals": {},
  "facet_heatmaps": {}
}
```

Instead, you must utilise the facet range mechanism, the following
fields gives you facets per day (we ignore days with no articles,
`facet.mincount=1`):

```text
facet=true&
facet.range=creationdate&
facet.mincount=1&
f.creationdate.facet.range.start=2017-12-24T00:42:49Z&
f.creationdate.facet.range.end=2028-12-24T12:42:49Z&
f.creationdate.facet.range.gap=%2B1DAY
```

With this in place, we get one facet per day, showing how many
articles were written:

```text
$ curl 'http://search.example.com/solr/editorial/select?q=moore&wt=json&facet=true&facet.range=creationdate&f.creationdate.facet.range.start=2017-12-24T00:42:49Z&f.creationdate.facet.range.end=2028-12-24T12:42:49Z&f.creationdate.facet.range.gap=%2B1DAY&facet.mincount=1' | \
jq .facet_counts
{
  "facet_queries": {},
  "facet_fields": {},
  "facet_ranges": {
    "creationdate": {
      "counts": [
        "2018-12-24T00:42:49Z",
        2,
        "2019-01-02T00:42:49Z",
        1
      ],
      "gap": "+1DAY",
      "start": "2017-12-24T00:42:49Z",
      "end": "2028-12-25T00:42:49Z"
    }
  },
  "facet_intervals": {},
  "facet_heatmaps": {}
}
```

You probably want to adjust the `.start` and `.end` values, but this
should be enough to get you started.

Happy searching!
