title: HTML5 email validation
date: 2015-12-23
category: webdesign
tags: webdesign, html5

With the advent of [HTML5](http://www.w3.org/TR/html5/), this is fast
coming to a thing of the past and the browser can by itself provide a
unified experience of all input field validation errors. For instance
with emails, we would previously have to either write a beefy function
in JavaScript or load a 3rd party library to give us validation
addresses.

HTML5 solves this by providing more legal values for the `type`
attribute of the `<input/>` element.  However, with the
[email input type](http://www.w3.org/TR/html5/forms.html#e-mail-state-%28type=email%29)
there's a caveat that most people are not aware of and which will
potentially leave your system with lots of unusable email addresses.

## HTML5 makes input type validation easy

Most people and frameworks, use `<input type="email"/>` and live
happily ever after:

```html
<input type="email"/>
```

HTML5 compatible browsers, like [Mozilla Firefox](http://firefox.com)
and [Google Chrome](http://chrome.google.com) will aid the user in
entering a valid address:

<img
  class="centered"
  src="/graphics/2015/html5-email.png"
  alt="html5 input email"
/>

## However, it isn't as straightforward as you might think

However, this is not sufficient for all practical use cases, as this
will not catch errors like the user entering [john@gmail](john@gmail)
instead of [john@gmail.com](john@gmail.com). This is because that
email, by [specification](https://tools.ietf.org/html/rfc2822),
doesn't require a top level domain as this is a perfectly valid email
when you're on a local network.

<img
  class="centered"
  src="/graphics/2015/html5-email-not-top-level.png"
  alt="html5 input email"
/>

The thing, though, is that in real life, we all have to deal with
users entering "real" email addresses to the likes of
[gmail.com](gmail.com), [hotmail.com](hotmail.com) and
[yahoo.com](yahoo.com), i.e. [john@gmail.com](john@gmail.com).

## The road less travelled by

To accomplish this, we have to extend our input field declaration to
something like this:

```html
<input
  type="email"
  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,63}$"
/>
```

Now, the browser will guide the user to a successful email entry,
including the top level domain (e.g. `.com`):

<img
  class="centered"
  src="/graphics/2015/html5-email-top-level.png"
  alt="html5 input email"/>

With the pattern we applied above, the user is requested to enter at
least two characters after the dot, which should fit most use cases:

<img
  class="centered"
  src="/graphics/2015/html5-email-top-level2.png"
  alt="html5 input email"/>

## Conclusion

As always, when you know the caveats, it's easy. Still, most people
get this one wrong, so be sure to include the pattern in the input
field so that you're sure the data quality in your system is as high
as possible.

Cheers!

## Footnotes

### Server side validation

As always, you should never trust anything coming from the client, so
email validation on the server side is in order no matter how great
the HTML or JS is.

### Non-HTML5 browsers
If you're supporting non-HTML5 browsers, you may still want to fall
back to a JS library for email validation
