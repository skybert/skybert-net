title: Maven, don't swallow the stacktraces from failing JUnit tests!
date: 2019-06-27
category: java
tags: java, maven

If you've got a test like this:
```java 
@Test
public void canSayFoo() throws Exception {
  // some code that throws an exception
}
```

then `mvn` will just print the exception on one line, stating the line
in the _unit_ tests and not the line where the error originated. I
find it strange that this has become the default behaviour of the sure
fire plugin. Fortunately, you can get the stack traces back by passing
this parameter:

```text
-DtrimStackTrace=false
```

or configuring the surefire plugin in your `pom.xml`:
```nxml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>3.0.0-M3</version>
    <configuration>
        <trimStackTrace>false</trimStackTrace>
    </configuration>
</plugin>
```
