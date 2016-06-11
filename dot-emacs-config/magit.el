;; magit config

(install-package 'magit)
;; http://stackoverflow.com/questions/3124844/what-are-your-favorite-global-key-bindings-in-emacs
;; Magit rules!
(global-set-key (kbd "C-x g") 'magit-status)
(add-hook 'magit-mode-hook
      (lambda ()
        (local-unset-key (kbd "M-1"))
	(local-unset-key (kbd "M-2"))
	(local-unset-key (kbd "M-3"))
	(local-unset-key (kbd "M-4"))))
