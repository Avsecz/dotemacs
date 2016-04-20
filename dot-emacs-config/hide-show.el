;; hide/show shortcuts + turn on visual line for some modes 
;; outline mode (hide/show)
;; auto-complete-mode

;; Do not hide comments when hidding all
(setq hs-hide-comments-when-hiding-all nil)

(add-hook 'Tex-mode-hook 'outline-minor-mode) ;;LaTeX
(add-hook 'Tex-mode-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'show-entry)
	    (local-set-key (kbd "C-c <left>")  'hide-entry)
	    (local-set-key (kbd "C-c <up>")    'hide-body)
	    (local-set-key (kbd "C-c <down>")  'show-all)
	    ))

;; text mode
(add-hook 'text-mode-hook 'outline-minor-mode) 
(add-hook 'text-mode-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'show-entry)
	    (local-set-key (kbd "C-c <left>")  'hide-entry)
	    (local-set-key (kbd "C-c <up>")    'hide-body)
	    (local-set-key (kbd "C-c <down>")  'show-all)
	    ))


;; Show hide blocks
(add-hook 'c-mode-common-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
	    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
	    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
	    (local-set-key (kbd "C-c <down>")  'hs-show-all)
	    (hs-minor-mode t)))

(add-hook 'elpy-mode-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
	    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
	    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
	    (local-set-key (kbd "C-c <down>")  'hs-show-all)
	    (hs-minor-mode t)))
(add-hook 'c++-mode-common-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
	    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
	    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
	    (local-set-key (kbd "C-c <down>")  'hs-show-all)
	    (hs-minor-mode t)))
(add-hook 'ess-mode-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
	    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
	    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
	    (local-set-key (kbd "C-c <down>")  'hs-show-all)
	    (hs-minor-mode t)))

(add-hook 'sh-mode-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
	    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
	    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
	    (local-set-key (kbd "C-c <down>")  'hs-show-all)
	    (hs-minor-mode t)))


;;---------we don't tile words if the line is too short-----;;
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'gnuplot-mode-hook 'turn-on-visual-line-mode)
(add-hook 'c-mode-hook 'turn-on-visual-line-mode)
(add-hook 'java-mode-hook 'turn-on-visual-line-mode)
(add-hook 'c++-mode-hook 'turn-on-visual-line-mode)
(add-hook 'tex-mode-hook 'turn-on-visual-line-mode)
