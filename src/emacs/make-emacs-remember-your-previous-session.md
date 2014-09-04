date:    2012-10-07
category: emacs
title: How to make Emacs Remember Your Previous Session
<div style="float: right">
<img src="../graphics/emacs.png" alt="png"/>

This brilliant one liner, tested on version 23.2.1,
makes Emacs remmeber all the files you had open, what
line you were working on in each file and so. With this line
in place, Emacs will let you continue working where you left
off the last time you had it open.

    ;; Save & restore sessions
    (desktop-save-mode 1)

