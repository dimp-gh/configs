(provide 'my-global-emacs-stuff)

;; frequent auto-saving and deep undo
(custom-set-variables
 '(auto-save-interval 60)
 '(undo-limit 100000)
 '(undo-strong-limit 150000))

;; add cyrillic layout, change on C-\
(set-input-method "russian-computer")

;; setting defaukt and prefferable encoding
(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; start emacs server to enable opening documents in it via emacsclient
(server-start)

;; go to sources directory
(cd "~/src")

;; Save backup files in ~/.esaves, not in curdir.
(setq backup-directory-alist `(("." . "~/.esaves"))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; set up Projectile
(projectile-global-mode)

;; set up Recentf
(recentf-mode)

;; set up org-journal
(require 'org-journal)
(custom-set-variables
 '(org-journal-dir "~/diar/"))
