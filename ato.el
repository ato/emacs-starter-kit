
;;
;; Zenburn color theme with a slightly darker background.
;;
(setq zenburn-bg "#1f1f1f")
(zenburn)

(setq visible-bell nil
      whitespace-line-column 80
      mumamo-chunk-coloring 100) ; disables it

(unless (boundp 'ato-loaded)
 (set-default-font "Inconsolata-12"))

;; Retraining
;; (defun no-arrows ()
;;   (interactive)
;;   (message "Arrow keys must die!"))

;; (define-key global-map (kbd "<right>") 'no-arrows)
;; (define-key global-map (kbd "<left>") 'no-arrows)
;; (define-key global-map (kbd "<up>") 'no-arrows)
;; (define-key global-map (kbd "<down>") 'no-arrows)
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
  (define-key slime-mode-map (kbd "C-c p") 'slime-eval-print-last-expression)
  (define-key slime-mode-map (kbd "C-c C-p") 'slime-eval-print-last-expression)
  (define-key clojure-mode-map (kbd "C-c ,") 'ato.clojure/jump-and-run-tests))

(defun ato.paredit/set-key-maps ()
  (define-key paredit-mode-map (kbd "M-[") 'paredit-wrap-square)
  (define-key paredit-mode-map (kbd "M-{") 'paredit-wrap-curly))

(add-hook 'slime-repl-mode-hook 'turn-on-paredit)
(add-hook 'clojure-mode-hook 'turn-on-whitespace)
(add-hook 'slime-connected-hook 'ato.clojure/set-key-maps)
(add-hook 'clojure-mode-hook 'ato.paredit/set-key-maps)
(add-hook 'slime-repl-mode-hook 'ato.paredit/set-key-maps)

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
(unless (boundp 'ato-loaded)
  (setq erc-server "meshy.org" erc-port 57000 erc-nick "_ato"))
;;
;; Emacs server
;;
(server-mode t)

;;
;; Gnus
;;
(require 'gnus)
(require 'message)

;; more stuff borrowed from Mark

(add-hook 'message-send-hook 'message-move-parts-to-bottom t nil)

(defun message-move-parts-to-bottom ()
  "Move <#part ..> tags to the bottom of the buffer (after the signature)"
  (interactive)
  (message-goto-body)
  (unless (looking-at "<#multipart type=digest>")
    (previous-line 1)
    (let ((temp-buffer (get-buffer-create
                        (generate-new-buffer-name " *temp*"))))
      (while (not (save-excursion (end-of-line) (eobp)))
        (if (or (looking-at "<#part.*disposition=\\(attachment\\|inline\\)")
                (looking-at "<#/part"))
            (let ((start (line-beginning-position))
                  (end (line-end-position))
                  (buf (current-buffer)))
              (with-current-buffer temp-buffer
                (insert-buffer-substring buf start end))
              (delete-region start end)
              (delete-blank-lines))
          (next-line 1)))
      (newline)
      (insert-buffer temp-buffer)
      (kill-buffer temp-buffer)
      (save-excursion
        (goto-char (point-max))
        (delete-blank-lines)))))

(add-hook 'message-send-hook 'message-mst-confirm t nil)

(defun message-mst-confirm ()
  (unless message-mst-suppress-confirm
    (unless (y-or-n-p "Send this message? ")
      (signal 'quit nil))))

