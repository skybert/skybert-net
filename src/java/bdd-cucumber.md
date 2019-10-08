title: BDD in Java with Cucumber
date: 2019-10-07
category: java
tags: java, testing, bdd

## Reusing steps

I wanted to re-use some BDD steps by using inheritance: 

```java 
import io.cucumber.java.en.Then;
import static javax.ws.rs.core.Response.Status.CREATED;
import static javax.ws.rs.core.Response.Status.NO_CONTENT;
import static javax.ws.rs.core.Response.Status.fromStatusCode;

public class CommonSteps {
  @Then("the changes SHOULD be saved.")
  public void the_changes_SHOULD_be_saved() throws Exception {
    Response.Status status = fromStatusCode(mSaveResponse.statusCode());
    assertTrue(CREATED == status || NO_CONTENT == status);
  }
}
```

And then extending `CommonSteps` in my feature test class:
```java
public class BoxingFeatureTest extends CommonSteps {
}
```

Would be nice, right?

Well, turns out [Cucumber](https://github.com/cucumber/cucumber/) was
having none of it:


```text
[ERROR] com.example.app.RunCucumberTestIT  Time elapsed: 0.397 s  <<< ERROR!

cucumber.runtime.CucumberException: You're not allowed to extend
classes that define Step Definitions or hooks. class
com.example.app.BoxingFeatureTest extends class
com.example.app.CommonSteps
```


The trick is to have a state class that holds all the values you need
to share between the different classes implementing the BDD steps:


```java
public class StepValues() {
  private HttpResponse<String> saveResponse;
  public void setSaveresponse(final HttpResponse<String> pResponse) {
    saveResponse = pResponse;
  }
  public HttpResponse<String> getSaveResponse() {
    return saveResponse;
  }
}
```

In the classes where you implement steps, you then inject an instance
of this value object:

```java
public class CommonSteps() {
  public CommonSteps(final StepValues pState) {
    state = pState;
  }
```

```java
public class MoreSteps() {
  public MoreSteps(final StepValues pState) {
    state = pState;
  }
```

When running this with Cucumber, Cucumber will inject an instance of
`StepValues` into `CommonSteps` and `MoreSteps`. That is, if you have
`cucumber-picocontainer` on your classpath, otherwise you're given
this helpful error message:

```text
cucumber.runtime.CucumberException: class
com.example.app.SomeSteps
doesn't have an empty constructor. If you need DI, put
cucumber-picocontainer on the classpath
```


