;;; Markdown

(autoload 'markdown-mode "markdown-mode" "markdown mode" t)

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
