;; everything that has to do with terminal

(install-package 'multi-term
		 'ssh
		 ;; 'bash-completion
		 )

;; very cool terminal, extremely useful
(require 'multi-term)
;; http://www.emacswiki.org/emacs/MultiTerm
(setq multi-term-program "/bin/bash")
(defun te()
  (interactive)(multi-term)
  )

(require 'ssh)
(add-hook 'ssh-mode-hook
	  (lambda ()
	    (setq ssh-directory-tracking-mode t)
	    (shell-dirtrack-mode t)
	    (setq dirtrackp nil)))
;; bash completion
;; (require 'bash-completion)
;;   (bash-completion-setup)
