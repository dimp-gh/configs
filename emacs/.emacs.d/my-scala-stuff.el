(provide 'my-scala-stuff)

;; Scala stuff goes here
(require 'scala-mode2)

;; Load the ensime lisp code...
;; TODO: fix
;(add-to-list 'load-path "~/.emacs.d/ensime_2.10.0-0.9.8.9/elisp/")
;(require 'ensime)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; configure how ensime highlights errors
;(custom-set-faces
; '(ensime-errline ((((class color) (background dark)) nil)))
; '(ensime-errline-highlight ((t (:background "firebrick2"))))
; )
