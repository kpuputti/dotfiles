;;; JavaScript

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; js2-mode configuration
(setq-default js2-allow-keywords-as-property-names nil)
(setq-default js2-bounce-indent-p t)
(setq-default js2-include-node-externs t)
(setq-default js2-missing-semi-one-line-override t)
(setq-default js2-global-externs '("jQuery"
                                   "$"
                                   "_"
                                   "Backbone"
                                   "define"
                                   "require"
                                   "location"))
