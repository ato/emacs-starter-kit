;;; nagios.el --- Nagios integration for emacs

;; Author: Mark Triggs <mark@dishevelled.net>

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;;
;; There's not much to using this: you just need to make your nagios.log file
;; available via HTTP and provide a URL below.
;;
;;; Code:

(require 'url)

(defun remove-properties-from-string (s)
  (let ((s (copy-sequence s)))
    (set-text-properties 0 (length s) nil s)
    s))


(defvar *nagios-status-log* "http://www-devel.nla.gov.au/cgi-bin/nagios.cgi")

(defvar *nagios-dot-colours* '(("orange"      . "#FF9900")
                               ("dark-orange" . "#E86400")
                               ("green"       . "#00FF00")
                               ("dark-green"  . "#00C400")
                               ("red"         . "#FF0000")
                               ("dark-red"    . "#C40000")))

(defvar *nagios-delay-minutes* 1)


(defun nagios-dot (colour)
  "Return an XPM string representing a dot whose colour is COLOUR."
  (format "/* XPM */
static char * nagios_dot[] = {
\"18 38 4 1\",
\" 	c None\",
\".	c #000000\",
\"+	c %s\",
\"c	c %s\",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"       .....      \",
\"      .ccccc.     \",
\"     .cc+++cc.    \",
\"    .cc+++++cc.   \",
\"    .c+++++++c.   \",
\"    .c+++++++c.   \",
\"    .c+++++++c.   \",
\"    .cc+++++cc.   \",
\"     .cc+++cc.    \",
\"      .ccccc.     \",
\"       .....      \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \",
\"                  \"};"
          (cdr (assoc colour *nagios-dot-colours*))
          (cdr (assoc (concat "dark-"colour) *nagios-dot-colours*))))


(defvar *nagios-states*
  `(("0" . ("OK" ,(nagios-dot "green")))
    ("3" . ("UNKNOWN" ,(nagios-dot "orange")))
    ("1" . ("WARNING" ,(nagios-dot "orange")))
    ("2" . ("CRITICAL" ,(nagios-dot "red")))))


(defvar *current-nagios-status* nil)

(defun nagios-update-display ()
  (setq url-show-status nil)
  (url-retrieve *nagios-status-log*
		'nagios-parse))

(defun nagios-parse (status)
  (let ((new-status '()))
    (while (search-forward-regexp "^\\(host\\|service\\) {"
                                  nil t)
      (let ((type (match-string 1))
            (start (point)))
        (search-forward-regexp "	}")
        (nagios-handle-entry
         type
         (mapcar (lambda (pair)
                   (let ((bits (split-string
                                (remove-properties-from-string pair)
                                "=")))
                     (cons (car bits)
                           (mapconcat 'identity (cdr bits) "="))))
                 (butlast
                  (split-string (buffer-substring (+ start 2) (- (point) 2))
                                "\n\t?")))
         (lambda (entry) (push entry new-status)))))
    (kill-buffer nil)
    (setq *current-nagios-status* new-status)
    (force-mode-line-update)))


(defun nagios-entry-value (entry key)
  (cdr (assoc key entry)))

(defun nagios-state-to-name (state)
  (car (cdr (assoc state *nagios-states*))))

(defun nagios-entry-image (entry)
  (create-image
   (cadr (cdr (assoc (nagios-entry-value entry "current_state")
                     *nagios-states*)))
   'xpm t))


(defun nagios-render-entry (entry)
  (insert-image (nagios-entry-image entry))
  (insert (format "%s %s: %s [%s]"
                  (nagios-entry-value entry "entry_type")
                  (nagios-state-to-name (nagios-entry-value entry "current_state"))
                  (nagios-entry-value entry "service_description")
                  (nagios-entry-value entry "host_name"))))

(defun nagios-status-severity ()
  (dolist (state (reverse *nagios-states*))
    (when (some #'(lambda (entry)
                    (string=
                     (nagios-entry-value entry "current_state")
                     (car state)))
                *current-nagios-status*)
      (return (cadr state)))))

(defun nagios-scorecard ()
  (mapcar (lambda (state)
            (cons (cadr state)
                  (count-if (lambda (entry)
                              (string=
                               (nagios-entry-value entry "current_state")
                               (car state)))
                            *current-nagios-status*)))
          (rest *nagios-states*)))


(defun nagios-entry-interesting-p (entry)
  (and (not (string=
             (nagios-entry-value entry "current_state")
             "0"))
       (not (or (string=
                 (nagios-entry-value entry "problem_has_been_acknowledged")
                 "1")
                (string=
                 (nagios-entry-value entry "scheduled_downtime_depth")
                 "1")))))



(defun nagios-handle-entry (type entry result)
  (when (nagios-entry-interesting-p entry)
    (push (cons "entry_type" type) entry)
    (funcall result entry)))


(defun nagios-show-entries ()
  (interactive)
  (with-current-buffer (get-buffer-create "*nagios*")
    (erase-buffer)
    (dolist (entry *current-nagios-status*)
      (nagios-render-entry entry)
      (newline))
    (pop-to-buffer "*nagios*")
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "q") 'delete-window)
      (use-local-map map))))


(defun nagios-modeline ()
  (let* ((scorecard (nagios-scorecard))
         (report (mapcan (lambda (entry)
                           (if (zerop (cdr entry))
                               nil
                             (list (format "%s: %d" (subseq (car entry) 0 1) (cdr entry)))))
                         (nagios-scorecard))))
    (if report
        (format " [Nagios: %s] " (mapconcat 'identity report "; "))
      "")))



(defun nagios-show-on-modeline ()
  (let ((map (make-sparse-keymap)))
    (define-key map [mode-line mouse-1]
      'nagios-show-entries)
    `(:propertize ,(nagios-modeline)
                  help-echo "Click to view nagios status"
                  keymap ,map)))

(setq *nagios-timer* (run-at-time nil
                                  (* 60 *nagios-delay-minutes*)
                                  'nagios-update-display))

(push '(:eval (nagios-show-on-modeline)) global-mode-string)

(define-key global-map [f10] 'nagios-show-entries)

(provide 'nagios)
