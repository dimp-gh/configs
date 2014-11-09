(provide 'my-buffers)

;; splitting emacs window horizontally
(setq split-height-threshold nil)
(setq split-width-threshold 0)

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 120))
           (add-to-list 'default-frame-alist (cons 'width 100)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 200)
                             (frame-char-height)))))))
(set-frame-size-according-to-resolution)

;;
;; retitle emacs window
;;
(defun frame-retitle (title)
  (modify-frame-parameters nil
                           (list (cons 'name
                                       title))))

;; set a beautiful title bar
(setq frame-title-format
      '(buffer-file-name
	"%f"
	(dired-directory dired-directory "%b")))


;;;; Делаем чтоб Shift-M-`Arrow keys` ресайзило окна
(defun win-resize-top-or-bot ()
"Figure out if the current window is on top, bottom or in the
middle"
(let* ((win-edges (window-edges))
       (this-window-y-min (nth 1 win-edges))
       (this-window-y-max (nth 3 win-edges))
       (fr-height (frame-height)))
  (cond
   ((eq 0 this-window-y-min) "top")
   ((eq (- fr-height 1) this-window-y-max) "bot")
   (t "mid"))))

(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the
middle"
  (let* ((win-edges (window-edges))
(this-window-x-min (nth 0 win-edges))
(this-window-x-max (nth 2 win-edges))
(fr-width (frame-width)))
(cond
 ((eq 0 this-window-x-min) "left")
 ((eq (+ fr-width 4) this-window-x-max) "right")
 (t "mid"))))

(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -1))
   (t (message "nil"))))

(defun win-resize-minimize-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 1))
   (t (message "nil"))))

(defun win-resize-enlarge-vert ()
(interactive)
(cond
 ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
 ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
 ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally -1))))

(defun win-resize-minimize-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally 1))))

(setq inhibit-splash-screen t)

;; font stuff
(set-default-font "-adobe-Source Code Pro-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")


;; disabling scrollbar, toolbar and maybe menu bar
(tool-bar-mode 0)
(scroll-bar-mode 0)
(when (not (display-graphic-p))
  (menu-bar-mode 0))

;; moving between buffers with meta-key
(require 'windmove)
(windmove-default-keybindings 'meta)

;; enabling ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; powerful status line
(require 'powerline)
(powerline-vim-theme)

;; Good stuff, but messes up a bit in python-mode.
(require 'whitespace)
(setq whitespace-line-column 100)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)
(setq load-home-init-file t)

;; Line-wrapping mode.
(global-visual-line-mode t)

;; Nice split line for buffer borders in console mode:
;; Stolen from http://stackoverflow.com/a/18211568/1378617

;; Reverse colors for the border to have nicer line
(set-face-inverse-video-p 'vertical-border nil)
(set-face-background 'vertical-border (face-background 'default))

;; Set symbol for the border
(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?┃))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(require 'sudo)
