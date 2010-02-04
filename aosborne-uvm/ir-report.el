(defun read-datetime (prompt &optional nodefault)
  (let ((input (read-from-minibuffer
                (format "%s (DD/MM/YY HH:MM:SS): " prompt)
                (if nodefault
                    nil
                  (destructuring-bind (sec min hour day mon year . junk)
                      (decode-time)
                    (format "%.2d/%.2d/%.2d %.2d:%.2d:%.2d"
                            day mon year hour min sec))))))
    (destructuring-bind (day month year hour min sec)
        (mapcar 'string-to-number (split-string input "[ /:]"))
      (list input
            (time-to-seconds (encode-time sec min hour day month year))))))



(defun incident-report (subject start-time end-time
                                &optional defaults)
  (interactive
   (list (read-from-minibuffer "Subject for this incident: ")
         (read-datetime "Incident start")
         (read-datetime "Incident finish")))
  (when (<= (cadr end-time)
            (cadr start-time))
    (error "Start and end times are screwy"))
  (compose-mail
   "itincidentreport@mirkwood.nla.gov.au"
   (concat "IR: " subject))
  (message-goto-body)
  (dolist (section '("Description" "Resolution"
                     "Start" "End"
                     "Duration" "Impact"))
    (insert (format "%s\n\n" section))
    (when (assoc section defaults)
      (insert (concat (cdr (assoc section defaults))
                      "\n\n")))
    (insert "\n"))
  (flet ((back-to (heading)
                  (search-backward heading)
                  (end-of-line)))
    (back-to "Duration")
    (insert "\n\n")
    (insert (pretty-seconds (truncate (- (cadr end-time)
                                         (cadr start-time)))))
    (back-to "End")
    (insert "\n\n")
    (insert (car end-time))

    (back-to "Start")
    (insert "\n\n")
    (insert (car start-time))

    (unless (assoc "Description" defaults)
      (back-to "Description")
      (insert "\n\n"))))
