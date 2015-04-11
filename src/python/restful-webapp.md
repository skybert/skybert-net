title: Developing a RESTful micro service in Python
date: 2015-04-11
category: python
tags: python, rest, http, mysql

## tl;dr

> This is the tale of why and how I re-wrote an ageing Java-based
> customer & order management system in Python and how the same
> feature set was implemented using only one 10th of the code base.

## If it ain't broke, don't fix it

During Christmas in the year of our Lord 2007, I wrote a simple
customer and order management system using what I found to be cool
technology at the time: [Java 6](http://java.com),
[iBatis](http://ibatis.org) (persistence framework),
[Tomcat 6](http://tomcat.apache.org) (application server),
[MySQL](http://mysql.com) (database),
[Debian Linux](http://debian.org) (operating system) and (deep breath)
[JSP](http://en.wikipedia.org/wiki/JavaServer_Pages) (templating),

After 1-2 weeks of coding, I had something that was usable and, after
some initial bug fixing after going live in January, it ran happily
without any maintenance or supervision of any kind for 7 years. The
only time it wasn't available, was when there was a power outage in
the server room.

The customer was happy and the story could have ended here. But
something made the system to be completely re-written after 7 years of
blissful existence. What was it?

Change. The customer wanted new features. Which meant picking up the
development and, lo and behold, I discovered how outdated the system
had gotten when looking at it again through the goggles of 2014. The
architecture was pure RPC over HTTP, JSPs was such an old technology
it's wasn't even fun thinking about it, [MySQL](http://mysql.com) had
gone from being a hip and cool Open Source database to being a
crippled step child of [Oracle](http://oracle.com), but worst of all:
some of the technology, most notably iBATIS, wasn't supported
anymore. Not supported meant no security updates, outdated
documentation, a shrinking user base and last but not least: the sad
feeling of missing out on all the fun stuff happening in the world.

### The obvious choice

There was a fork of iBATIS available called
[MyBatis](http://blog.mybatis.org/) but using it meant making changes
to both my code and build setup, so I started looking somewhere
else. Having used [Java](http://java.com) as my main programming
language at work for more than 10 years, the natural choice seemed to
be the now nicely standardised and usable
[JPA](http://docs.oracle.com/javaee/6/tutorial/doc/bnbpz.html) for
persistence with the rest of the JEE7 stack for the other building
blocks: [Java 7](http://java.com),
[JAX-RS](https://jax-rs-spec.java.net/) (REST framework) and
[JSF](http://www.oracle.com/technetwork/java/javaee/javaserverfaces-139869.html),
[Rich Faces](http://richfaces.jboss.org/) or
[Wicket](http://wicket.apache.org) (templating).

After a month or two of hacking away at this evenings and weekends, I
had something that worked and was Java wise nicely layered,
object oriented, de-coupled, unit testable and so on. It was just not
fun.

<img src="/graphics/2015/python-logo.png"
     style="width: 203px; height: 66px; float: right;"
     alt="python"
/>

And **programming should be fun**. Especially when working for free on
open source projects like this system. So I asked myself, what would I
prefer programming in? In which language and on what platform would I
have the most fun programming in while at the same time being able to
quickly add new features? Although I'm a *huge* fan of BASH, I did
admit that it wasn't ideal for developing a rich web based order
management system. My choice was then easy, it had to be
[Python](http://python.org).

I've always been very fond of Python ever since learning it in
university but I quickly moved away from it in favour of
[BASH](http://gnu.org/software/bash) for writing command line programs
as BASH is always available on all kinds of UNIX and Linux variants
(exception being HP-UX). For larger applications, my work has always
been Java related, so Python has continued to sit quietly in my
toolbox, waiting for the task at hand being right for it. And now it
finally was.

## What a joy

And what a wonderful relief it was to start programming in Python!
Just like coming home. I like programming in Python so much because
its programming model maps so well with the way I think. There's so
many thing that just *feels* right. Natural.

<img src="/graphics/emacs/emacs.png"
     style="float: right"
     alt="emacs"
/>

Another nice welcome was to find how excellent support
[Emacs](http://gnu.org/software/emacs) has for Python. There's
[many Python plugins](http://wikemacs.org/wiki/Python) to choose from.
I settled for
[anaconda-mode](https://github.com/proofit404/anaconda-mode), which
together with [pyflake](https://pypi.python.org/pypi/pyflakes) and
other great plugins I already use, like
[flymake](http://www.emacswiki.org/emacs/FlyMake),
[auto-complete-mode](https://github.com/auto-complete/auto-complete)
and [projectile](https://github.com/bbatsov/projectile), give me
everything I could ever wish for when coding: auto completion, on the
fly syntax checking, code navigation, interactive shell for
prototyping and documentation lookup.

And there was more to be rejoice about. Lots. Like
[Flask](http://flask.pocoo.org/). It's a lightweight web framework
which is just wonderful to work with. It's blissfully free of bloat or
half thought out ideas, incomplete documentation or patchy libraries
that haunt so many other frameworks. You know, the frameworks which
let's you easily do mundane tasks, but don't scale up to world
applications. Your applications. I cannot recommend you enough to try
out Flask. It's strikes an impressive balance between simplicity and
feature richness.

Another affable acquaintance was that of
[Jinja](http://jinja.pocoo.org/). It's templating done right. Again
striking a good balance between being easy to use and having all the
features you need to cover all your project needs. As an example of
how well behaved Jinja is, take a look at this error message after I
did something illegal in Jinja:

    {% block head-title %}

And Jinja2 told me in this super useful way: `TemplateSyntaxError:
Block names in Jinja have to be valid Python identifiers and may not
contain hyphens, use an underscore instead.`

Man, I wish other API and framwork authors would take note.

Another amazing piece of the puzzle was the
[Werkzeug](http://werkzeug.pocoo.org/) web server which Flask
bundles. It's a lightweight server, making Flask a perfect micro
service platform. If you think [DropWizard](http://www.dropwizard.io/)
for Java is nice and easy, try out Flask. It's a ten times easier to
use, configure and start. This is all you need to do:

      # apt-get install python-pip
      # pip install flask

Then, add a REST endpoint, instantiate and run Flask:
```
#! /usr/bin/env python
from flask import Flask
app = Flask(__name__)

@app.route("/search")
def get_search():
    return render_template("search.html")

if __name__ == '__main__':
    app.run(debug=True)
```
With this in place, you can start your micro service in pure UNIX
fashion with:

      $ ./atelier.py

And the server was up! That's it. *Nothing* more. Now, go back to your
Maven based, Java and [DropWizard](http://www.dropwizard.io/) project:

1. Add
   [DropWizard dependency/ies to your POM](http://dropwizard.github.io/dropwizard/getting-started.html)
2. Create you DropWizard YAML configuration file
3. Create a Java  application class to bootstrap it all.
4. Add whatever REST end points you want (the actual fun bit).
5. Run Maven to compile your code and package it all up with `mvn
   package`.
6. Start your application, e.g. with:
   ```java -jar target/application-0.1-SNAPSHOT.jar server path/to/app.yml```

And this is something of the easiest you get in the java world! Now,
tell me you're not already feeling homesick and want to go back to
using Flask. I for sure am!

## Keep it really simple, stupid

Whenever I'm discussing with fellow Java developers, we all agree that
we should make things as simple as possible. However, the moment we
get back to our IDEs after the coffee break, we continue creating our
super intricate, object oriented, multi layered solutions with an
indefinite number of indirections.

This time, getting a clean slate from a new language and software
stack, I set out at the other end: what's the minimum number of
indirections, layers and objects I can get away with while keeping the
code reasonably loosely coupled, easy to read, maintain and extend?

One decision I made, was to work directly on JSON structures instead
of transforming HTML forms to domain objects and then translating
these into database tables and rows again. Since the MySQL Python
driver has a cursor which delivers a Python dictionary, which is
practically an immutable JSON structure, I was almost home free. And
when discovering that the HTML form data from the web client also came
in JSON wrapping, I was good to go.

"But what about type safety?" I hear you cry. Well, I *did* a few
issues with this, but surprisingly few. Much of this is because Python
is really good at doing "what you mean". It tries to be smart and
understanding and most of the time it gets it right. If you have a
date time field in the database and you instert a string with
'2015-04-11', it'll happily convert it to a date time object. And so
on.  So far, I've spent about two hours on type (conversion)
issues. Not bad, and definitely no more than I would have had if I'd
enforced entity objects with types. Because that's the funny thing:
even with Java, JPA, Hibernate,
[Joda](http://www.joda.org/joda-time/),
[Jadira](http://jadira.sourceforge.net) and all that jazz, you still
venture into type problems. There's no getting away from that **you
need to be in command of your application, your stack, no matter the
technology you use**.

So I ditched the domain objects and just used JSON, very closely
resembling the database tables. Another thing I did, was to just have
two layers on the Python side: the data layer and the REST
layer. Nothing in between. I actually wanted to add a middle layer,
but I stalled at the last minute because I saw just *how* easy it was
to understand and debug the code when having just two layers.

My architecture thus became:
```
view:  <Jinja HTML templates with Python objects>
model: <Python code with Flask REST routing>
data:  <Python code with MySQL connectivity>
```

Less than 1000 lines of Python code. It's easy to understand (yes, I
know I wrote it, but still), it's easy to debug and it's easy to
extend.

If the system is to grow, however, I do see some challenges with the
current structure. I would need to introduce some delegation in the
two Python layers as the files shouldn't grow significantly more now
(main Flask file is ~400 lines, main data file ~500 lines). Of course,
I've crated own Python modules for the Jinja filters, data handling,
SQL generation and configuration file parsing. Still cramming
everything in ~900 lines of codes.

To be clear: My point is not that complexity is a bad thing in itself,
it' just that very often in the Java world (and I'm sure in other sub
cultures as well) we tend to introduce great complexity up front,
something which we seldom need. **Be a great master of complexity, but
be equally afraid of introducing it**.

## So how did you do...?

### Unicode support all through the stack

**Database**: Set the character set on the database connection:

```
import MySQLdb as mdb
con = mdb.connect(self.db_host, self.db_user, self.db_password, self.db)
con.set_character_set('utf8')
```

**Date, currency formats and the like**: Set the encoding together
with the desired locale using the standard locale module, just as you
would do on the UNIX command line:

    from locale import setlocale
    setlocale(locale.LC_ALL, "nb_NO.utf8")

**Make sure the HTML render characters using UTF-8**: Add this to the
HTML head.  Typically this will be in a Jinja HTML template that all
templates inherits:

```
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
```

### Create a web service accepting multiple HTTP methods

Here, I have a REST service accepting two HTTP methods and takes a
parameter from the URI template defined, passing it to the method,
picking up the values from the HTML form, saves it to the DB and
performs a redirect to another method performing a GET of the now
updated customer.

```
@app.route("/customer/<id>", methods=["POST", "PUT"])
def update_customer(id):
    db.update_customer(request.form)
    return redirect(url_for("get_customer", id = id, updated = True))
```

### Database transactions

Making several database queries run in the same transactions and
rollback is so easy and elegantly done in Python, I thought it wasn't
there! As often before, **Python just works the way you want it to**,
taking care of you and cleaning up the mess without whining.

Here, I delete all related order items before deleting the order
itself. All in the same transaction and using prepared statements to
avoid SQL injection:

    def delete_order(self, id):
        con = self.get_db_connection()
        with con:
            cur = con.cursor()
            cur.execute("delete from order_item where order_id = %s", (id))
            cur.execute("delete from customer_order where id = %s", (id))

It's so neat and tidy, you'd be forgiven to think you'd missed
something.

### Input validation

[HTML5](http://www.w3.org/TR/html5/) has matured so much now that I
delegated most of the client input validation to it (`<input
type="email"/>` is great!).

I also let the browser's HTML5 capabilities provide the data pickers.
At the time of writing (2015-04-11), this means that only users of
[Google Chrome](http://google.com/chrome/) and
[Opera](http://opera.com) get the date pickers, the rest must type in
the dates using good old ASCII. In both cases, HTML5 takes care of the
validation. Wonderful!

### Consistent, professional layout of web pages

I've used [Twitter's Bootstrap](http://getbootstrap.com/).  Once I got
my head around its grid system and form layout, it was nice to have
some pre-defined, well tested layout system that works on resolutions
and devices without too much hassle.

## Was it all bad, the old stuff?

No, not at all. When re-writing all of the Java and JSPs in Python and
Jinja, I did keep the database as it was. It's not just out of
convenience, I really liked the database modelling and kept it the way
it was. It's proof, if you needed one, that it's good to keep away
from mixing application code with the database, like PL/SQL.

The operating system is also something I kept. Debian is rock solid
and the most wonderful Linux distribution as far as I'm concerned.

As I mentioned in the introduction, MySQL has become somewhat of a
step child in Oracle's helm. I don't know what to make of it. What
does Oracle _want_ with MySQL? Hence, I always pick one of the MySQL
forks or patch sets if you will. For many years now, my favourite has
been [Percona](http://percona.com). Apart from being a different
distribution, it's basically MySQL, so all the SQL scripts and data
could be kept without modification.

And of course, having implemented this system once before was a *huge*
benefit. Domain knowledge is crucial for developing good software and
all the user feedback from the old system helped me creating a good
new version.

## Conclusion

Together, Python, Flask, Jinja and Emacs made this such a smooth
experience, bringing back the fun in programming while at the same
time implementing all the features of the old system in one tenth of
the code: ~900 lines of Python versus ~9000 lines of Java code,
excluding templating, HTML, JS and CSS.

I publish this in the hope that more people will get inspired to try
out a new stack when diving into their next big project as well as
taking a step back and reconsidering all the industry standard, best
practise and modelling principles when tackling "enterprise"
challenges . Do you really need all the levels of abstractions? All
the objects?  All the type safety? All the frameworks? What does it
*really* give you? How many bugs do you actually avoid by adding all
these layers of complexity and indirections? And also the other way
around: how many bugs do you think this complexity have introduced
over the last 5 years in your system?  I'm just asking 😊

## Useful articles

- **Flask**:
  [Flask quickstart](http://flask.pocoo.org/docs/0.10/quickstart/);
  [Handling a POST request](
  http://runnable.com/UhLMQLffO1YSAADK/handle-a-post-request-in-flask-for-python)
  in Flask.
- **Parsing**
  [JSON and YAML](http://martin-thoma.com/configuration-files-in-python/)
  config files;
  [Parsing config files](https://docs.python.org/2/library/configparser.html)
- **Templating**: [Jinja](http://jinja.pocoo.org/);
 [Iterating a dictionary](http://blog.mattcrampton.com/post/31254835293/iterating-over-a-dict-in-a-jinja-template)
- [Unicode](http://www.joelonsoftware.com/articles/Unicode.html)
- **Python & MySQL**:
 [Excellent article on using MySQL in Python](http://zetcode.com/db/mysqlpython/);
 Some notes on
 [Python, MySQL and UTF-8](http://www.dasprids.de/blog/2007/12/17/python-mysqldb-and-utf-8)


