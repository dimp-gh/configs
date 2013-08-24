(provide 'my-key-bindings)
;; Additional key bindings for various functions

;; resising
(global-set-key [S-M-down] 'win-resize-minimize-vert)
(global-set-key [S-M-up] 'win-resize-enlarge-vert)
(global-set-key [S-M-left] 'win-resize-minimize-horiz)
(global-set-key [S-M-right] 'win-resize-enlarge-horiz)
(global-set-key [S-M-up] 'win-resize-enlarge-horiz)
(global-set-key [S-M-down] 'win-resize-minimize-horiz)
(global-set-key [S-M-left] 'win-resize-enlarge-vert)
(global-set-key [S-M-right] 'win-resize-minimize-vert)

;; moving between buffers with C-, and C-.
(global-set-key [?\C-,] 'previous-buffer)
(global-set-key [?\C-.] 'next-buffer)

;; speedbar (not really often used)
(global-set-key (kbd "<f11>") 'sr-speedbar-toggle)

;; universal hotkey for commenting/uncommenting code
(global-set-key (kbd "C-x C-/") 'comment-region)
(global-set-key (kbd "C-S-x C-?") 'uncomment-region)

;; open calendar on `C-x g c`
(global-set-key (kbd "C-x g c") 'open-google-calendar)

;; lacarte: use menu through minibuffer with completion
;; runs on `ESC M-x`
(global-set-key [?\e ?\M-x] 'lacarte-execute-command)

;; typing `M-x magit status` all the time is kinda painful
;; so, binding it to the `C-x g s`
(global-set-key (kbd "C-x g s") 'magit-status)

(global-set-key (kbd "C-x K") 'kill-other-buffers)
