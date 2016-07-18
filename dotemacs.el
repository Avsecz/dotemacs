;; Main emacs config
;;
;; author: avsec 

;; load-your own packages and package-management functions
(setq load-path (cons "~/.emacs.d/mylisp" load-path))
(load "~/.emacs.d/dot-emacs-config/package-management.el")

(load "~/.emacs.d/dot-emacs-config/elisp-functions.el")


;; TODO - make a function that I can just specify file name without load ...
;; (load "~/.emacs.d/dot-emacs-config/package-management.el")

;; install required packages
(install-package 'magit
		 'tabbar
		 'openwith 
		 'outline-magic
		 'color-theme
		 'with-editor
		 'xterm-color
		 'yasnippet
		 ;; 'highlight-parentheses
		 ;; 'shell-command
		 ;; 'redo+   ;; doesn't work properly ... use lisp/redo.el instead
		 )
;; don't use yasnippet in a global mode
(yas-global-mode 0)

;; (setq gnuserv-frame (selected-frame))
;; start emacs server (if there is non running)
(require 'server)
(or (server-running-p)
    (server-start))

;; source .bashrc
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

;; show where the buffer ends
;; (setq default-indicate-empty-lines t)


;; --------------------------------------------
;; shell-script configuration
(load "~/.emacs.d/dot-emacs-config/shell-script.el")

;; --------------------------------------------
;; magit configuration
(load "~/.emacs.d/dot-emacs-config/magit.el")

;; --------------------------------------------
;; everything that has to do with terminal
(load "~/.emacs.d/dot-emacs-config/terminal.el")
;; --------------------------------------------

;; --------------------------------------------
;;require psvn
;;(require 'psvn)
(require 'tabbar)

;; toggle forward - come up with a good shortcut for it
;; (global-set-key (kbd "C-<right>") 'switch-to-next-buffer)
;; (global-set-key (kbd "C-<left>") 'switch-to-prev-buffer)
(tabbar-mode nil)
;; (menu-bar-mode 1)
(setq tabbar-home-button (quote (("[Home]") "[x]")))
;; (tabbar-install-faces)

;; --------------------------------------------
;; --------------------------------------------
;; home specific color theme & layout

;; requires M-x color-theme select   color-theme from elpa
(progn
  (require 'color-theme)
  (color-theme-initialize)
  (setq color-theme-is-global t)
  (color-theme-subtle-hacker))

;; layout
(load "~/.emacs.d/dot-emacs-config/layout.el")


;;----------------------------------------------------

;; get history functions & bookmarks & reopen killed filed with C-S-t
(load "~/.emacs.d/dot-emacs-config/history.el")

;;----------------------------------------------------
(load "~/.emacs.d/dot-emacs-config/auto-complete.el")

;;----------------------------------------------------

;;----------------------------------------------------
;; auctex load the config

(load "~/.emacs.d/dot-emacs-config/auctex-config.el")

;; spell checker
(load "~/.emacs.d/dot-emacs-config/spell-check.el")


;;----------------------------------------------------
;; ido ( for example for buffer switching ) 
					;(require 'ido)
					;(ido-mode t)

;;----------------------------------------------------
;; org mode, override C-tab
(load "~/.emacs.d/dot-emacs-config/org-config.el")

;;----------------------------------------------------

;; shortcut for uncomment region
;;(global-unset-key "\C-c\C-z")
;;(global-set-key "\C-c\C-z" 'uncomment-region)


;; markdown & wiki & gnuplot mode
(load "~/.emacs.d/dot-emacs-config/markdown-wiki-gnuplot.el")


;; (autoload 'R-mode "ess-site.el" "ESS" t)
;; (add-to-list 'auto-mode-alist '("\\.R$" . R-mode))


;;--------------------------------------------------------------
;; hide/show + autocomplete + outline mode
(load "~/.emacs.d/dot-emacs-config/hide-show.el")

;;---------------------------------------------------------------
;; ESS - load Emacs speaks statistics:
(load "~/.emacs.d/dot-emacs-config/ess.el")

;;---------------------------------------------------------------
;; elpy - load python IDE:
(load "~/.emacs.d/dot-emacs-config/python.el")

;;---------------------------------------------------------------
;; web development

(load "~/.emacs.d/dot-emacs-config/html.el")

;;----------------------------------------

(load "~/.emacs.d/dot-emacs-config/editing.el")

;;----------------------------------------------------------------------------------------

;; load and save state - not using it
;; (load "~/.emacs.d/dot-emacs-config/save-state.el")

;; 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1")
 '(LaTeX-math-abbrev-prefix "¸")
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-start-server t)
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#ffffff" "#f36c60" "#8bc34a" "#fff59d" "#4dd0e1" "#b39ddb" "#81d4fa" "#263238"))
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("2305decca2d6ea63a408edd4701edf5f4f5e19312114c9d1e1d5ffe3112cde58" "e97dbbb2b1c42b8588e16523824bc0cb3a21b91eefd6502879cf5baa1fa32e10" default)))
 '(display-time-mode t)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ess-R-font-lock-keywords
   (quote
    ((ess-R-fl-keyword:modifiers . t)
     (ess-R-fl-keyword:fun-defs . t)
     (ess-R-fl-keyword:keywords . t)
     (ess-R-fl-keyword:assign-ops . t)
     (ess-R-fl-keyword:constants . t)
     (ess-fl-keyword:fun-calls . t)
     (ess-fl-keyword:numbers . t)
     (ess-fl-keyword:operators . t)
     (ess-fl-keyword:delimiters . t)
     (ess-fl-keyword:=)
     (ess-R-fl-keyword:F&T))))
 '(fci-rule-color "#37474f")
 '(hl-sexp-background-color "#1c1f26")
 '(ide-skel-tabbar-mwheel-mode nil t)
 '(inhibit-startup-screen t)
 '(mediawiki-site-alist
   (quote
    (("Wikipedia" "http://en.wikipedia.org/w/" "username" "password" "Main Page")
     ("mywiki" "http://gagneurweb.genzentrum.lmu.de/wiki/" "" "" "aggagneur:BayesRare_home"))))
 '(org-agenda-custom-commands
   (quote
    (("h" agenda "home"
      ((org-agenda-tag-filter-preset
	(quote
	 ("HOME")))))
     ("w" agenda "work"
      ((org-agenda-tag-filter-preset
	(quote
	 ("WORK")))))
     ("d" todo "DELEGATED" nil)
     ("c" todo "DONE|DEFERRED|CANCELLED" nil)
     ("W" todo "WAITING" nil)
     ("l" agenda "21 days"
      ((org-agenda-ndays 21)))
     ("A" agenda "#A tasks"
      ((org-agenda-skip-function
	(lambda nil
	  (org-agenda-skip-entry-if
	   (quote notregexp)
	   "\\=.*\\[#A\\]")))
       (org-agenda-ndays 1)
       (org-agenda-overriding-header "Today's Priority #A tasks: ")))
     ("u" alltodo "Unscheduled"
      ((org-agenda-skip-function
	(lambda nil
	  (org-agenda-skip-entry-if
	   (quote scheduled)
	   (quote deadline)
	   (quote regexp)
	   "
]+>")))
       (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
 '(org-agenda-files
   (quote
    ("~/droak/notes/embl.org" "~/droak/notes/work.org" "~/droak/notes/my.org" "~/droak/notes/notes.org")))
 '(org-agenda-ndays 7)
 '(org-agenda-overriding-columns-format
   "%40ITEM(Task) %TODO %SCHEDULED %11Effort(Est. Effort){:} %6CLOCKSUM(T-done)  %6CLOSED(Closed)" t)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-default-notes-file "~/droak/notes/my.org")
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-mobile-files (quote (org-agenda-files "~/droak/notes/my.org")))
 '(org-remember-store-without-prompt t)
 '(org-reverse-note-order t)
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler)))
 '(safe-local-variable-values
   (quote
    ((whitespace-style face tabs spaces trailing lines space-before-tab::space newline indentation::space empty space-after-tab::space space-mark tab-mark newline-mark))))
 '(show-paren-mode t)
 '(speedbar-show-unknown-files t)
 '(tabbar-button-highlight ((t (:inherit tabbar-button))))
 '(tabbar-highlight ((t nil)))
 '(tabbar-mode t nil (tabbar))
 '(tabbar-scroll-left-button (quote (("") "")))
 '(tabbar-scroll-right-button (quote (("") "")))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a"))))
 '(vc-annotate-very-old-color nil))

;; openwith & dired config
(load "~/.emacs.d/dot-emacs-config/dired.el")

;; load buffer shortcuts
(load "~/.emacs.d/dot-emacs-config/buffers.el")


;; tabbar config 
(load "~/.emacs.d/dot-emacs-config/tabbar.el")
;; --------------------------------------------

;; --------------------------------------------
;; system specific config (@home, @qbm etc
(load "~/.emacs.d/dot-emacs-config/system-specific-config.el")
;; --------------------------------------------


;; --------------------------------------------
;; load aliases 
(load "~/.emacs.d/dot-emacs-config/alias.el")
;; --------------------------------------------

;; overwrite jedi:complete
(global-set-key (kbd "<C-tab>")  'tabbar-ruler-tabbar-forward-tab)

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(tabbar-button ((t (:inherit tabbar-default :foreground "dark red"))))
;;  '(tabbar-button-highlight ((t (:inherit tabbar-default))))
;;  '(tabbar-default ((t (:inherit variable-pitch :background "#959A79" :foreground "black" :weight bold))))
;;  '(tabbar-highlight ((t (:underline t))))
;;  '(tabbar-selected ((t (:inherit tabbar-default :background "#95CA59"))))
;;  '(tabbar-separator ((t (:inherit tabbar-default :background "#95CA59"))))
;;  '(tabbar-unselected ((t (:inherit tabbar-default)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tabbar-button ((t (:inherit tabbar-default :foreground "dark red"))))
 '(tabbar-button-highlight ((t (:inherit tabbar-default))))
 '(tabbar-default ((t (:inherit variable-pitch :background "#959A79" :foreground "black" :weight bold))))
 '(tabbar-highlight ((t (:underline t))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#95CA59"))))
 '(tabbar-separator ((t (:inherit tabbar-default :background "#95CA59"))))
 '(tabbar-unselected ((t (:inherit tabbar-default)))))


