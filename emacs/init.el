;;; Main entry point for Emacs configuration.
;; Make a link to this file in ~/.emacs

;; FIXME: Use relative path from this file's location.
(setq default-directory "~/dev/projects/dotfiles/emacs")

(add-to-list 'load-path "lib")
(add-to-list 'load-path "modules")

;; Load files from the `modules` directory in a specific order.
(load "setup-prepare")
(load "setup-package")
(load "setup-general")
(load "setup-appearance")
(load "setup-fill-column-indicator")
(load "setup-keybindings")
(load "setup-yasnippet")
(load "setup-flycheck")
(load "setup-git-gutter")
(load "setup-autocomplete")
(load "setup-markdown")
(load "setup-scss")
(load "setup-js")
(load "setup-json")
