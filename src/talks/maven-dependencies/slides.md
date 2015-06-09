
# Maven Dependencies

<img src="maven-logo.png" alt="maven"/>

A talk by <a href="">torstein at escenic.com</a>

---

## Perhaps you already know this

...but let's slow down a bit and think about Maven

---

## What has Maven ever done for us?

<img
src="What_has_The_Romans_ever_done_for_us.jpg"
alt="what has the romans ever done for us?"
/>

---

## What has Maven ever done for us?

- Structure: `src/main/java`
- Dependencies.
- Before Maven, we had this in
  [Perforce](http://www.perforce.com/):

```
//depot/main/io/lib/FTPProtocol.jar#2 - delete change 41404 (binary)
//depot/main/io/lib/JAI.jar#2 - delete change 17647 (binary)
//depot/main/io/lib/MRJClasses.jar#2 - delete change 41854 (binary)
//depot/main/io/lib/PDFBox.jar#2 - delete change 77300 (binary)
```

---

## Helping out with dependencies

- Maven resolves dependencies for us
- Don't need to know how to get a library

---

## What does adding a dependency mean?

- Just a few lines of XML, right?

---

## Example: md-app

```
package md;

public class Main {
  public static void main(String[] args) {
  }
}
```

---

## Example: md-app

Dependency tree:
```
md:md-app:war:0.1
```
Short and sweet 😃

---

## Example: md-app

Let's add log4j to it:

```
package md;

import org.apache.log4j.*;

public class Main {
  Logger mLogger = Logger.getLogger(getClass());
  public static void main(String[] args) {
    mLogger.debug("Hello world from " + Main.class.getName());
  }
}
```

---

## And add log4j to our POM

```
<dependency>
  <groupId>log4j</groupId>
  <artifactId>log4j</artifactId>
  <version>1.2.16</version>
</dependency>
```

---

## How does the dependency tree look now?

```
md:md-app:war:0.1
\- log4j:log4j:jar:1.2.16:compile
```

Nice!

---

## Doing something clever with those tags

```
package md;

import org.apache.log4j.*;
import nu.xom.*;

public class Main {
  Logger mLogger = Logger.getLogger(getClass());

  public static void main(String[] args) {
    mLogger.debug("Hello world from " + Main.class.getName());
    Element element = new Element("content-type");
  }
}
```

---

## And add XOM to the POM
```
<dependency>
  <groupId>xom</groupId>
  <artifactId>xom</artifactId>
  <version>1.2.5</version>
</dependency>
```

---

## Now, what does the dependency tree look like?

```
md:md-app:war:0.1
+- log4j:log4j:jar:1.2.16:compile
\- xom:xom:jar:1.2.5:compile
   +- xml-apis:xml-apis:jar:1.3.03:compile
   +- xerces:xercesImpl:jar:2.8.0:compile
   \- xalan:xalan:jar:2.7.0:compile
```

WOT?!

---

## I didn't ask for those three XML libraries

- where these $@#/-#&*;@:#%^ JARs come from?

---

## Say hello to transitive dependencies

---

## Which class path?

Nature of a Maven project

- WAR
- JAR
- Tarball
- Zip-archive
- POM

---

## What's in the package?

- Depends on the type of Maven project
- We can choose to exclude libraries when packaging our code

---

## Maven scopes

- `compile`
- `test`
- `provided`

---

## Versions

- Released versions
- Unstable versions
- SNAPSHOTs

---

## Versions

- What is a Maven version?
- Or more importantly, what is a SNAPSHOT version?

---

## What does a SNAPSHOT version mean in practise?

- Maven checks once a day (per default)
- Whatever has built last on Jenkins goes on your classpath

---

## trunk-SNAPSHOT is fine ...

- if you want to live on the bleeding edge
- don't mind regularly fixing things
- will release some time in the distant future

---

## Use unstable versions if ...

- You aim for a certain minor version of ECE

- But need a few new features

```
<dependency>
  <groupId>com.escenic.engine</groupId>
  <artifactId>engine-core</artifactId>
  <version>5.7.unstable-VF-6294.168099</version>
</dependency>
```

---

## Use a released version if ...

- You aim for a certain version of ECE
- You don't want to continuously fix things that break.
- You want to be sure your code will work after **deploying** it

---

## Dependency management

- Nice mechanism to ensure that all sub modules use the same version
of a given library
- Beware of different dependency management for the main build and
plugins.

---

## Your friend

    $ mvn dependency:tree

- Overview of your projects dependencies
- And just as important: those dependencies' dependencies
- And those dependencies' dependencies' dependencies
- ...wish slides could do recursion 😃

---

## Another good place to visit once in a while

    $ mvn dependency:analyze
    Unused declared dependencies found:
      commons-lang:commons-lang:jar:2.3:compile

---

## Escenic specific deployment

    $ ls -l /opt/escenic/engine/lib
    $ ls -l /opt/escenic/engine/template/WEB-INF/lib
    $ ls -l /opt/tomcat-engine1/escenic/lib

- Why do we have it?
- How is is this reflected in our POMs?

---

## The provided scope (again)

```
<dependency>
  <groupId>com.escenic.engine</groupId>
  <artifactId>engine-core</artifactId>
  <version>${engine.version}</version>
  <scope>provided</scope>
</dependency>
```

---

## The provided scope (again) - II

- compiling against one version of `engine-core`
- deploying on version **?** of `engine-core`

---

## Summary

- Use release versions whenever you can
- `provided` and `runtime` scope mean:

> I trust the runtime environment to be the same as what I've run my
> JUnit tests on

---

## Summary - II

- Dependencies end up on your app server's classpath or webapp
  classpath
- Have a clear idea of where your app's dependencies end up

---

## Summary - III

Benefits of having a firm grip of project dependencies:

- Fewer nasty surprises when deploying your webapps on a server
- Fewer weird bugs because app server X's classloader behaves
  differently than app server Y when there's multiple versions of
  `com.escenic.MyClass` on the class path.

---

## Further reading

- [Maven dependency mechanism](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html)
- [Maven profiles](http://maven.apache.org/guides/introduction/introduction-to-profiles.html)

---

## System.exit(0);

---
