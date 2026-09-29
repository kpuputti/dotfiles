;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! anzu)
(package! restclient)
(package! graphql-mode)
(package! ag)
(package! jsonrpc)
(package! polymode)
(package! gptel :recipe (:nonrecursive t))
(package! claude-code-ide
  :recipe (:host github :repo "manzaltu/claude-code-ide.el"))
(package! agent-shell)
(package! acp)
