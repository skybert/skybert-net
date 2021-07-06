title: View Images in the Terminal
date: 2021-07-06
category: linux
tags: linux, graphics

[kitty](https://sw.kovidgoyal.net/kitty) can [display images in the
terminal](https://sw.kovidgoyal.net/kitty/kittens/icat.html), even
over `ssh`:

Run `ssh` using the kitty ssh kitten:
```
$ kitty +kitten ssh remote.example.com
```

Then, on the remote server, install `kitty` (yes, even though it
doesn't have X):

```text
# apt-get install kitty
```

You can now view images by running:
```
$ kitty +kitten icat image.jpg
```

I find it useful to have the last command as an alias in my `.zshrc`
(same works in `.bashrc` if you're using `bash`):

```bash
alias icat='kitty +kitten icat'
```

Note that this [doesn't
work](https://github.com/kovidgoyal/kitty/issues/413) in multiplexers
like `screen` and `tmux`.

Happy image browsing!
