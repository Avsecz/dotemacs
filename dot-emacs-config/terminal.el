;; everything that has to do with terminal

(install-package 'multi-term 
		 ;; 'bash-completion
		 )

;; very cool terminal, extremely useful
(require 'multi-term)
;; http://www.emacswiki.org/emacs/MultiTerm
(setq multi-term-program "/bin/bash")
(defun te()
  (interactive)(multi-term)
  )

;; bash completion
;; (require 'bash-completion)
;;   (bash-completion-setup)
