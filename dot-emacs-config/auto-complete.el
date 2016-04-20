;; auto complete

(install-package 'auto-complete)
;; 

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

(add-hook 'Tex-mode-hook 'auto-complete-mode) ;; je že nastavljeno globalno
(add-hook 'text-mode-hook 'auto-complete-mode)
