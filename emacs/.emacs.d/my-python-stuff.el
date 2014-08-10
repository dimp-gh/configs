(provide 'my-python-stuff)

;; (add-hook 'python-mode-hook
;; 	  (lambda ()
;; 	    (setq indent-tabs-mode t)
;; 	    (setq python-indent 4)
;; 	    (setq tab-width 4)))

(require 'elpy)
(elpy-enable)
