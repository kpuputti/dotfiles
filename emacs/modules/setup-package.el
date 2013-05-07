;;; Package

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
(defvar my-packages '(
                      starter-kit ; https://github.com/technomancy/emacs-starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      solarized-theme ; https://github.com/bbatsov/solarized-emacs
                      smooth-scrolling ; http://emacs.wordpress.com/2007/09/10/smooth-scrolling/
                      clojure-mode ; https://github.com/technomancy/clojure-mode
                      markdown-mode ; http://jblevins.org/projects/markdown-mode/
                      fill-column-indicator ; http://www.emacswiki.org/emacs-en/FillColumnIndicator
                      scala-mode2 ; https://github.com/hvesalai/scala-mode2
                      yasnippet ; https://github.com/capitaomorte/yasnippet
                      git-gutter-fringe ; https://github.com/syohex/emacs-git-gutter-fringe
                      scss-mode ; https://github.com/antonj/scss-mode
                      flycheck ; https://github.com/lunaryorn/flycheck
                      js2-mode ; https://github.com/mooz/js2-mode
                      js2-refactor ; https://github.com/magnars/js2-refactor.el
                      ac-js2 ; https://github.com/ScottyB/ac-js2
                      json-mode ; https://github.com/joshwnj/json-mode
                      coffee-mode ; https://github.com/defunkt/coffee-mode
                      dash ; https://github.com/magnars/dash.el
                      ))

;; Install missing packages.
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
