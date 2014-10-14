title:  Non Greedy Matching in sed
date: Fri Nov 15 08:00:27 2013
category: unix
tags: sed, bash

If you've used ```sed``` for a while, you've probably encountered the
problem that all your (group) matches are greedy. This is easy to
illustrate with an example:

Say you have this text, where you want to convert the java classes
surrounded with @-signs into HTML ```<code/>``` elements:

```
The @HashMap@ and @ArrayList@ classes are great!
```

To convert this into HTML, you'd typically create groups and wrap
these two inside ```<code>``` elements:

```
echo 'The @HashMap@ and @ArrayList@ classes are great!' | sed 's#@\(.*\)@#<code>\1</code>#g'
```

However, ```sed``` will always do a greedy search, matching the _longest_
possible match, not quite yielding the result you want:

```
The <code>HashMap@ and @ArrayList</code> classes are great!
```

## The solution
What you need to do, is to match against everything _but_ the closing
delimiter, in our case, the '@'. This is done with the character group
notation and the negator ```^``` in front of the closing delimiter:

```
@\([^@]*\)@
```

Now, we get what we want with both java classes wrapped in HTML
```<code>``` elements:

```
echo 'The @HashMap@ and @ArrayList@ classes are great!' | sed 's#@\([^@]*\)@#<code>\1</code>#g'
The <code>HashMap</code> and <code>ArrayList</code> classes are great!
```

There, another sed mystery solved. Yeah!
