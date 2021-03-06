title: Serious Websites Need Serious Test Environments
date:    2012-10-07
category: craftsmanship
tags: testing

For any serious production web site, I sincerely recommend
having four different environments in which newly developed
features as well as existing, old featues are tested:
development, testing, staging and production.
## Development Environment

Each developer should have (and normally always have) a
software/server stack that is a bare minimum of running the
web site application. This normally includes a database and
application/web server.


Systems, such as Escenic systems, will require other server
components to be present as well, such as LDAP and cache
servers, however some developers may choose to not have these
installed if or when they're not working on components which
doesn't require them to function.

### Suggested architecture

Each developer has his/her own database and web/application
server. Many like virtal servers running on the development
machines for easy re-use, however I'm in favour of natively
locally installed components for minimal memory/CPU footprint.

<h2><a name="testing">Testing Environment</a></h2>

The purpose of the testing environment is to be able to
frequrently test your latest builds of your portal software.


This environment needs only one host and may very well be
virtualised, but must feature all the server components that
production has, with the notable exceptions of things like
memory caches and native library wrappers which improve
performance of your application but are not required to make
all the features work.

### Suggested architecture

One host running all server components. Daily or weekly
deployment of the latest code.

<h2><a name="staging">Staging Environment</a></h2>

The purpose of the staging environment, is to enable you to
see how your new features will look and act when going live,
and even more importantly, to debug any problem you encounter
with your website in production without inteferring with your
existing users in any way.


This environment should be as similar as possible to the
prodcution environment. The only exceptions I'd say you don't
need are the full number of web facing servers.


This means that you need the same kind of load balancer in
your staging environment as your production environment. If
you don't have this, the environment is not similar enough to
debug all scenarios that your production environment will
encounter.


Database redundancy is something that many folks would let out
in a staging environment, for reasons I can well
understand. However, if you encounter database replication
problems in production, there is no place you can debug this -
except, well, in production. So again, I'd recommend that you
also have this redundancy in the staging environment. But of
course, it depends on how mission critical you believe your
web site is, as well as your budget, server space and so on.


Another comment about the staging environment: since it's to
ressemble your real environment, the machines need to be so as
well. If you're not using virtualisation in production, don't
do it in staging either. I've had customers desperately
wanting to debug I/O problems they face in production, but are
left up the creek without a paddle since they don't have a
staging environment which features a credible test environment
for them.


I cannot stress this enough: having a real, credible,
trustworthy staging environment is a sound investment for your
company.


The staging environment should also have <cite>real</cite>
content and not test content. Many bugs on your web site will
be triggered because of the particularities of the content
produced/presented or the way the site is used. Hence, to
catch these bugs, be sure to populate your staging environment
with real content. One way of doing this, is to do weekly
database imports from the production environment.

### Suggested architecture

Load balancer, real hosts (if your production environment
uses this), two DBs, two cache servers and two web/application
servers. Deployment of RCs of your portal software, i.e. not
that often.

## Production Environment

The environment serving your website. Whateveer site you have,
you should at least have: a load balancer, two cache servers,
two web and/or application servers and two database servers.


Since the usage scenario is very different of the web facing
servers and that of the application server and database
servers, I recommend having these components on physcially
separated hosts. This way, you can tweak the OS on the
different hosts to specially cater for the server software
running on it. See e.g. <a href="/unix/max-tcp-connections">my
article on optimising the TCP connection handling</a> for an
example of this.


All critical services, such as the DB, should have a
virtual IP (VIP) with a heartbeat checking the availbility of
those servers and shifting the VIP to the hot standby server
for that component.

