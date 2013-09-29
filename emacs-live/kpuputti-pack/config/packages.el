;;; ===== Packages ===== ;;;

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
                      smooth-scrolling ; http://emacs.wordpress.com/2007/09/10/smooth-scrolling/
                      fill-column-indicator ; http://www.emacswiki.org/emacs-en/FillColumnIndicator
                      git-gutter-fringe ; https://github.com/syohex/emacs-git-gutter-fringe
                      ))

;; Install missing packages.
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
