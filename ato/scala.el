(setq load-path (cons "~/.emacs.d/ato/scala-mode" load-path))
(require 'scala-mode-auto)
(defun me-turn-off-indent-tabs-mode ()
  (setq indent-tabs-mode nil))
(add-hook 'scala-mode-hook 'me-turn-off-indent-tabs-mode)
