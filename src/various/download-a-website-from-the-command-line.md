title: Download a Website from the Command Line
date: 2025-01-27
category: various
tags: various, unix, bash

Want to make an offline backup of your favourite blog? No need to
download a dedicated app for this, just use
[wget](https://www.gnu.org/software/wget/):

```text
$ wget \
  --execute="robots = off" \
  --mirror \
  --convert-links \
  --no-parent \
  --wait=5 https://example.com
```

This takes a wee while since I've added the `--wait=5` seconds switch,
but just let it run in the background and you'll get what you want
without putting any strain on the server. Also, the `--convert-links`
makes sure you can browe your local copy without jumping to the online
version. Beware, though, that it might be there's some JavaScript on
the page that makes the page jump to the online version anyway, in
which case you might want to considering a plugin like
[noscript](https://addons.mozilla.org/en-US/firefox/addon/noscript/),
or disabling all replace all `<script>` tags with something else:

```text
$ find -type f | xargs sed -i 's#script>#ignorescript>#g'
```


Happy archiving!

