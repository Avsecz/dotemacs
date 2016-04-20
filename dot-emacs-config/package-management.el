;; this script contains package management with


;; run with - (install-packages 'ess 'magit 'eval-in-repl)

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ;; ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))


(defun install-package (&rest packages)
  "Install a packages if it is not installed already"

  ;; make sure to have downloaded archive description.
  ;; Or use package-archive-contents as suggested by Nicolas Dudebout
  (or (file-exists-p package-user-dir)
      (package-refresh-contents))
  
  ;; install the packages
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (unless (package-installed-p package)
       (message (format "Installing package: %s" package))
       (package-install package)))
   packages)
  )


;; old

;; ;; define packages to install
;; (defvar myPackages
;;   '(magit
;;     ;; ess   ;; -- install ess from melpa
;;     ;; better-defaults
;;     ;; ein
;;     ;; elpy
;;     ;; flycheck
;;     ;; material-theme
;;     ;; py-autopep8
;;     ))

;; install all the pacakges if not installed already
;; (mapc #'(lambda (package)
;; 	  (unless (package-installed-p package)
;; 	    (package-install package)))
;;       myPackages)
