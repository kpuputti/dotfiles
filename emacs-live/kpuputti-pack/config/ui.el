;;; ===== UI ===== ;;;

;; Change font.
(add-to-list 'default-frame-alist '(font . "Source Code Pro"))

;; Always show line numbers.
(global-linum-mode 1)

;; Show file path in the frame title.
;; http://emacsredux.com/blog/2013/04/07/display-visited-files-path-in-the-frame-title/
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Enable whitespace mode globally, but keep it subtle.
(global-whitespace-mode 1)

;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Useless-Whitespace.html
(setq-default whitespace-style '(face tab-mark trailing))


;; Hilight annotations.
;; http://emacsredux.com/blog/2013/07/24/highlight-comment-annotations/
(defun font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.

This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'font-lock-comment-annotations)


;; Git gutter.
(require 'git-gutter-fringe)
(setq git-gutter-fr:side 'right-fringe)


;; Fill column indicator.
(require 'fill-column-indicator)
(setq fci-rule-column 80)
(setq fci-rule-color "#222")
(add-hook 'after-change-major-mode-hook 'fci-mode)
