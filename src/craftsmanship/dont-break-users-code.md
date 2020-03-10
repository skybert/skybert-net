title: Don't break user's code
date: 2020-03-16
category: craftsmanship
tags: craftsmanship, java, linux

One of the most used 3rd party libraries in the Java world must be
[Apache Commons
Lang](https://commons.apache.org/proper/commons-lang/). Breaking
client code should be avoided at all costs IMO, but they still do
things like removing `capitalise(String)` 🇬🇧, because they want you to
use `capitalize(String)` 🇺🇸 . But to what end? As Simen Sinek says:
[Start with Why](https://www.youtube.com/watch?v=u4ZoJKF_VuA). Why do
you create a library like commons-lang? For your users. To make them
more productive, right?

Now, you're successful, you've got thousands and thousands of
users. You've "done it". People listen to you, you have some well
deserved fame in the world of geeks. Time passes and you make a new
major release and you do what?  Remove methods that people depend on
because ... what? Because it makes the API documentation prettier?
Because your IDE now sorts the methods nicer?  Why oh why?

`getFullStackTrace(Throwable)` is another one. You must use
`getStackTrace(Throwable)`, stupid. Sure. Thanks. And at the end of
the day, what have we gained?

Or how about changing `Validate#notNull(object, message)` from
throwing `IllegalArgumentException` to throwing
`NullPointerException`? That's harmless, right? Throwing a NPE is so
much more "correct", so that justifies breaking a few thousand lines
of user's code, isn't it? 

I've come to deeply respect large projects that retain backwards
compatibility at almost any cost: [Wordpress](wordpress.com), [GNU
coreutils](https://www.gnu.org/software/coreutils/), the [Linux
kernel](kernel.org) and [Oracle Java](java.com).
