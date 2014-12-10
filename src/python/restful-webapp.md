
## Useful articles

Python:
- Parsing
  [JSON and YAML](http://martin-thoma.com/configuration-files-in-python/)
  config files
- [Parsing config files](https://docs.python.org/2/library/configparser.html)

Flask:
- http://flask.pocoo.org/docs/0.10/quickstart/
- http://runnable.com/UhLMQLffO1YSAADK/handle-a-post-request-in-flask-for-python

Templating:
- [Jinja](http://jinja.pocoo.org/)
- http://blog.mattcrampton.com/post/31254835293/iterating-over-a-dict-in-a-jinja-template

Unicode:
- http://www.joelonsoftware.com/articles/Unicode.html

Connecting to a MySQL database:
- http://zetcode.com/db/mysqlpython/
- http://www.dasprids.de/blog/2007/12/17/python-mysqldb-and-utf-8


## Core web technologies
I've used
[Twitter's Bootstrap](http://getbootstrap.com/getting-started/#download)
at work, but never on any of my own projects (I tend to write
everything from the ground up myself) and I've never introduced it,
just worked on projects that already uses it (and then it's easy to
just keep in line). Setting it up from scratch is a different matter.

## Great error messages

Jinja is a prime example of a piece of software that gives really
helpful error messages:

    {% block head-title %}

> TemplateSyntaxError: Block names in Jinja have to be valid Python
> identifiers and may not contain hyphens, use an underscore instead.
