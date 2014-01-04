;;;; ==================== TODO ==================== ;;;;
; web-mode
; js2-refactor
; undo-tree
; kill ring navigation
; helm
; ack
; flyspell
; autocomplete
; window-navigation (like in emacs live)
; winner-mode
; volatile-hilights
; hilight TODO etc.
; set all coding systems to utf-8
; magit
; dired
; diff
; clean up modeline (diminish, prelude-editor.el)
; ASCII art splash screen?
;; => split setup to different files, move osx stuff to a separate file


;;; Defuns

;; http://whattheemacsd.com/appearance.el-01.html
(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))


;;; Packages

(setq package-archives
      '(("gnu"       . "http://elpa.gnu.org/packages/")
        ("original"  . "http://tromey.com/elpa/")
        ("org"       . "http://orgmode.org/elpa/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa"     . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Defined requires packages.
(defvar my-packages '(dash
                      projectile
                      flx-ido
                      smex
                      anzu
                      git-gutter-fringe
                      base16-theme
                      autopair
                      flycheck
                      js2-mode
                      json-mode
                      scala-mode2
                      scss-mode
                      feature-mode
                      markdown-mode))

;; Install missing packages.
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;;; UI

;; Set theme and font.
(when window-system
  (load-theme 'base16-default t)
  (add-to-list 'default-frame-alist '(font . "Source Code Pro")))

;; Remove clutter from the UI.
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (and (not window-system) (fboundp 'menu-bar-mode))
  (menu-bar-mode -1))

(global-linum-mode 1)
(line-number-mode 1)
(global-hl-line-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
(size-indication-mode t)
(blink-cursor-mode -1)
(global-whitespace-mode 1)

(setq-default whitespace-style '(face tab-mark trailing))

(setq font-lock-maximum-decoration t
      color-theme-is-global t
      inhibit-startup-screen t
      initial-scratch-message nil)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; http://emacsredux.com/blog/2013/04/07/display-visited-files-path-in-the-frame-title/
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Make the gutter smaller.
(when (fboundp 'fringe-mode)
  (fringe-mode 4))

;; Git gutter
(setq git-gutter-fr:side 'right-fringe)
(global-git-gutter-mode t)


;;; ==================== ALIASES ==================== ;;;

(defalias 'qrr 'query-replace-regexp)
(defalias 'dtr 'delete-trailing-whitespace)


;;; ==================== MISC ==================== ;;;

;; Disable audible and visible bells.
(setq ring-bell-function 'ignore)

;; Delete selection  with a keypress.
(delete-selection-mode t)

;; Hippie expand
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

;; Projectile
(projectile-global-mode)

;; IDO
(setq ido-use-faces nil
    ido-save-directory-list-file (concat user-emacs-directory "ido-last"))
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)

;; Smex
(setq smex-save-file (concat user-emacs-directory "smex-items"))
(smex-initialize)

;; Anzu
(global-anzu-mode)

;; Uniquify
(setq uniquify-buffer-name-style 'forward)

(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-kill-emacs 'y-or-n-p)

;; Tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)

;; Backups
(setq backup-by-copying t
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups")))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Save cursor position.
(setq save-place-file (concat user-emacs-directory "saved-places"))
(setq-default save-place t)

;; Save command history.
(setq savehist-additional-variables
      '(kill-ring search-ring regexp-search-ring)
      savehist-autosave-interval 60)
(savehist-mode 1)

;; Save recently visited files.
(setq recentf-save-file (concat user-emacs-directory "recentf")
      recentf-max-saved-items 500
      recentf-max-menu-items 15)
(recentf-mode 1)

;; Revert buffers when underlying files change.
(global-auto-revert-mode t)

;; Increase Emacs GC threshold (see https://github.com/lewang/flx ).
(setq gc-cons-threshold 20000000)

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Autopair
(autopair-global-mode)

;; JS
(setq js2-allow-keywords-as-property-name t
      js2-missing-semi-one-line-override t
      js2-include-node-externs t
      js2-global-externs '("jQuery"
                           "$"
                           "_"
                           "Backbone"
                           "define"
                           "require"
                           "location"
                           "describe"
                           "it"
                           "before"
                           "after"
                           "beforeEach"
                           "afterEach"))

;; Enable better editing of camelCased variables etc.
(add-hook 'js2-mode-hook 'subword-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(rename-modeline "js2-mode" js2-mode "JS2")

;; Don't compile SCSS files when saving.
(setq-default scss-compile-at-save nil)


;;; ==================== BINDINGS ==================== ;;;

;; OSX: fix parens etc., use cmd as meta.
(setq mac-option-modifier nil
      mac-command-modifier 'meta)

;; Prevent suspending or iconifying when running in GUI mode.
(when window-system
  (global-unset-key (kbd "C-z"))
  (global-unset-key (kbd "C-x C-z")))

(global-set-key (kbd "M-;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-+") 'text-scale-increase)
(global-set-key (kbd "M--") 'text-scale-decrease)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
