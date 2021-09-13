title: Copy to Clipboard over SSH
date: 2021-07-16
category: linux
tags: linux, ssh

When you're logged into a remote machine with
[ssh](https://www.ssh.com/academy/ssh/protocol), getting text on the
clipboard of your local machine isn't straight forward. There are
several ways to achieve this however, two of which I'll outline here.

## Kitty

Using the excellent [kitty
terminal](https://sw.kovidgoyal.net/kitty/), getting text on your
machine's clipboard is as easy as:

```text
$ ssh example.com
$ echo hello world | kitty +kitten clipboard
```

That's it. Granted you have `kitty` installed on the server and you're
`ssh`ing from a `kitty` terminal, you're all set. Amazingly
simple. You can of course also put whole files on the clipboard like
so:

```text
$ cat /etc/hosts | kitty +kitten clipboard
```

## Using your mouse

Arguably an even easier approach, is simply using your mouse. I
recommend configuring your terminal to put whatever you select with
your mouse directly on the clipboard. No key presses, no <kbd>Ctrl +
c</kbd>, just select the text with the mouse and it goes to the
clipboard.

To get [kitty terminal](https://sw.kovidgoyal.net/kitty/) to do this,
I added the following to `~/.config/kitty/kitty.conf`:

```text
copy_on_select        yes
```

While at it, I also set:
```text
strip_trailing_spaces always
```

The last line ensures I don't get any trailing whitespace when
selecting multiple lines (it's normally what you want, should've been
the default if you ask me).

## Final words

If you've set `copy on select` in your terminal, using the mouse is
fast, but you must take heed to copy only the characters you need. If
accuracy is needed, or you need more than a couple of lines, I
recommend using the first approach with [kitty's clipboard
kitten](https://sw.kovidgoyal.net/kitty/kittens/clipboard.html).
