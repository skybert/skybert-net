title: Faceted search in Emacs
category: emacs
tags: emacs
date: 2015-12-15

Emacs 24 has a great feature built-in called `occur`, it lets you
search for strings in the current buffer. I've applied a
[slight tweak to it](https://github.com/skybert/my-little-friends/blob/master/emacs/.emacs.d/tkj-smart-file-name-completion.el)
so that it defaults to searching for the thing under the cursor and
bound it to <kbd>Alt</kbd>+<kbd>s</kbd> <kbd>o</kbd>.

Here, I've opened `/etc/passwd` and I want to view all users that use
the shell `/usr/sbin/nologin`, so I have navigated to that string and
hit the shortcut for `occur`:

<img style="border:thin solid black;" class="centered" src="/graphics/2015/occur-0.png" alt="occur"/>

It suggests searching for the thing at point, to which I answer yes,
please and hit <kbd>Enter</kbd>:

<img style="border:thin solid black;" class="centered" src="/graphics/2015/occur-1.png" alt="occur"/>

In this search result, I want to drill further down through the
results, displaying only the `/usr/sbin/nologin` entries that have
something to do with `mail`. so I do the same thing again, put my
cursor somewhere it says mail and run `occur` again:

<img style="border:thin solid black;" class="centered" src="/graphics/2015/occur-2.png" alt="occur"/>

The lines in the `occur` search result buffers are of course clickable
and will take you to the line of interest in the `/etc/passwd` file
itself.

Cool, eh?

## Wait a minute! That's not facted search ...
Well, it's
[not really facted search, but filtered search](http://www.nngroup.com/articles/filters-vs-facets/),
but still, you get my point: continuously narrow down your search
results 😃
