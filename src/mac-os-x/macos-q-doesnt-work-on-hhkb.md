title: How to exit vim when Q doesn't work
date: 2025-09-10
category: mac-os-x
tags: mac-os-x, keyboard, unix, vim

The <kbd>q</kbd> is broken on my keyboard, thus, I cannot exit from
anything using `less` as a pager, or indeed `vim`. Eventually, I caved
in an RTFMed. [man
less](https://man7.org/linux/man-pages/man1/less.1.html) told me that
<kbd>ZZ</kbd> is an alternative way of exiting `less`. Turns out it
works in `vim`. Happy days.

Great start on my day: Wrote some elisp to search for symbol at
point. A few lines of elisp that will keep me smiling throughout the
week :-)

## Update

After two weeks of not working, my <kbd>q</kbd> came to life again
today. I suspect there was some software on macOS that held on to it,
possibly the input switcher (I constantly switch between different
keyboard layouts), that's at least what makes the most sense to me.

Still, I'm happy I know an alternative way out of `less` and `vim`.


