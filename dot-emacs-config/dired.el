;; config for opening files etc
;; openwith


(install-package 'openwith)


;; (add-to-list 'load-path "/path/to/downloaded/openwith.el")
(require 'openwith)
(setq openwith-associations
      '(("\\.pdf\\'" "okular" (file))
	;; ("\\.html\\'" "google-chrome" (file))
	("\\.\\(?:jpg\\|jpeg\\)\\'" "eog" (file))
	("\\.png\\'" "eog" (file))
	("\\.doc\\'" "libreoffice" (file))
	))

(openwith-mode t)
;;"/home/avsec/bin/SparkR-pkg-master/sparkR"

;; show dired without group/owner column
(setq dired-listing-switches "-lhGg")


;; open in desktop
(defun xah-open-in-desktop ()
  "Show current file in desktop (OS's file manager).
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2015-06-12"
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (w32-shell-execute "explore" (replace-regexp-in-string "/" "\\" default-directory t t)))
   ((string-equal system-type "darwin") (shell-command "open ."))
   ((string-equal system-type "gnu/linux")
    (let ((process-connection-type nil)) (start-process "" nil "xdg-open" "."))
    ;; (shell-command "xdg-open .") ;; 2013-02-10 this sometimes froze emacs till the folder is closed. ⁖ with nautilus
    )))

(defun my-dired-mode-config ()
  "Modify keymaps used by `dired-mode'."
  (local-set-key (kbd "C-<return>") 'xah-open-in-desktop)
  ;; more here
  )

(add-hook 'dired-mode-hook 'my-dired-mode-config)

;; speedbar
(custom-set-variables
 '(speedbar-show-unknown-files t)
)
