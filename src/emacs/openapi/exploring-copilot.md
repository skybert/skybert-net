title: Exploring copilot for Emacs
date: 2023-03-31
category: emacs
tags: emacs, openai

First off, I hadn't set up straight, so I did that:

```lisp
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
```
    

Then I installed copilot:
    
```lisp
(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :ensure t)
```

I enabled it for all programming modes:

```lisp
(add-hook 'prog-mode-hook 'copilot-mode)
```

I prefer `company-mode` for completion, so I enabled `copilot` to use
it:

```lisp
(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))
  
(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
```

In advance, I had signed up for copilot on [github.com](github.com),
so I just had to use <kbd>M-x</kbd> `copilot-login` to log in. In the
browser, I just pasted in the one time code Emacs had put on the
clipboard.

The last bit I did, was to enable `copilot` all over the place:
<kbd>M-x</kbd> `copilot-global-mode`.

That was it. I was ready to use copilot.



