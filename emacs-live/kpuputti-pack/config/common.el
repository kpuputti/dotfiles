;;; ===== Common ===== ;;;

;; Confirm quit.
(setq confirm-kill-emacs 'y-or-n-p)

;; Delete selection  with a keypress.
(delete-selection-mode t)

;; Revert buffers automatically when the files are changed on disk.
(global-auto-revert-mode t)

;; Projectile.
(projectile-global-mode)

;; Flycheck.
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Don't compile SCSS files when saving.
(setq-default scss-compile-at-save nil)

;; Enable spell-check in in code comments.
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; flx in ido.
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)

;; Custom aliases.
(defalias 'qrr 'query-replace-regexp)
(defalias 'dtr 'delete-trailing-whitespace)
