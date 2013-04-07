;;; Keys

;; Prevent suspending or iconifying when running in GUI mode.
(when window-system
  (global-unset-key (kbd "C-z"))
  (global-unset-key (kbd "C-x C-z")))

(global-unset-key (kbd "C-<left>"))
(global-unset-key (kbd "C-<right>"))
