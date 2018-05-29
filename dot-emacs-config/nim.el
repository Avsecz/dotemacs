(install-package 'nim-mode
		 'flycheck-nim)

;; (flycheck-nimsuggest-setup)

(setq nimsuggest-path (executable-find "nimsuggest"))

(add-hook 'nim-mode-hook 'nimsuggest-mode)
(add-hook 'nimsuggest-mode-hook 'company-mode)  ; auto complete package
(add-hook 'nimsuggest-mode-hook 'flycheck-mode) ; auto linter package


;; #(setq nimsuggest-path "path/to/nimsuggest")

