title: JAX-RS resource that returns application/zip
date: 2022-12-28
category: java
tags: java, rest, http

## Option 1

Use standard media type that JAX-RS has a serializer for (through
Jackson) and set `application/zip` when we do the actual streaming:

```java
@Produces(MediaType.APPLICATION_JSON)
public Response getZip() {

  StreamingOutput output = stream -> {
    try (ZipOutputStream zipOutput = new ZipOutputStream(stream)) {
      // write to zipOut
      zipOutput.flush();
    }
  };
  return Response.ok(output)
      .header(HttpHeaders.CONTENT_TYPE, "application/zip")
      .header(
          CONTENT_DISPOSITION,
          "attachment; filename=\"file.zip\"")
      .build();
}
```

## Option 2

