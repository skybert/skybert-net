title: Developing a RESTful micro service in Python
date: 2014-11-26
category: python
tags: python, rest, http, mysql

## Useful articles

Python:
- Parsing
  [JSON and YAML](http://martin-thoma.com/configuration-files-in-python/)
  config files
- [Parsing config files](https://docs.python.org/2/library/configparser.html)

Flask:
- [Flask quickstart](http://flask.pocoo.org/docs/0.10/quickstart/)
- [Handling a POST request](
  http://runnable.com/UhLMQLffO1YSAADK/handle-a-post-request-in-flask-for-python)
  in Flask.

Templating:
- [Jinja](http://jinja.pocoo.org/)
- [Iterating a dictionary]( http://blog.mattcrampton.com/post/31254835293/iterating-over-a-dict-in-a-jinja-template)

Unicode:
- [Unicode](http://www.joelonsoftware.com/articles/Unicode.html)

Connecting to a MySQL database:
- [Excellent article on using MySQL in Python](http://zetcode.com/db/mysqlpython/)
- [Some notes on Python, MySQL and UTF-8](http://www.dasprids.de/blog/2007/12/17/python-mysqldb-and-utf-8)


## Core web technologies
I've used
[Twitter's Bootstrap](http://getbootstrap.com/getting-started/#download)
at work, but never on any of my own projects (I tend to write
everything from the ground up myself) and I've never introduced it,
just worked on projects that already uses it (and then it's easy to
just keep in line). Setting it up from scratch is a different matter.

## Great error messages

Jinja is a prime example of a piece of software that gives really
helpful error messages. I did something illegal in Jinja:

    {% block head-title %}

And Jinja2 told me in this super useful way:

> TemplateSyntaxError: Block names in Jinja have to be valid Python
> identifiers and may not contain hyphens, use an underscore instead.

Man, I wish other API and framwork authors would take note.
