;; Tabbar mode config

(custom-set-variables
 '(ide-skel-tabbar-mwheel-mode nil t)
 '(tabbar-button-highlight ((t (:inherit tabbar-button))))
 '(tabbar-highlight ((t nil)))
 '(tabbar-mode t nil (tabbar))
 '(tabbar-scroll-left-button (quote (("") "")))
 '(tabbar-scroll-right-button (quote (("") "")))
 )

;; load the tabbar ruler
;; (load "~/.emacs.d/mylisp/tabbar-ruler-20140905.1543/tabbar-ruler.el")
(install-package 'tabbar-ruler)

(require 'tabbar-ruler)

;; (setq tabbar-buffer-groups-function
;;           (lambda ()
;;             (list "All")))

;; (setq tabbar-cycling-scope nil)
;; (setq tabbar-separator (quote ("  ")))


(setq tabbar-ruler-global-tabbar t) ; If you want tabbar

(setq tabbar-ruler-global-ruler nil) ; if you want a global ruler
(setq tabbar-ruler-popup-menu nil) ; If you want a popup menu.
(setq tabbar-ruler-popup-toolbar nil) ; If you want a popup to toolbar
(setq tabbar-ruler-popup-scrollbar nil) ; If you want to only show the
                                        ; scroll bar when your mouse is moving.

(global-set-key (kbd "<C-next>")  'tabbar-ruler-tabbar-forward-group)
(global-set-key (kbd "<C-tab>")  'tabbar-ruler-tabbar-forward-tab)
(global-set-key (kbd "<C-prior>")  'tabbar-ruler-tabbar-backward-group)
(global-set-key (kbd "<C-S-iso-lefttab>")  'tabbar-ruler-tabbar-backward-tab)

;;--------------------------------------------
;; Buffer grouping function
;; http://unthingable.eat-up.org/posts/2014/Jan/05/emacs-tabbar-tuning/

;; my own function for grouping buffers

;; buffers to ignore
(defun my-tabbar-ruler-projectile-tabbar-buffer-groups ()
  "Return the list of group names BUFFER belongs to.
    Return only one group for each buffer."
  
  (if tabbar-ruler-projectile-tabbar-buffer-group-calc
      (symbol-value 'tabbar-ruler-projectile-tabbar-buffer-group-calc)
    (set (make-local-variable 'tabbar-ruler-projectile-tabbar-buffer-group-calc)
         
         (cond
	  ;; modes get matched sequentially. Hence the first one has predescence.
	  ((memq major-mode '(help-mode apropos-mode Info-mode Man-mode Poly-Ess-Help+R ess-help-mode)) '("Help"))
	  ((string-match "^\\*epc con" (buffer-name)) '("Misc")) ;if the string starts with *epc con, - move to Misc
          ((or (get-buffer-process (current-buffer)) (memq major-mode '(comint-mode compilation-mode))) '("Term"))
          ((string-equal "*" (substring (buffer-name) 0 1)) '("Misc"))
          ((memq major-mode '(org-mode calendar-mode diary-mode)) '("Org")) ; Org
          ((memq major-mode '(dired-mode)) '("Dir"))
	  ;; ((string-equal "\-ex.R" (substring (buffer-name) -5 nil)) '("my_help"))  if the name ends with -ex.R, then creat a new category
          ((condition-case err
               (projectile-project-root)
             (error nil)) (list (projectile-project-name)))
          ((memq major-mode '(ess-mode python-mode emacs-lisp-mode
				       c-mode c++-mode
				       makefile-mode lua-mode vala-mode)) '("Coding")) ; I could also add ess-mode 
          ((memq major-mode '(javascript-mode js-mode nxhtml-mode html-mode css-mode)) '("HTML")) 
	  ((memq major-mode '(rmail-mode rmail-edit-mode vm-summary-mode vm-mode mail-mode
					 mh-letter-mode mh-show-mode mh-folder-mode
					 gnus-summary-mode message-mode gnus-group-mode
					 gnus-article-mode score-mode gnus-browse-killed-mode)) '("Mail"))
          (t '("Main"))))
    (symbol-value 'tabbar-ruler-projectile-tabbar-buffer-group-calc)))

;; enable this function
(setq tabbar-buffer-groups-function 'my-tabbar-ruler-projectile-tabbar-buffer-groups)

;; (defun my-cached (func)
;;   "Turn a function into a cache dict."
;;   (lexical-let ((table (make-hash-table :test 'equal))
;;                 (f func))
;;     (lambda (key)
;;       (let ((value (gethash key table)))
;;         (if value
;;             value
;;           (puthash key (funcall f) table))))))

;; ;; evaluate again to clear cache
;; (setq cached-ppn (my-cached 'my-tabbar-buffer-groups))

;; (defun my-tabbar-groups-by-project ()
;;   (funcall cached-ppn (buffer-name)))


;; (setq tabbar-buffer-groups-function 'my-tabbar-groups-by-project)


;; Interactive function
;; (defun my-toggle-group-by-project ()
;;   (interactive)
;;   (setq my-group-by-project (not my-group-by-project))
;;   (message "Grouping by project alone: %s"
;;            (if my-group-by-project "enabled" "disabled"))
;;   (setq cached-ppn (my-cached 'my-tabbar-buffer-groups)))
;;--------------------------------------------
					;(setq tabbar-background-color "#959A79") ;; the color of the tabbar background
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

(tabbar-install-faces)


;; fix the issue with not properly loading the function:
;; tabbar-install-faces
(defun load_tabbar-install-faces (frame)
  (tabbar-install-faces)
  )

(add-hook 'after-make-frame-functions 'load_tabbar-install-faces)


;;--------------------------------------------------------------------------------------------------


