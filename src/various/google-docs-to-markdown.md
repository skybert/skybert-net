title: Convert Google Docs to Markdown
date: 2018-11-22
category: various
tags: markdown, libreoffice


> File → Download as → Open Document Format (odt)

Then use `pandoc` to convert it to Markdown:

```text
$ pandoc google-doc.odt -o google-doc.md
```

That's it. Currently (2018-11-22), `pandoc` doesn't do tables well,
but a part from that the conversion was surprisingly good.
