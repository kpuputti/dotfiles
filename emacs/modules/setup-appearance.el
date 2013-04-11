;;; Appearance

;; Theme
;; Use only when running in GUI mode.
(when window-system
  (load-theme 'solarized-dark t))

;; Font
(set-frame-font "Source Code Pro")
(set-face-attribute 'default nil :height 110)

;; Line highlight
(global-hl-line-mode 1)

;; Line and column numbers
(global-linum-mode 1)
(column-number-mode 1)

;; Smooth scrolling
(setq smooth-scroll-margin 1)

;; Enable whitespace mode globally, but keep it subtle.
(global-whitespace-mode 1)

; http://www.gnu.org/software/emacs/manual/html_node/emacs/Useless-Whitespace.html
(setq whitespace-style '(face tab-mark trailing))
