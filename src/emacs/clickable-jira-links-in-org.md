title: Get Clickable Jira Links in Your Org Files
date: 2022-07-15
category: emacs
tags: emacs, org, jira

Get clickable links to Jira issues from your Org notes:

```lisp
(setq bug-reference-bug-regexp "\\b\\(\\([A-Za-z][A-Za-z0-9]\\{1,10\\}-[0-9]+\\)\\)"
      bug-reference-url-format "https://jira.example.com/browse/%s")
(add-hook 'org-mode-hook 'bug-reference-mode)
```

What the above setting, you get a clickable Jira link when you write
`FOO-1000`. The file itself doesn't contain the link, if you've just
written `FOO-1000`, that's what the file will contain. It's a link
overlay that's in the editor only.

If you want to follow the links without using the mouse, you can hit
<kbd>C-c</kbd> <kbd>RET</kbd>.

Neat, eh?

Note, the Org shortcut for following links, `org-open-at-point`, will
not work since this link overlay is provided by `bug-reference-mode`
and not `org-mode` (that would've been nice, though).


