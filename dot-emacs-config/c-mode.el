;; config for C programming

;; add c to company
(install-package 'company-c-headers)
(add-to-list 'company-backends 'company-c-headers)

;; http://tuhdo.github.io/c-ide.html
;; also cool tutorial from this guy
;; http://tuhdo.github.io/emacs-for-proglang.html

;; also great mode
;; https://www.cs.bu.edu/teaching/tool/emacs/programming/

;; run the neares make file
(install-package 'cl)
(require 'cl) ; If you don't have it already

(defun* get-closest-pathname (&optional (file "Makefile"))
  "Determine the pathname of the first instance of FILE starting from the current directory towards root.
This may not do the correct thing in presence of links. If it does not find FILE, then it shall return the name
of FILE in the current directory, suitable for creation"
  (let ((root (expand-file-name "/"))) ; the win32 builds should translate this correctly
    (expand-file-name file
		      (loop 
			for d = default-directory then (expand-file-name ".." d)
			if (file-exists-p (expand-file-name file d))
			return d
			if (equal d root)
			return nil))))

 (require 'compile)
 (add-hook 'c-mode-hook (lambda ()
			  (set (make-local-variable 'compile-command)
			       (format "make -f %s" (get-closest-pathname)))))


;; global compile shortcut
(global-set-key "\C-x\C-m" 'compile)
(add-hook 'c-mode-common-hook
	  (lambda()
	    (local-set-key (kbd "C-c s") 'recompile)
	    (set (make-local-variable 'compile-command)
		 (format "make -f %s" (get-closest-pathname)))))


(setq-default c-basic-offset 4)

