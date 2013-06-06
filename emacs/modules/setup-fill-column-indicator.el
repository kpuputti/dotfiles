;;; Fill column indicator

(require 'fill-column-indicator)

(setq fci-rule-column 80)

; Enable for all files.
(add-hook 'after-change-major-mode-hook 'fci-mode)
