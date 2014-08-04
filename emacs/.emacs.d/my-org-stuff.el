(provide 'my-org-stuff)

;; keywords for marking entries in todo-lists
(setq org-todo-keywords
      (quote ((sequence "TODO(t!)" "STARTED(s!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "OPEN(O!)" "|" "CLOSED(C!)"))))

(add-to-list 'org-export-latex-packages-alist '("" "cmap" t))
(add-to-list 'org-export-latex-packages-alist '("english,russian" "babel" t))
