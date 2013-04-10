;;; JSON

(autoload 'json-mode "json-mode" "json-mode" t)

(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
