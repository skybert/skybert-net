
---

## Why?

- Tests written using Java & JUnit
- Excellent Jenkins support
- Runs on same server products as in production
- Runs on any computer, server and developer laptop alike.

---

## Why?

- App server is Tomcat
- Search server is Solr
- Database is MariaDB

---

## The interface to Content Store is HTTP

- Lookup services using `/webservice/index.xml`
- Only **3** Java dependencies in `integration-test-docker`:
  -- XOM
  -- JAX-RS (a part of Java 11)
  -- JUnit

---

## Batteries included

Want to make it as easy as possible to write integration tests.

---

## Batteries included
- `YellowPages.lookup(..)` looks URI and documents from
  `/webservice/index.xml` for you.
- XML creation
- XML search (XPath)

---

## Future proof

- Uses Java 11's own HTTP libraries (no Apache HttpClient, RestEasy or
  similar)
- No Java dependencies on ECE
- Only external library is **XOM** for XML

---

## Requirements

- OpenJDK `11.0.3`
- Maven `3.6.1`
- Docker `18.09.6`

---

## Known limitations

- `demo-temp-dev.war` no longer contain all publication resources (and
  no shared resources either). 
  -- test must create what it needs by itself
  -- in the future, `cue ways` is hopefully included in
  `demo-temp-dev.war` or similar.
  
- by default, all tests work off the same publication, so all tests
  should test content they themselves create (can't check for if there
  are **2** content items, for instance).
