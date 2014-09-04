date:    2012-10-07
category: emacs
title: Editing Text in Emacs
<div style="float: right">
<img src="../graphics/emacs.png" alt="png"/>

These settings gives me automatic wrapping of long lines and
on the fly spell checking of the text I type.

    ;; Settings related to general text editing
(add-hook 'text-mode-hook
'(lambda ()
(auto-fill-mode 1)
(flyspell-mode 1)
))
(setq longlines-show-hard-newlines t)


