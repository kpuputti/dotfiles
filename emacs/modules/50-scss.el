;;; SCSS

;; Don't compile when file is saved.
(setq scss-compile-at-save nil)

(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
