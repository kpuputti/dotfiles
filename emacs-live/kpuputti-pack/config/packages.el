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
(defvar my-packages '(dash fill-column-indicator git-gutter-fringe projectile flx-ido
                           helm helm-projectile helm-anything))

;; Install missing packages.
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
