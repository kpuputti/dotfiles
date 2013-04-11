;;; Git gutter

(require 'git-gutter-fringe)

;; Show gutter in the right fringe.
(setq git-gutter-fr:side 'right-fringe)

(global-git-gutter-mode t)
