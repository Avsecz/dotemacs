;; computer specific configurations

;; --------------------------------------------
;; ess
;; determine which ess shell to use

;; use R 3.2.2
(setq inferior-R-program-name "/gcm/opt/gagneur/R/3.2.2/bin/R")
;; (setq inferior-R-program-name "/usr/bin/R")


(if (at-home-ubuntu)
;;(setq inferior-R-program-name "/gcm/opt/gagneur/R/3.1.2/bin/R")
    (setq inferior-R-program-name "/usr/bin/R")
)

(if (at-qbm)
;;(setq inferior-R-program-name "/gcm/opt/gagneur/R/3.1.2/bin/R")
    (setq inferior-R-program-name "/usr/bin/R")
)

;; --------------------------------------------
;; determine window specific size

(if (at-home-ubuntu)
    (progn
      ;; set a different font size:
      (set-face-attribute 'default nil :height 105)
      (setq default-frame-alist (append (list 
					 '(width  . 81)  ; Width set to 81 characters 
					 '(height . 50)) ; Height set to 50 lines 
					default-frame-alist)))
  )

(if (at-qbm)
    (progn
      ;; set a different font size:
      (set-face-attribute 'default nil :height 120)
      (setq default-frame-alist (append (list 
					 '(width  . 100)  ; Width set to 81 characters 
					 '(height . 80)) ; Height set to 50 lines 
					default-frame-alist)))
  )


;; --------------------------------------------
;; org mode 
;; config for at-work

(if (at-work)
    '(progn
       (setcdr (assoc "\\.html\\'" org-file-apps) "google-chrome --no-sandbox && google-chrome")
       (setq openwith-associations
	     '(("\\.html\\'" "google-chrome" (file)))
       ))
  )

(if (at-work)
    (progn
      ;; add projects to list
      (custom-set-variables
       '(org-agenda-files (quote ("~/droak/notes/my.org"
				  "~/droak/notes/notes.org"
				  "~/droak/notes/work.org"
				  "~/projects" ; folder containing links to project .org files
				  )))
       ;; '(org-agenda-files (quote ("~/droak/notes")))
       '(org-default-notes-file "~/droak/notes/work.org"))
      ))
