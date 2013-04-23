(setq user-full-name "Dmitry Pribysh")
(setq user-mail-address "dmand@yandex.ru")


(tool-bar-mode 0)
(scroll-bar-mode 0)


(require 'linum)
(global-linum-mode)

(require 'windmove)
(windmove-default-keybindings 'meta)

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
  "Figure out if the current window is on top, bottom or in the middle"
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

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))
(add-to-list 'load-path  "~/.emacs.d/")


(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)


;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)
;;
(require 'latex-pretty-symbols)


(set-default-font "-adobe-Source Code Pro-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
;todo keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t!)" "STARTED(s!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "OPEN(O!)" "|" "CLOSED(C!)"))))

(global-set-key [C-kp-add] 'text-scale-increase)
(global-set-key [C-kp-subtract] 'text-scale-decrease)


;; solarized and monokai are accessible via 
;; color-theme-solarized and color-theme-monokai
;; nice grey theme
(require 'zenburn-theme)
;; nice brown-red theme
;; (require 'birds-of-paradise-plus-theme)
;; almost nice tango theme
;; (require 'color-theme-tango)
;; color-theme-sanityinc-tomorrow-eighties is also quite nice

(require 'auto-complete-config)
(ac-config-default)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-interval 60)
 '(speedbar-default-position (quote left))
 '(speedbar-show-unknown-files t)
 '(speedbar-smart-directory-expand-flag t)
 '(speedbar-use-images nil)
 '(undo-limit 100000)
 '(undo-strong-limit 150000))

;; Save backup files in ~/.esaves, not in curdir.
(setq backup-directory-alist `(("." . "~/.esaves"))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; add cyrillic layout, change on C-\
(set-input-method "russian-computer")

;; Line-wrapping mode.
(global-visual-line-mode t)

;; Turn on snippets
(yas-global-mode t)


(require 'scala-mode2)


;; Load the ensime lisp code...
(add-to-list 'load-path "~/.emacs.d/ensime_2.10.0-0.9.8.9/elisp/")
(require 'ensime)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; configure how ensime highlights errors
(custom-set-faces
 '(ensime-errline ((((class color) (background dark)) nil)))
 '(ensime-errline-highlight ((t (:background "firebrick2"))))
 )

;; splitting emacs window horizontally
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; enabling powerline
;; (powerline-center-theme)


;; start emacs server to enable opening documents in it via emacsclient
(server-start)


(require 'zone)
(zone-when-idle 120)
