
(custom-set-variables
 '(ide-skel-tabbar-mwheel-mode nil t)
  '(tabbar-button-highlight ((t (:inherit tabbar-button))))
 '(tabbar-highlight ((t nil)))
 '(tabbar-mode t nil (tabbar))
 '(tabbar-scroll-left-button (quote (("") "")))
 '(tabbar-scroll-right-button (quote (("") "")))
 )


;; load the tabbar ruler
(load "~/.emacs.d/mylisp/tabbar-ruler-20140905.1543/tabbar-ruler.el")
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

;; (tabbar-ruler-group-user-buffers)
(tabbar-ruler-group-by-projectile-project)


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



;;--------------------------------------------------------------------------------------------------


