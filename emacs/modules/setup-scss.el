;;; SCSS

(autoload 'scss-mode "scss-mode" "scss mode" t)

(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; Don't compile when file is saved.
(setq-default scss-compile-at-save nil)
