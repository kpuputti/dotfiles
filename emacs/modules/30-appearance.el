;;; Appearance

;; Theme
;; Use only when running in GUI mode.
(when window-system
  (load-theme 'solarized-dark t))

;; Font
(set-default-font "Source Code Pro")

;; Line highlight
(global-hl-line-mode 1)

;; Line and column numbers
(global-linum-mode 1)
(column-number-mode 1)

;; Smooth scrolling
(setq smooth-scroll-margin 1)

;; Fill column indicator
; Enable for all files.
(add-hook 'after-change-major-mode-hook 'fci-mode)
(setq fci-rule-column 80)
(setq fci-rule-color "#073642") ; Match the theme colors.

;; Whitespace mode
(global-whitespace-mode 1)
