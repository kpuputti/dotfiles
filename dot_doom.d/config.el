;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Kimmo Puputti"
      user-mail-address "emacs@kimmo.kpuputti.fi")
(setq doom-theme 'doom-vibrant)
(setq org-directory "~/org/")
(setq display-line-numbers-type t)

(defconst is-mac (eq system-type 'darwin))

(when is-mac
  (setq mac-option-modifier nil
        mac-command-modifier 'meta))

(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol)

      ;; http://emacsredux.com/blog/2013/04/07/display-visited-files-path-in-the-frame-title/
      frame-title-format '((:eval (if (buffer-file-name)
                                      (abbreviate-file-name (buffer-file-name))
                                    "%b")))

                                        ; https://github.com/hlissner/doom-emacs/issues/4158
      +format-with-lsp nil)

(after! undo-tree (setq undo-tree-enable-undo-in-region t))

(after! whitespace
  (setq whitespace-style '(face tabs tab-mark trailing empty))
  (global-whitespace-mode +1))

(after! magit
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1
        magit-bury-buffer-function  #'magit-restore-window-configuration))

(after! anzu (global-anzu-mode +1))

(map! "C-a" #'beginning-of-line
      "M-o" #'ace-window
      "M-/" #'hippie-expand
      "C-c b" #'+default/new-buffer)

(use-package typescript-ts-mode
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode))
  :config
  (add-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook) #'lsp!))

(after! lsp-mode
  (setq lsp-clients-typescript-max-ts-server-memory 8192)
  (dolist (dir '("[/\\\\]pgdata\\'"
                 "[/\\\\]db/pgdata\\'"
                 "[/\\\\]dist\\'"
                 "[/\\\\]\\.next\\'"
                 "[/\\\\]\\.cache\\'"))
    (push dir lsp-file-watch-ignored-directories))
  (setq lsp-file-watch-threshold 50000))

(add-to-list 'auto-mode-alist '("\\.sqlx\\'" . sql-mode))

(after! markdown-mode
  (setq markdown-command "pandoc -f gfm -t html")
  (defun my/markdown-preview-css ()
    (let ((f (expand-file-name "markdown-preview.css" doom-user-dir)))
      (if (file-readable-p f)
          (format "<style>\n%s\n</style>"
                  (with-temp-buffer (insert-file-contents f) (buffer-string)))
        "")))
  (defun my/markdown-refresh-header-content (&rest _)
    (setq markdown-xhtml-header-content (my/markdown-preview-css)))
  (advice-add 'markdown-preview :before #'my/markdown-refresh-header-content)
  (my/markdown-refresh-header-content))

(use-package! graphql-mode
  :defer t)

(defun my/agent-shell-switch-buffer-in-project ()
  "Switch between agent-shell buffers rooted in the current project.
Shows the per-buffer session title, unlike the generic buffer switcher."
  (interactive)
  (let* ((root (expand-file-name
                (if-let* ((proj (project-current)))
                    (project-root proj)
                  default-directory)))
         (buffers (seq-filter
                   (lambda (b)
                     (file-in-directory-p
                      (buffer-local-value 'default-directory b) root))
                   (agent-shell-buffers))))
    (switch-to-buffer
     (agent-shell--read-shell-buffer
      :prompt "Switch to agent-shell buffer: "
      :buffers (or buffers
                   (user-error "No agent-shell buffers in %s" root))
      :force-short-names t))))

(defun my/agent-shell-q (n)
  "Insert `q' at the editable prompt; run `quit-window' in read-only output.
agent-shell binds `q' to `quit-window' for evil users, whose insert state
shadows it; without evil that makes `q' untypable at the prompt."
  (interactive "p")
  (if (get-text-property (point) 'read-only)
      (quit-window)
    (self-insert-command n ?q)))

(use-package! agent-shell
  :defer t
  :bind (("C-c C-a" . agent-shell-anthropic-start-claude-code)
         ("C-c C-b" . my/agent-shell-switch-buffer-in-project))
  :config
  (define-key agent-shell-mode-map (kbd "q") #'my/agent-shell-q)
  ;; Replay the whole conversation when resuming a session, not just the title.
  (setq agent-shell-session-restore-verbosity 'full)
  (setq agent-shell-show-welcome-message nil)
  ;; Graphical SVG header clips the last glyph of the top row; text is clean.
  (setq agent-shell-header-style 'text)
  (setq agent-shell-anthropic-authentication
        (agent-shell-anthropic-make-authentication :login t)))
