;;; ===== Bindings ===== ;;;

;; Fix brackets, braces, etc. on OSX...
(setq mac-option-modifier nil)

;; Use the Command key as the meta.
(setq mac-command-modifier 'meta)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c h") 'helm-projectile)
