;;; Packages

(require 'package)

;; Add package archives.
(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Define required packages.
;;
;; Emacs Starter Kit: https://github.com/technomancy/emacs-starter-kit
;; Solarized color theme: https://github.com/sellout/emacs-color-theme-solarized
;; Smooth scrolling: http://emacs.wordpress.com/2007/09/10/smooth-scrolling/
;; Clojure mode: https://github.com/technomancy/clojure-mode
;; Markdown mode: http://jblevins.org/projects/markdown-mode/
;; Fill column indicator: http://www.emacswiki.org/emacs-en/FillColumnIndicator
(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      color-theme-solarized
                      smooth-scrolling
                      clojure-mode
                      markdown-mode
                      fill-column-indicator))

;; Install missing packages.
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
