;; auto complete

(install-package 'auto-complete
		 'company
		 'company-quickhelp
		 )
;; 

(require 'auto-complete)
(require 'auto-complete-config)



(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; (ac-config-default)
;; (global-auto-complete-mode t)
;; (add-hook 'Tex-mode-hook 'auto-complete-mode) ;; je že nastavljeno globalno
;; (add-hook 'text-mode-hook 'auto-complete-mode)

;; https://github.com/expez/company-quickhelp
(company-quickhelp-mode 1)

