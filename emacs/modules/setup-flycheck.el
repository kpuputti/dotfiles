;;; flycheck

(require 'flycheck)

(setq flycheck-highlighting-mode 'nil)

;; Disable elisp checker.
(eval-after-load 'flycheck
  '(setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers)))

(global-flycheck-mode t)
