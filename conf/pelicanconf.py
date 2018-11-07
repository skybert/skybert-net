#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = 'Torstein Krause Johansen'
SITENAME = "Skybert's World"
SITEURL = 'http://skybert.net'
TIMEZONE = 'Europe/Oslo'
DEFAULT_LANG = 'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = 'feeds/atom-feed.xml'
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None

# Tag cloud
TAG_CLOUD_STEPS = 8
TAG_CLOUD_MAX_ITEMS = 100

DEFAULT_PAGINATION = 10

RELATIVE_URLS = True
TWITTER_USERNAME = "torsteinkrause"
THEME = "themes/skybert"

PATH = 'src'
ARTICLE_URL = "{category}/{slug}"
ARTICLE_SAVE_AS = "{category}/{slug}/index.html"
PAGE_URL = "{category}/{slug}"
PAGE_SAVE_AS = "{category}/{slug}/index.html"
STATIC_PATHS = [
    'graphics',
    'code'
]
