title: Various Java related errors and fixes for these
date: 2018-05-24
tags: java, glassfish, jackson
category: java

## MessageBodyProviderNotFoundException

```text
The service failed during startup:
javax.ws.rs.client.ResponseProcessingException:
org.glassfish.jersey.message.internal.MessageBodyProviderNotFoundException:
MessageBodyReader not found for media type=text/html, type=class
com.fasterxml.jackson.databind.JsonNode, genericType=class
com.fasterxml.jackson.databind.JsonNode.
```

### Solution

The reason in my case was that my code expected an `application/json`
payload whereas what was returned was an HTML (error) page.
