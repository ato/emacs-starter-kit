(defvar mst-last-tag nil "the last tag searched for")
(defadvice find-tag
  (around find-tag-mst () activate)
 
  (if (file-exists-p "TAGS")
      (when (not (member "TAGS" tags-table-list))
        (setq tags-table-list (cons "TAGS" tags-table-list)))
    (setq tags-table-list (remove "TAGS" tags-table-list)))
 
  (if tagname
      (setq mst-last-tag tagname)
    (setq tagname mst-last-tag))
 
  ;; Sort of experimental. Allow M-. to jump to elisp functions if nothing was
  ;; found in the tag table.
  (if (ignore-errors (find-tag-noselect tagname next-p regexp-p))
      ad-do-it
 
    (cond ((and (fboundp (intern tagname))
                (subrp (symbol-function (intern tagname))))
           (message (concat tagname " is a builtin")))
          ((fboundp (intern tagname))
           (find-function (intern tagname)))
          ((boundp (intern tagname))
           (find-variable (intern tagname))))))
 
(defun mst-next-tag-match (&rest args)
  (interactive)
  (if (eq (car tags-loop-scan) 'error)
      (find-tag nil t)
    (call-interactively 'tags-loop-continue)))
 
(define-key global-map (kbd "M-,") 'mst-next-tag-match)