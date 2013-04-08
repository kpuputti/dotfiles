;;; General

;; Quit confirmation
(setq confirm-kill-emacs 'y-or-n-p)

;; Clipboard support
(setq x-select-enable-clipboard t)

;; Backups
(setq
  backup-by-copying t
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; Aliases
(defalias 'qrr 'query-replace-regexp)
(defalias 'dtr 'delete-trailing-whitespace)
