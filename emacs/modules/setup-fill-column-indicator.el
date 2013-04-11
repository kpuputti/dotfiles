;;; Fill column indicator

(require 'fill-column-indicator)

(setq fci-rule-column 80)
(setq fci-rule-color "#073642") ; Match the theme colors.

; Enable for all files.
(add-hook 'after-change-major-mode-hook 'fci-mode)
