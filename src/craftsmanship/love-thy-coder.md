title: Love Thy Neighbour Coder 
date: 2017-03-15
category: craftsmanship
tags: craftsmanship

Show that you love thy neighbour coder by **1)** making an honest
attempt at answering the question yourself, **2)** apply markup to code
snippets, **3)** make sure your message reads well and is logically sound
and **4)** trim the error messages.

## Try to answer the easy questions yourself

Do a search on [Google](http://google.com). It's amazingly clever
these days and can answer a myriad of things.

After doing that, try to think what your fellow coder will ask you. If
you think about it for 10 seconds, you can probably find a couple of
questions he/she is bound to ask you like:

> Have you checked the log file?

Or:

> Where you logged in when this happened?

Now, if you're still out of luck, tell the coder what you've tried
when you ask him/her to help you. This shows both that you've made an
effort to solve this yourself (which makes it more motivating to help
you) and it tells the coder what he/she doesn't need to test as you've
already excluded these options.


## Apply markup to code examples

It's so much nicer to read code snippets and log exercpts if you apply
some stiling to it. Most platforms today have markup support,
including Slack, Jira, Confluence and Github. Use it to make your
message a pleasant read.

Consider this without markup:

if (isValid(getObject()) {
  List<String> list = new ArrayList<>();
  list.add(1);
}

and a marked up version:

```java
if (isValid(getObject()) {
  List<String> list = new ArrayList<>();
  list.add(1);
}
```

Which one would you prefer to read? The markup of the code as code
also makes sure that the web browser will not omit characters because
they've got special meaning in this context (like `<`s on a webpage).


## Read your message before sending it 

Read through your message before you send it. Check that your
sentences make sense. Be specific: there's a difference between the
webservice giving you a `404 Not found` and than that the server is
down. Be as accurate as you can so that your coder can help you as
effectively as possible, not having to ping you for questions to
clarify what actually is the problem.

## Trim error messages

Only include what's relevant. When you've spotted an error that could
be relevant to your problem it's helpful that you include it in your
message to whoever you want to help you. However, there are often a
good few lines you can omit if you take a good look. 

Consider this error from a Java application:

```
java.sql.SQLException: com.myapp.awesome.NoSuchObjectException: No publication with id=0
	at com.myapp.awesome.Doer$8.execute(Doer.java:3131)
	at com.myapp.TransactionSafetyWrapper.execute(TransactionSafetyWrapper.java:41)
	com.myapp.ava:129)
	at com.myapp.content.Manager.doDatabaseAction(Manager.java:151)
	at com.myapp.content.Manager.doTransaction(Manager.java:200)
	at com.myapp.awesome.Doer.execute(Doer.java:3124)
	at com.myapp.awesome.Doer.execute(Doer.java:3117)
	at com.myapp.publication.CreateArt.perform(CreateArt.java:63)
	at com.myapp.base.ActionBase.execute(ActionBase.java:55)
	at org.apache.struts.action.RequestProcessor.processActionPerform(RequestProcessor.java:431)
	at org.apache.struts.action.RequestProcessor.process(RequestProcessor.java:236)
	at org.apache.struts.action.ActionServlet.process(ActionServlet.java:1196)
	at org.apache.struts.action.ActionServlet.doPost(ActionServlet.java:432)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:650)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:731)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:303)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at com.escenic.servlet.TopFilter.doFilterImpl(TopFilter.java:136)
	at com.twelvemonkeys.servlet.GenericFilter.doFilter(GenericFilter.java:206)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:220)
	at org.apache.catalina.core.StandardContextValve.__invoke(StandardContextValve.java:122)
	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java)
	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:505)
	at org.apache.catalina.core.StandardHostValve.__invoke(StandardHostValve.java:170)
	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java)
	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:103)
	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:116)
	at org.apache.catalina.valves.AccessLogValve.invoke(AccessLogValve.java:957)
	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:423)
	at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1079)
	at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:620)
	at org.apache.tomcat.util.net.JIoEndpoint$SocketProcessor.run(JIoEndpoint.java:316)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
	at java.lang.Thread.run(Thread.java:745)
```

If you've got a little bit of knowledge about the application, `myapp`
in this case, you'll know that you can trim this stack trace
significantly. Include just one line from code outside of `myapp` so
that the coder is sure you didn't cut too much of the trace:

```
java.sql.SQLException: com.myapp.awesome.NoSuchObjectException: No publication with id=0
	at com.myapp.awesome.Doer$8.execute(Doer.java:3131)
	at com.myapp.TransactionSafetyWrapper.execute(TransactionSafetyWrapper.java:41)
	at com.myapp.AbstractDataConnector.doTransaction(AbstractDataConnector.java:129)
	at com.myapp.content.Manager.doDatabaseAction(Manager.java:151)
	at com.myapp.content.Manager.doTransaction(Manager.java:200)
	at com.myapp.awesome.Doer.execute(Doer.java:3124)
	at com.myapp.awesome.Doer.execute(Doer.java:3117)
	at com.myapp.publication.CreateArt.perform(CreateArt.java:63)
	at com.myapp.base.ActionBase.execute(ActionBase.java:55)
	at org.apache.struts.action.RequestProcessor.processActionPerform(RequestProcessor.java:431)
```

There, that's much easier to read (11 vs 39 lines). I'm sure your
coder will appreciate your effort to trim it down to the essential
lines 😃

Here's another example. Because of a badly configured system, the
`dpkg-reconfigure` command produces a lot of locale related errors:

```
user@prod1:~$ sudo dpkg-reconfigure fooapp-web-2.2 
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
    LANGUAGE = (unset),
    LC_ALL = (unset),
    LC_PAPER = "nb_NO.UTF-8",
    LC_ADDRESS = "nb_NO.UTF-8",
    LC_MONETARY = "nb_NO.UTF-8",
    LC_NUMERIC = "nb_NO.UTF-8",
    LC_TELEPHONE = "nb_NO.UTF-8",
    LC_IDENTIFICATION = "nb_NO.UTF-8",
    LC_MEASUREMENT = "nb_NO.UTF-8",
    LC_TIME = "nb_NO.UTF-8",
    LC_NAME = "nb_NO.UTF-8",
    LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
locale: Cannot set LC_ALL to default locale: No such file or directory
Generating new /etc/bar/fooapp-web-2.2/app.config.js ...
Creating symlink /var/www/html/fooapp-web → /usr/share/bar/fooapp-web-2.2/www ...
Creating /var/www/html/fooapp-web/Configuration/app.config.js → /etc/bar/fooapp-web-2.2/app.config.js
Updating plugins for fooapp-web-2.2 ...
Adding plugin: /usr/share/bar/fooapp-web-2.2/www/Plugins/Live → /usr/share/bar/fooapp-plugin-live-center-2.1
✔ Foo should now be accessible: http://prod1/fooapp-web
```

However, these are not interesting for the problem at hand. Fix
your environment (e.g. by setting `export LC_ALL=C`) or remove these
lines manually, so that only the real command messages are visible:

```
user@prod1:~$ sudo dpkg-reconfigure fooapp-web-2.2 
Generating new /etc/bar/fooapp-web-2.2/app.config.js ...
Creating symlink /var/www/html/fooapp-web → /usr/share/bar/fooapp-web-2.2/www ...
Creating /var/www/html/fooapp-web/Configuration/app.config.js → /etc/bar/fooapp-web-2.2/app.config.js
Updating plugins for fooapp-web-2.2 ...
Adding plugin: /usr/share/bar/fooapp-web-2.2/www/Plugins/Live → /usr/share/bar/fooapp-plugin-live-center-2.1
✔ Foo should now be accessible: http://prod1/fooapp-web
```

This is much faster to read and it's much easier  to identify what's
wrong. 7 vs 30 lines to read.


