title: Delete artifacts in Nexus based on version
date: 2016-04-04

If you just want to delete one or two artifacts from Nexus, the web
interface is fine. However, if you've got 30+ artifacts that you want
to remove based on a certain criteria, e.g. their version, the command
line is much faster.

I wanted to remove all artifacts which had given version (my build had
a very distinct version like `3.60-UNSTABLE.175403`), so that I could
re-run the Maven upload target.

There were two trees in Nexus I needed to scan. The tree where the
meta information is stored and the one where the actual files are: I
included so much of the path to make find run faster (where it says
`/com/example/app` below):

```bash
$ ssh nexus.example.com
$ find \
  /usr/local/data/nexus-work/storage/<repo>/.nexus/attributes/com/example/app \
  /usr/local/data/nexus-work/storage/<repo>/com/example/app \
  -name *3.6.0-UNSTABLE.175403* \
  -delete
```

And of course, when trying the command out, remove the "-delete" part
of the line first to see that you get the search hits you want, the
include it on the consecutive run 😊
