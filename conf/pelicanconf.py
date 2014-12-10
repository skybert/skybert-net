#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = 'Torstein Krause Johansen'
SITENAME = "Skybert's World"
SITEURL = 'http://skybert.net'

PATH = 'src'

TIMEZONE = 'Europe/Oslo'

DEFAULT_LANG = 'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = 'feeds/atom-feed.xml'
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None

# Tag cloud
TAG_CLOUD_STEPS = 8
TAG_CLOUD_MAX_ITEMS = 100

# Blogroll
LINKS = None

# Social widget
SOCIAL = (('Twitter (tech)', 'https://twitter.com/torsteinkrausew'),
          ('Twitter (personal)', 'https://twitter.com/torsteinkrause'),
          ('Github', 'https://github.com/skybert'),
          ('Instagram', 'http://instagram.com/torsteinkrause'),
)

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
RELATIVE_URLS = True

TWITTER_USERNAME = "torsteinkrausew"

THEME = "themes/skybert"

# nmnlist
# waterspill
# cebong

# CATEGORY_URL = "c/{slug}.html"


ARTICLE_URL = "{category}/{slug}"
ARTICLE_SAVE_AS = "{category}/{slug}/index.html"

PAGE_URL = "{category}/{slug}"
PAGE_SAVE_AS = "{category}/{slug}/index.html"

STATIC_PATHS = ['graphics']

