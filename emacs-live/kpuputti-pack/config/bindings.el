;;; ===== Bindings ===== ;;;

(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Fix brackets, braces, etc. on OSX...
(setq mac-option-modifier nil)

;; Use the Command key as the meta.
(setq mac-command-modifier 'meta)
