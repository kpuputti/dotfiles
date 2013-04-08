;;; Packages

(require 'package)

;; Add package archives.
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Define required packages.
;;
;; Emacs Starter Kit: https://github.com/technomancy/emacs-starter-kit
;; Solarized color theme: https://github.com/bbatsov/solarized-emacs
;; Smooth scrolling: http://emacs.wordpress.com/2007/09/10/smooth-scrolling/
;; Clojure mode: https://github.com/technomancy/clojure-mode
;; Markdown mode: http://jblevins.org/projects/markdown-mode/
;; Fill column indicator: http://www.emacswiki.org/emacs-en/FillColumnIndicator
;; Scala mode 2: https://github.com/hvesalai/scala-mode2
;; YASnippet: https://github.com/capitaomorte/yasnippet
(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      solarized-theme
                      smooth-scrolling
                      clojure-mode
                      markdown-mode
                      fill-column-indicator
                      scala-mode2
                      yasnippet))

;; Install missing packages.
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
