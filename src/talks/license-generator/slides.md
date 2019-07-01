
# Automagic license generator 💥

Automagic license reports

by <a href="https://twitter.com/torsteinkrause">@torsteinkrause</a>

---

## Why? 

**Legal** wants an overview of all third party libraries that we're
using in our software and their licenses.

---

## But Content Store  already has this!

- it only works for Content Store
- it's not machine read-able

---

## But cf already has this!

- it only lists direct dependencies, not transitive dependencies
- it only works for `cf`/`cue-web`
- it's not included in the build
- it's available over HTTP

---

## The Automatic License Generator

- Generates a text file like this:
- Uploads it to [Nexus under `cloud.cue.license`](http://repo.dev.escenic.com/content/repositories/escenic/cloud/cue/license/)
- Adds it to the DEB and RPM packages

---

## The Automatic License Generator

- Works for all `npm/js` projects
- Works for all `mvn/java` projects
- To get it, you don't need to do anything 👍

---

## Known limitations

- Support for `npm/python` projects
- Some DEB/RPM packages don't include the report (but it's available
  in Nexus).

---

## Source

```text
build-tools/release/lib/common-license-lib.sh
build-tools/release/test/common-license-test.sh
```

---

## The End 🌄
