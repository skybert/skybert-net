# Content Store Integration tests using Docker & Maven

- by torstein@escenic.com
---

## Why?

- Tests written using Java & JUnit
- Excellent Jenkins support
- Runs on same server products as in production
- Runs on any computer, server and developer laptop alike.
- Machine readable results, easy to feed into other systems.
- Can be triggered from CLI, Jenkins, Slack or whatever other system.

---

## Why?

Just like in production:

- App server is Tomcat
- Search server is Solr
- Database is MariaDB
- JDBC driver is MariaDB
- Server platform is Linux (easy to test on multiple distributions)

---

## The interface to Content Store is HTTP

- Lookup services using `/webservice/index.xml`
- Only **3** Java dependencies in `integration-test-docker`:
  -- XOM
  -- JAX-RS (a part of Java 11)
  -- JUnit

---

## Batteries included

The aim is to make it as easy as possible to write integration tests
while at the same time giving the developer the options he/she needs
to go beyond the simple tests.

---

## Batteries included
Service lookup: `YellowPages` looks up endpoint URIs and search
descriptors for you:

```java
import com.escenic.integrationtest.common.ws.YellowPages.What;
import static com.escenic.integrationtest.common.ws.YellowPages.lookup;

URI modelURI = lookup(What.LIST_OF_CONTENT_TYPES, PUBLICATION_NAME);
URI endpoint = lookup(What.HOW_TO_CREATE_CONTENT_ITEMS, PUBLICATION_NAME);
```

---

## Batteries included
Creating XML structures is easy so you can do this in Java rather than
maintaining static XML files.

```
import static com.escenic.integrationtest.common.xml.XMLCreator.*;

String xml = createContentItemXML(modelURI, title);
```
---

## Batteries included
XML search (XPath)

```java
import static com.escenic.integrationtest.common.xml.XMLSearcher.*;

String title = searchForValue(xml, xpathForFieldTitle());
Nodes entries = searchForNodes(xml, xpathForAtomFeedEntries());
```

---

## Batteries included
HTTP calls.

```java
import static com.escenic.integrationtest.common.http.HTTPCaller.get;

HttpResponse<String> response = get(user, password, uri);
```

---

## Example, testing creating a content item

Given that a publiation exists
  and I have a `content-type` definition
  and I have a valid `content item` XML document
When I create a content item
Then an HTTP status code `201 Created` is returned in the response
  and a `Location` header is set with the URI to the new document.

---

## Example, testing creating a content item 

```java
URI modelURI = YellowPages.lookup(What.LIST_OF_CONTENT_TYPES, PUBLICATION_NAME);
URI endpoint = YellowPages.lookup(What.HOW_TO_CREATE_CONTENT_ITEMS, PUBLICATION_NAME);

HttpResponse<String> response = post(
  ADMIN_USER,
  ADMIN_PASSWORD,
  endpoint,
  createContentItemXML(modelURI));

assertEquals(CREATED, fromStatusCode(response.statusCode()));
assertNotNull(
  response.headers().firstValue(LOCATION).get(), 
  "Should have location");
```

---

## Example, testing reading a content item 

Given that I have valid content item URI
  and I have have a user who's allowed to view the content item. 
When I retrieve the content item
Then an HTTP status code `200 Ok` is returned in the response
  and the `title` is available inside the Atom `entry` field.
  and the `title` is available inside a VDF `field`.

---

## Example, testing reading a content item

```
HttpResponse<String> response = get(ADMIN_USER, ADMIN_PASSWORD, uri);
assertEquals(OK, fromStatusCode(response.statusCode()));

String actual = searchForValue(response.body(), xpathForFieldTitle());
assertEquals(expected, actual, "Has correct title");

actual = searchForValue(response.body(), xpathForEntryTitle());
assertEquals(expected, actual, "Has correct title");
```

---

## Benchmarking framework included

- Creates performance reports each time it's run.
- `tab` separated values (`.tsv`)

---

## Benchmarking framework included
```
❯ cat com.escenic.integrationtest.webservice.search-performance.tsv
get search description URI      35
get search description document 108
ece search with facets and 1 result     89
ece search with facets  200
ece search without facets       132
❯ cat com.escenic.integrationtest.webservice.contentitem-performance.tsv
create content item     91
update content item     123
```
---

## Benchmarking framework included

- There's one `.tsv` file per Java package
- Re-running the `mvn verify` without `mvn clean` will append to the
  existing files.
- The numbers are milliseconds

---

## Benchmarking framework included
```java
long start = System.currentTimeMillis();
createSection();
logPerf("create section", start);

// other tests with their own logPerf(..);

writePerf();
```

---

## Integration tests implemented

- Publications (**CR**eate)
- Content items (**C**reate, **R**ead, **U**pdate)
- Open search descriptors (**R**ead)
- `content-type` descriptors (**R**ead)
- `container-type` descriptors (**CR**, **R**ead)
- searching (for content items)
- service lookup (`/index.xml`)

---

## Future proof

- Uses Java 11's own HTTP libraries (no Apache HttpClient, RestEasy or
  similar)
- No Java dependencies on ECE
- The only external library is **XOM** for XML

---

## Requirements

- OpenJDK `11.0.3`
- Maven `3.6.1`
- Docker `18.09.6`
- 8 GBs of RAM

---

## Known limitations

- `demo-temp-dev.war` no longer contain all publication resources (and
  no shared resources either). 
  -- test must create what it needs by itself
  -- in the future, `cue ways` is hopefully included in
  `demo-temp-dev.war` or similar.
  
- by default, all tests work off the same publication, so all tests
  should test content they themselves have created (can't check for if
  there are **2** content items, for instance).

---

## How to install the tests

```text
$ git clone https://cci-jira.ccieurope.com/stash/scm/escrd/integration-test-docker.git
$ cd integration-test-docker
$ docker run \
  --volume $(pwd)/tomcat:/tmp/tomcat \
  tomcat:9.0-jdk11 \
  cp -r /usr/local/tomcat/lib /tmp/tomcat
```

---

## How to run the tests

```text
$ mvn verify
```

---

## Happy integration testing!

```java
assertTrue(isFinished(), "We should be finished now");
```


---
