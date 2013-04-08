;;; Main entry point for Emacs configuration.
;; Make a link to this file in ~/.emacs

;; FIXME: Use relative path from this file's location.
(setq default-directory "~/dev/projects/dotfiles/emacs")

(add-to-list 'load-path "lib")

;; Load all files from the `modules` directory.
(dolist (file (directory-files "modules" t ".elc?$"))
  (load (file-name-sans-extension file)))
