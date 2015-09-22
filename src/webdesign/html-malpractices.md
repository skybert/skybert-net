date:    2012-10-07
category: webdesign
tags: html
title: HTML Malpractices
## Multiple Line Breaks

The `<br/>` tag is for enforcing a line break, where you don't trust
the browser to do what you want. However, you <em>never need more than
one</em>. If you put more than one line break, you should rather use a
block level element that will produce the space you want.


Hence, this is just plain non sense:

```
<p>
  My text
  <br/>
  <br/>
  after some space
</p>
```

Instead, just start a new paragraph:

```
<p>
  My text
</p>
<p>
  after some space
</p>
```



