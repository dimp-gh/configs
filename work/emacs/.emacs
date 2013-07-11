(tool-bar-mode 0)
(scroll-bar-mode 0)


(require 'linum)
(global-linum-mode)

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

(require 'windmove)
(windmove-default-keybindings 'meta)

;(define-key global-map (kbd "<XF86Back>") 'previous-buffer)
;(define-key global-map (kbd "<XF86Forward>") 'next-buffer)
(global-set-key [?\C-,] 'previous-buffer)
(global-set-key [?\C-.] 'next-buffer)
;(define-key global-map (kbd "<XF86Close>") 'kill-this-buffer)
;(define-key global-map (kbd "<XF86New>") 'switch-to-buffer)


;(setq erlang-root-dir "/usr/lib/erlang")
;(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
;(require 'erlang-start)

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

;;
;; retitle emacs window
;;
(defun frame-retitle (title)
  (modify-frame-parameters nil
                           (list (cons 'name
                                       title))))

;; set a beautiful title bar
(setq frame-title-format
      '("%S: " (buffer-file-name
                "%f"
                (dired-directory dired-directory "%b"))))



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

(global-set-key [S-M-down] 'win-resize-mi2nimize-vert)
(global-set-key [S-M-up] 'win-resize-enlarge-vert)
(global-set-key [S-M-left] 'win-resize-minimize-horiz)
(global-set-key [S-M-right] 'win-resize-enlarge-horiz)
(global-set-key [S-M-up] 'win-resize-enlarge-horiz)
(global-set-key [S-M-down] 'win-resize-minimize-horiz)
(global-set-key [S-M-left] 'win-resize-enlarge-vert)
(global-set-key [S-M-right] 'win-resize-minimize-vert)


(setq inhibit-splash-screen t)


(require 'sr-speedbar)
(global-set-key (kbd "<f11>") 'sr-speedbar-toggle)

;; (load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.el")


(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))
(add-to-list 'load-path  "~/.emacs.d/")

;(require 'lambda-mode)

;(require 'minimap)


;(require 'highlight-symbol)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)


;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)


;(require 'virtualenv)
;;(virtualenv-workon t)
(setq python-command "/usr/bin/python3.2")


(set-default-font "-adobe-Source Code Pro-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")


;; (global-set-key "\e\el" 'org-store-link)
;; (global-set-key "\e\ec" 'org-capture)
;; (global-set-key "\e\ea" 'org-agenda)
;; (global-set-key "\e\eb" 'org-iswitchb)
 
;; (setq org-agenda-files (quote ("~/.org/")))
 
;my prefer identation
;(setq org-startup-indented t)
 
;; ;;logging stuff
;; (setq org-log-done (quote time))
;; (setq org-log-into-drawer nil)
;; (setq org-log-redeadline (quote note))
;; (setq org-log-reschedule (quote time))
;; ;todo keywords
;; (setq org-todo-keywords
;;       (quote ((sequence "TODO(t!)" "NEXT(n!)" "WAITING(w@/!)" "STARTED(s!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
;;               (sequence "QUOTE(Q!)" "QUOTED(D!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
;;               (sequence "OPEN(O!)" "|" "CLOSED(C!)"))))

(global-set-key [C-kp-add] 'text-scale-increase)
(global-set-key [C-kp-subtract] 'text-scale-decrease)


;(require 'solarized-definitions)
(require 'zenburn-theme)

(require 'auto-complete-config)
(ac-config-default)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-interval 60)
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(speedbar-default-position (quote left))
 '(speedbar-show-unknown-files t)
 '(speedbar-smart-directory-expand-flag t)
 '(speedbar-use-images nil)
 '(undo-limit 100000)
 '(undo-strong-limit 150000))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-hook 'python-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode t)
	    (setq python-indent 4)
	    (setq tab-width 4)))


;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")


(setq speedbar-directory-unshown-regexp "^$")


(add-hook 'org-mode-hook
	  (lambda ()
	    (visual-line-mode 1)))

(powerline-default-theme)

(cd "~/src")


(global-set-key (kbd "C-x C-/") 'comment-region)
(global-set-key (kbd "C-S-x C-?") 'uncomment-region)

(require 'smex)
(smex-initialize)                                                               
(global-set-key (kbd "M-X") 'smex)                                             

(elpy-enable)

;; Good stuff, but messes up a bit in python-mode.
;; (require 'whitespace)
;; (setq whitespace-line-column 80) ;; limit line length
;; (setq whitespace-style '(face lines-tail))
;; (add-hook 'prog-mode-hook 'whitespace-mode)
(setq load-home-init-file t) ; don't load init file from ~/.xemacs/init.el

(find-file "~/src/devlog.org")

(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))
