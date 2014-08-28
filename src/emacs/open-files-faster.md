title: Faster start up by disabling vc integration
date: 2014-08-28

      (eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))

