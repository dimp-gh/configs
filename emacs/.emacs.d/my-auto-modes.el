(provide 'my-auto-modes)

;; auto-mode lists go here
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))
