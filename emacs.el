;;; Defuns

;;; http://www.emacswiki.org/UnfillParagraph
;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;; http://whattheemacsd.com/appearance.el-01.html
(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))


;;; Packages

(setq package-archives
      '(
        ("gnu"       . "http://elpa.gnu.org/packages/")
        ;("original"  . "http://tromey.com/elpa/")
        ;("org"       . "http://orgmode.org/elpa/")
        ;("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa"     . "http://melpa.milkbox.net/packages/")
        ;("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
        ))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Required packages.
(defvar my-packages '(dash
                      projectile
                      flx-ido
                      ido-vertical-mode
                      browse-kill-ring
                      undo-tree
                      exec-path-from-shell
                      volatile-highlights
                      diminish
                      smex
                      anzu
                      git-gutter-fringe
                      base16-theme
                      color-theme-solarized
                      rainbow-mode
                      rainbow-delimiters
                      magit
                      flycheck
                      js2-mode
                      json-mode
                      scala-mode2
                      scss-mode
                      feature-mode
                      markdown-mode
                      web-mode
                      clojure-mode
                      haskell-mode
                      go-mode
                      ;typescript
                      jsx-mode
                      geiser
                      expand-region
                      move-text
                      js-doc
                      less-css-mode
                      ;auto-complete
                      ;company-mode
                      tern
                      ;tern-auto-complete
                      smartparens))

;; Install missing packages.
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;;; UI

;; Set theme and font.
(when window-system
  (load-theme 'solarized t)
  (set-frame-parameter nil 'background-mode 'dark)
  (enable-theme 'solarized)
  (add-to-list 'default-frame-alist '(font . "Source Code Pro")))

;; Remove menus and tool bars.
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (and (not window-system) (fboundp 'menu-bar-mode))
  (menu-bar-mode -1))

;; Show line numbers in gutter and mode line.
(global-linum-mode 1)
(line-number-mode 1)

;; Highlight current line.
(global-hl-line-mode 1)

;; Show column number in mode line.
(column-number-mode 1)

;; Highlight matching parens etc.
(show-paren-mode 1)

;; Show file size in mode line.
(size-indication-mode t)

;; Disable cursor blinking.
(blink-cursor-mode -1)

;; Enable whitespace-mode, but keep it subtle.
(global-whitespace-mode 1)
(setq-default whitespace-style '(face tab-mark trailing))

;; Disable mode line 3D highlighting,
(set-face-attribute 'mode-line nil :box nil)

;; Always decorate as much as possible, disable startup screen.
(setq font-lock-maximum-decoration t
      color-theme-is-global t
      inhibit-startup-screen t
      initial-scratch-message nil)

;; Configure scrolling.
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
(require 'git-gutter-fringe)
(global-git-gutter-mode t)
(setq git-gutter-fr:side 'right-fringe)


;;; ==================== ALIASES ==================== ;;;

(defalias 'qrr 'query-replace-regexp)
(defalias 'dtr 'delete-trailing-whitespace)


;;; ==================== MISC ==================== ;;;

;; Fix OSX PATH when not started from a terminal.
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Use UTF-8 everywhere by default.
;; http://stackoverflow.com/a/2903256
(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(set-language-environment 'utf-8)
(set-keyboard-coding-system 'utf-8-mac) ; For old Carbon emacs on OS X only
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(unless (eq system-type 'windows-nt)
  (set-selection-coding-system 'utf-8))
(prefer-coding-system 'utf-8)

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
;(ido-vertical-mode 1)

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

;; Enable undo/redo for window configurations.
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Kill ring
(browse-kill-ring-default-keybindings)

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
; npm install -g bower csslint eslint eslint-plugin-react jsonlint less tern
(require 'flycheck)
(flycheck-add-mode 'javascript-eslint 'jsx-mode)

;; show only fringe markers.
(setq flycheck-highlighting-mode 'nil)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Smartparens
(require 'smartparens-config)
(smartparens-global-mode t)
(show-smartparens-global-mode t)
(sp-with-modes '(jsx-mode)
  (sp-local-pair "<" ">"))

(sp-local-pair '(js2-mode jsx-mode css-mode less-css-mode json-mode)
               "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
(sp-local-pair '(js2-mode jsx-mode json-mode)
               "[" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))

(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

;; Electric indent (indent after newline).
(electric-indent-mode 1)

;; JS
(require 'js2-mode)
(defun my-js2-mode-hook ()
  "My js2-mode hook"
  )
(add-hook 'js2-mode-hook 'my-js2-mode-hook)

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
(add-hook 'js2-mode-hook
          #'(lambda ()
              (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
              (define-key js2-mode-map "@" 'js-doc-insert-tag)))

;; Enable better editing of camelCased variables etc.
(add-hook 'js2-mode-hook 'subword-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(rename-modeline "js2-mode" js2-mode "JS2")

;; Tern
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
;; (eval-after-load 'tern
;;    '(progn
;;       (require 'tern-auto-complete)
;;       (tern-ac-setup)))

;; JSX
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(add-hook 'jsx-mode-hook (lambda () (tern-mode t)))

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))
(defun my-web-mode-hook ()
  "web-mode settings"
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-script-padding 2))
(add-hook 'web-mode-hook 'my-web-mode-hook)

;; Don't compile SCSS files when saving.
(setq-default scss-compile-at-save nil)

;; Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;(speedbar-add-supported-extension ".hs")

;; Enable spell-check in in code comments.
;(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; Well this sucks, but Emacs doesn't find ispell otherwise.
(setq ispell-program-name "/usr/local/bin/ispell")

;; Highlight annotations.
;; http://emacsredux.com/blog/2013/07/24/highlight-comment-annotations/
(defun font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.

This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(FIXME\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\)"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'font-lock-comment-annotations)

;; Highlight some operations.
(require 'volatile-highlights)
(volatile-highlights-mode t)

;; Rainbow delimiters.
;; TODO: enable for lisp modes
;(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(setq magit-last-seen-setup-instructions "1.4.0")

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
(global-set-key (kbd "C-=") 'er/expand-region)
(move-text-default-bindings)


;;; ==================== DIMINISH ==================== ;;;

;; Diminish mode line
(diminish 'anzu-mode)
(diminish 'git-gutter-mode)
(diminish 'global-whitespace-mode)
(diminish 'volatile-highlights-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((no-byte-compile t) (jsx-indent-level . 2)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
