title: Awesome real time search in Emacs
date: 2016-09-20
category: emacs
tags: emacs

Thanks to the awesome [helm](https://github.com/emacs-helm/helm)
completion framework and
the [helm-swoop](https://github.com/ShingoFukuyama/helm-swoop) plugin
to it, Emacs offers awesome search in the current buffer. 

When invoking `helm-swoop`, it picks whatever word is under the cursor
and performs a search on that. You can of course modify the search
string and the results update in real time. You can navigate search
results with e.g. `C-n` and `C-p` and Emacs will navigate to the
search hit in the file instantaneously.

<img
  class="centered"
  src="/graphics/2016/2016-09-20-helm-swoop.png"
  alt="helm-swoop"
/>

I've tested it out on fairly large Java classes (over 3700 lines,
don't tell anyone) with loads of search hits to navigate through and
`helm-swoop` is performing well. 

I could imagine that it becomes cumbersome when using it on log files
and searching for really common strings in those, but it's so far been
so fast that I've mapped it up to `C-s` instead of Emacs' default
`isearch-forward`:

```lisp
(require 'helm-swoop)
(global-set-key (kbd "C-s") 'helm-swoop)
```

Happy searching!





