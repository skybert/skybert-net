date:    2012-10-07
category: java
tags: java, jndi, jdbc
title: Getting a Database Connection Using JNDI

I've looked this up enough times, so I thought I'd jott this
down. This is how I look up my JNDI resource from Java:

```
private final mJNDIResourceName = "my_data_source";
[..]
InitialContext context = new InitialContext();
Context envContext = (Context) context.lookup("java:comp/env");
DataSource dataSource = (DataSource) envContext.lookup(mJNDIResourceName);
connection = dataSource.getConnection();
connection.setAutoCommit(false);
```

Most examples on the internet use a```jdbc/``` prefix,
like```jdbc/my_data_source```. This is just some kind
of convention, you don'd need to have```jdbc/``` in
the name. I've removed it from my code because I find it
totally redundant and without any added value.


I've previously described <a href="../tomcat/db-pooling">how
you configure DB pooling in Tomcat</a>, which also is a JNDI
resource. Hence, if you're using Tomcat, you can use this
article as a reference for setting it up.


Good luck.

