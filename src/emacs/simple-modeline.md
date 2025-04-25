title: Simple Modeline Brings Peace of Mind
date: 2025-04-25
category: emacs
tags: emacs

<img
  class="centered"
  src="/graphics/emacs/2025/my-simple-emacs-modeline.png"
  alt="emacs modeline"
/>

I've been using my own modeline this week and I like the simplicity of
it: Buffer name, file state (unsaved/saved), file encoding, clock,
system load and line & column numbers. That's it.

```lisp
(setq display-time-day-and-date nil)
(setq display-time-load-average nil)
(setq display-time-24hr-format t)
(display-time-mode 1)
(setq-default mode-line-format '(" %b %* %z " display-time-string " (%l, %c)"))
```


