;; layout

(tool-bar-mode 0)
;;(global-set-key [f12]    'tool-bar-mode)

;; highlight-indentation

(install-package 'highlight-indentation
		 'smart-mode-line
		 )
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#2f3f3f")
;; (require 'highlight-indent-guides)
;; (use-package highlight-indent-mode :config (add-hook 'prog-mode-hook #'highlight-indent-guides-mode))
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)



;; turn off emacs alarm (say when pressing C-g)
(setq ring-bell-function 'ignore)

;; 
(column-number-mode 1)
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)

;; Display the time in the mode line
;; (setq display-time-24hr-format t)
;; (setq display-time-day-and-date t)
;; (display-time)


;;--------------------------------------------
;; smart line mode
(install-package 'smart-mode-line
		 'use-package
		 'diminish
		 )

;; https://github.com/Malabarba/smart-mode-line
(use-package smart-mode-line
  :init
  (progn
    (setq sml/line-number-format    "%4l")
    (setq sml/name-width            40) ; buffer name width in the mode-line
    (setq sml/mode-width            'full) ; minor mode lighters area width
    (setq sml/no-confirm-load-theme t)
    (setq sml/theme 'light)
    )
  :config
  (progn
    (use-package rich-minority
      :config
      (progn
        (setq rm-blacklist
              '(" WK"        ; which-key
		" Projectile"
		" hc"        ; hardcore mode
                " AC"        ; auto-complete
                " vl"        ; global visual line mode enabled
                " Wrap"      ; shows up if visual-line-mode is enabled for that buffer
                " Omit"      ; omit mode in dired
                " yas"       ; yasnippet
                " drag"      ; drag-stuff-mode
                " VHl"       ; volatile highlights
                " ctagsU"    ; ctags update
                " Undo-Tree" ; undo tree
                " wr"        ; Wrap Region
                " SliNav"    ; elisp-slime-nav
                " Fly"       ; Flycheck
                " PgLn"      ; page-line-break
                " ElDoc"     ; eldoc
                " GG"        ; ggtags
                " hs"        ; hideshow
                " hs+"       ;
                " ez-esc"    ; easy-escape
                " ivy"       ; ivy
                " h"         ; hungry-delete-mode
                ))
	))
    (sml/setup)))

(provide 'setup-mode-line)
;;--------------------------------------------
;; 

					; make file name and computer title

(setq frame-title-format `(,(user-login-name) "@" ,
			   (system-name) "     " global-mode-string "     %f" ))


(setq font-lock-maximum-decoration t)

(custom-set-variables
 '(column-number-mode t)
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
)


;; set a different font size:
(set-face-attribute 'default nil :height 105)
(setq default-frame-alist (append (list 
				   '(width  . 90)  ; Width set to 81 characters 
				   '(height . 50)) ; Height set to 50 lines 
				  default-frame-alist))
