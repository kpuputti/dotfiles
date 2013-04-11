;;; YASnippet

(require 'yasnippet)

;; Note: keep provided snippets path in sync with the actual dir.
(setq yas/root-directory '("snippets"
                           "~/.emacs.d/elpa/yasnippet-20130218.2229/snippets"))

(mapc 'yas/load-directory yas/root-directory)

(yas-global-mode 1)
