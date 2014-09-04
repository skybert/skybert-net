date:    2012-10-07
category: webdesign
title: Markup &amp; CSS Quirks
<p class="reg">
Things that <em>should work</em> but doesn't.

## Empty script elements
### Problem
    
&lt;script src="js/frontpage.js"/&gt;



Using an empty``` script ``` element validates
perfectly XHTML 1.0 strict, but messes up things seriously
in Internet Explorer and Mozilla Firefox - Opera is the only
one treating the web page correctly. IE and Mozilla does all
kinds of odd tings, not showing pictures (!) is one of them.  

### Fix

Use containing``` script ``` elements although you
only use the``` src ``` attribute:

    
&lt;script src="js/frontpage.js"&gt;&lt/script&gt;


