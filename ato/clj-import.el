;;
;; Borrowed from Mark Triggs:
;; http://dishevelled.net/Generating-Clojure-import-lines-using-SLIME.html
;;

(defun clj-import (re)
  (interactive "sClass regex?: ")
  (let ((s (slime-eval `(swank:eval-and-grab-output ,(format "(user/find-classes #\"%s\")" re)))))
    (let ((imports (clj-format-import (car (read-from-string (second s))))))    
      (save-excursion
       (beginning-of-buffer)
       (search-forward "(ns ")
       (move-end-of-line 1)
       (newline-and-indent)
       (insert imports))
      (message "Added imports: %s" imports))))

(defun clj-format-import (classes)
  (let ((packages (make-hash-table :test 'equal)))
    (mapc (lambda (class)
            (let ((pkg (file-name-directory class))
                  (name (file-name-nondirectory class)))
              (puthash pkg (cons name (gethash pkg packages '()))
                       packages )))
          classes)
    (let ((imports '()))
      (maphash (lambda (pkg names)
                 (push (format "(%s %s)"
                               (replace-regexp-in-string
                                "/" "."
                                (replace-regexp-in-string "/$" "" pkg))
                               (mapconcat 'identity names " "))
                       imports))
               packages)
      (format "(:import %s)"
              (mapconcat 'identity imports "\n        ")))))
