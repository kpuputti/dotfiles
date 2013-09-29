;;; ===== Common ===== ;;;

;; Confirm quit.
(setq confirm-kill-emacs 'y-or-n-p)

;; Delete selection  with a keypress.
(delete-selection-mode t)

;; Revert buffers automatically when the files are changed on disk.
(global-auto-revert-mode t)

;; Projectile.
(projectile-global-mode)

;; flx in ido.
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)

;; Custom aliases.
(defalias 'qrr 'query-replace-regexp)
(defalias 'dtr 'delete-trailing-whitespace)
