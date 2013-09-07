(provide 'my-zone-stuff)

;; zoning just for fun
(require 'zone)

(defun get-active-process ()
  (let ((command-result
         (shell-command-to-string
	  "/home/dmitry/code/active-window-process.sh"
	  )))
    (substring
     command-result
     0 (1- (length command-result)))))

(defun is-emacs-active ()
  "returns non-nil if emacs window is active right now"
  (string-match "emacs"
		(get-active-process)))

(is-emacs-active)

(defun zone-if-emacs-is-active ()
  (when (is-emacs-active)
    (zone)))

;; zoning only if emacs window is active
(setq zone-timer (run-with-idle-timer 120 t 'zone-if-emacs-is-active))
