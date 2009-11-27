
;;
;; Zenburn color theme with a slightly darker background.
;;
(setq zenburn-bg "#1f1f1f")
(zenburn)

(setq visible-bell nil
      whitespace-line-column 80)

;;
;; Clojure
;;

(defun ato.clojure/jump-and-run-tests ()
  (interactive)
  (clojure-test-jump-to-test)
  (clojure-test-run-tests)
  (clojure-test-jump-to-implementation))

(defun ato.clojure/set-key-maps ()
  (define-key slime-mode-map (kbd "C-c C-q") 'slime-quit-lisp)
  (define-key slime-mode-map (kbd "C-c q") 'slime-quit-lisp)
  (define-key slime-mode-map (kbd "C-c C-o") 'swank-clojure-project)
  (define-key slime-mode-map (kbd "C-c o") 'swank-clojure-project)
  (define-key clojure-mode-map (kbd "C-c ,") 'ato.clojure/jump-and-run-tests))

(add-hook 'slime-repl-mode-hook 'turn-on-paredit)
(add-hook 'clojure-mode-hook 'turn-on-whitespace)
(add-hook 'slime-connected-hook 'ato.clojure/set-key-maps)

;;
;; IRC
;;

(require 'erc)
(require 'erc-notify)
(erc-notify-enable)
;(setq erc-autojoin-channels-alist '((".*" . ("#nla"))))
;(add-hook 'erc-mode-hook (lambda () (auto-fill-mode -1)))
(define-key global-map (kbd "M-`") 'erc-track-switch-buffer)
(setq erc-fill-column 100)
(setq erc-server "meshy.org" erc-port 57000 erc-nick "_ato")