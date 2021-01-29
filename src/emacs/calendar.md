title: Emacs calendar
date: 2021-01-29
category: emacs
tags: emacs

<img
  src="/graphics/emacs/2021/2021-01-29-emacs-cal.png"
  alt="M-x cal"
  class="centered"
/> 

## View calendar

Emacs has a great built-in calendar. To start it up, do:

```
M-x calendar
```

## Setting week to start on Monday

After using Emacs daily for 20 years, I finally got around to ask it
to start weeks on a Monday 😉

```lisp
(setq calendar-week-start-day 1)
```
    

