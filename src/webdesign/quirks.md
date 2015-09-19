date:    2012-10-07
category: webdesign
tags: webdesign, html
title: Markup &amp; CSS Quirks


Things that *should* work but doesn't.

## Empty script elements

### Problem

```
<script src="js/frontpage.js"/>
```


Using an empty``` script ``` element validates
perfectly XHTML 1.0 strict, but messes up things seriously
in Internet Explorer and Mozilla Firefox - Opera is the only
one treating the web page correctly. IE and Mozilla does all
kinds of odd tings, not showing pictures (!) is one of them.

### Fix

Use containing `<script>` elements although you only use the `src`
attribute:

```
<script src="js/frontpage.js"></script>
```
