;;; General

;; Confirm quit.
(setq confirm-kill-emacs 'y-or-n-p)

;; Enable clipboard support.
(setq x-select-enable-clipboard t)

;; Make backups also for files in version control.
(setq vc-make-backup-files t)

;; Define aliases.
(defalias 'qrr 'query-replace-regexp)
(defalias 'dtr 'delete-trailing-whitespace)
