;; layout

(tool-bar-mode 0)
;;(global-set-key [f12]    'tool-bar-mode)

;; highlight-indentation

(install-package 'highlight-indentation)
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#2f3f3f")
;; (require 'highlight-indent-guides)
;; (use-package highlight-indent-mode :config (add-hook 'prog-mode-hook #'highlight-indent-guides-mode))
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)




(column-number-mode 1)
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)

;; Display the time in the mode line
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)


					; make file name and computer title
(set-default 'frame-title-format 
             (list "" "emacs" "@" (getenv "HOST") " : %f" ))

(setq font-lock-maximum-decoration t)

(custom-set-variables
 '(column-number-mode t)
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
)


;; set a different font size:
(set-face-attribute 'default nil :height 100)
(setq default-frame-alist (append (list 
				   '(width  . 90)  ; Width set to 81 characters 
				   '(height . 50)) ; Height set to 50 lines 
				  default-frame-alist))
