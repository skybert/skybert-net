# Content Store Integration tests using Docker & Maven

- by torstein@escenic.com

---

![bg](https://simpleshow.com/wp-content/uploads/sinekgoldencirclee1378664887408.jpg)

---

## Why integration tests?

- The sooner we can catch a bug, the cheaper (less time, less
  frustration, less grumpy customers) it is.
- Integration tests help us catch bugs that unit tests cannot 

---

## Why? Bugs unit tests cannot easily catch 

- How the web service works end to end (from client to app server to
  Content Store to database).
- Bugs/changes in the app server breaks our code.
- Bugs in the JDBC driver

---

## Why? Bugs unit tests cannot easily catch 

- Bugs in our SQL scripts
- Bugs in our binaries (catch bug with in project & release process) 
- Bugs/changes in Solr, our code or shipped Solr schema doesn't work
  with latest versions.

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

## How is this different from earlier integration tests?

---

## How is this different from earlier integration tests?

`integration-test` had Java compile time dependencies to Content
  Store.
  
---

## How is this different from earlier integration tests?

`integration-test` Java compile & run time dependencies on many 3rd
arty libraries that have changed significantly over the years
notably Apache HttpClient)

---

## How is this different from earlier integration tests?
- `integration-test` used a special `embedded-engine` Java server as
 glue (not production like)
- It used Derby, an in-memory database (not production like)

---

## How is this different from earlier integration tests?

`integration-test` and `embedded-engine` became **hard to maintain**
and **fell into disarray**.

Has been **broken for at least 4-5 years** and we have during this
time been without integration tests.

---

## The interface to Content Store is HTTP

- Lookup services using `/webservice/index.xml`
- Only **3** Java dependencies in `integration-test-docker`:
  -- XOM
  -- JAX-RS (a part of Java 11)
  -- JUnit

---

## Batteries included

The goal is to make it as **easy** as possible to write integration
tests while at the same time giving the developer the **power to go
beyond** the simple tests.

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
import nu.xom.Document;
import static com.escenic.integrationtest.common.xml.XMLCreator.*;

Document xml = createContentItemXML(modelURI, title);
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
import static com.escenic.integrationtest.common.http.HTTPClient.get;

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
- The numbers are in milliseconds

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

## Integration tests implemented, /escenic-admin

- Publications (**C**reate, **R**ead)
- `/index.jsp` (**R**ead)
- Publishers, (**R**ead)

---

## Integration tests implemented, /webservice
- Content items (**C**reate, **R**ead, **U**pdate)
- Open search descriptors (**R**ead)
- `content-type` descriptors (**R**ead)
- `container-type` descriptors (**C**reate, **R**ead)
- searching (for content items)
- service lookup (`/index.xml`)

---

## Time 🕗

Currently (2019-07-16) running the `integration-test-docker` test
suite takes around `02:54` on an i7 CPU with 16GB of RAM (the machine
also runs Firefox, Slack, Emacs, Spotify++).


---

## Time 🕗
The bulk of this time is to bring up the two Docker clusters (one for
the `/escenic-admin` tests and one for the `/webservice` tests). 

A total of 22 JUnit tests are run against these clusters (most of
these tests issue several HTTP requests).

---

## Future proof

- Uses Java 11's own HTTP libraries (no Apache HttpClient, RestEasy or
  the like)
- No Java dependencies on ECE
- The only external library is **XOM** for XML handling

---

## Requirements

- OpenJDK `11.0.3`
- Maven `3.6.1`
- Docker `18.09.6`
- 8 GBs of RAM

---

## Known limitations

`demo-temp-dev.war` doesn't contain all publication resources (and
no shared resources either) anymore. 
- Tests must create what it needs by itself
- In the future, `cue ways` is hopefully included in
`demo-temp-dev.war` or similar.

---

## Known limitations

By default, all tests work off the same publication, creating a
publication with `PublicationCreator` is easy, though:

```java
import static com.escenic.integrationtest.common.publication.PublicationCreator.*;

String war = System.getProperties().get("basedir") +
  "/target/engine-develop-SNAPSHOT/contrib/wars/demo-temp-dev.war";
createPublication(war, "mypub");
```

---

## Known limitations
Is HTTP centric. Testing the syndication/import or dependency
injection framework (Nursery) is harder than with the old
`integration-test` suite.

---

## How to install the tests

```text
$ git clone https://git.example.com/integration-test-docker.git
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
