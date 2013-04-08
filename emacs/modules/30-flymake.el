;;; Flymake

(load "flymake")

;; Increase palallel checks (default 4).
(setq flymake-max-parallel-syntax-checks 8)

;; Show all errors for the line.
(setq flymake-number-of-errors-to-display nil)

;; Change backup location.
(setq flymake-run-in-place nil)
(setq temporary-file-directory "~/.emacs.d/tmp/")

;; Enable for css-mode.
(add-hook 'css-mode-hook
          (lambda () (flymake-mode t)))

;; Enable for sass and scss files.
(require 'flymake-sass)
(add-hook 'sass-mode-hook 'flymake-sass-load)
(add-hook 'scss-mode-hook 'flymake-sass-load)
