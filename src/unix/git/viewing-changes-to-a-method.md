title: Viewing all changes to a Java method using Git
date: 2019-01-30
category: vcs
tags: git, java

First off, add this to your project's `.gitattributes` file:
```conf
*.java diff=java
```

Now, you're all set, you can now pass `-L :<method>:file` to `git log`
to see all changes related to a Java method.

Here I want to see all changes related to the `toString()`
method inside `HttpSolrCall.java`:

```text
git log -L :call:./core/src/java/org/apache/solr/servlet/HttpSolrCall.java
```

<img
  src="/graphics/2019/git-log-java-method.png"
  alt="git log java method"
  class="centered"
/>  

Cool, right?

## Other languages
To get this magic shining for other languages than Java, check out

```
man gitattributes
```

and the section **Defining a custom hunk-header**, there you'll see a
list of languages you can add to `.gitattributes` as:
```
*.suffix=<language>
```

If your language is not listed there, you can write your own
```
[diff "foo"]
```

function to tell `git log` how to identify a method (the man page
shows an example of this).

Happing code searching!


