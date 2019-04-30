;; computer specific configurations

;; --------------------------------------------
;; ess
;; determine which ess shell to use

;; use R 3.2.2
(setq inferior-R-program-name "/opt/modules/i12g/R/3.4.2-Bioc3.5/bin/R")
;; (setq inferior-R-program-name "/usr/bin/R")


(if (at-home-ubuntu)
;;(setq inferior-R-program-name "/gcm/opt/gagneur/R/3.1.2/bin/R")
    (setq inferior-R-program-name "/home/avsec/bin/anaconda3/bin/R")
  )

(if (at-home-desk)
;;(setq inferior-R-program-name "/gcm/opt/gagneur/R/3.1.2/bin/R")
    (setq inferior-R-program-name "/home/avsec/bin/anaconda3/bin/R")
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
      ;; (setq default-frame-alist (append (list 
      ;; 					 '(width  . 81)  ; Width set to 81 characters 
      ;; 					 '(height . 50)) ; Height set to 50 lines 
      ;; 					default-frame-alist)))
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

(if (at-work)
    (progn
      ;; set a different font size:
      (set-face-attribute 'default nil :height 105)
      ;; (setq default-frame-alist (append (list 
      ;; 					 '(width  . 81)  ; Width set to 81 characters 
      ;; 					 '(height . 50)) ; Height set to 50 lines 
      ;; 					default-frame-alist))
      )
  )


;; --------------------------------------------
;; from: https://emacs.stackexchange.com/questions/28390/quickly-adjusting-text-to-dpi-changes
(defun my-dpi ()
  (let* ((attrs (car (display-monitor-attributes-list)))
         (size (assoc 'mm-size attrs))
         (sizex (cadr size))
         (res (cdr (assoc 'geometry attrs)))
         (resx (- (caddr res) (car res)))
         dpi)
    (catch 'exit
      ;; in terminal
      (unless sizex
        (throw 'exit 10))
      ;; on big screen
      (when (> sizex 1000)
        (throw 'exit 10))
      ;; DPI
      (* (/ (float resx) sizex) 25.4))))

(defun my-preferred-font-size ()
  (let ( (dpi (my-dpi)) )
  (cond
    ((< dpi 110) 10)
    ((< dpi 130) 11)
    ((< dpi 160) 12)
    (t 12))))

(defvar my-preferred-font-size (my-preferred-font-size))

(defvar my-regular-font
  (cond
   ((eq window-system 'x) (format "DejaVu Sans Mono-%d:weight=normal" my-preferred-font-size))
   ((eq window-system 'w32) (format "Courier New-%d:antialias=none" my-preferred-font-size))))
(defvar my-symbol-font
  (cond
   ((eq window-system 'x) (format "DejaVu Sans Mono-%d:weight=normal" my-preferred-font-size))
   ((eq window-system 'w32) (format "DejaVu Sans Mono-%d:antialias=none" my-preferred-font-size))))

(cond
 ((eq window-system 'x)
  (if (and (fboundp 'find-font) (find-font (font-spec :name my-regular-font)))
      (set-frame-font my-regular-font)
    (set-frame-font "7x14")))
 ((eq window-system 'w32)
  (set-frame-font my-regular-font)
  (set-fontset-font nil 'cyrillic my-regular-font)
  (set-fontset-font nil 'greek my-regular-font)
  (set-fontset-font nil 'phonetic my-regular-font)
  (set-fontset-font nil 'symbol my-symbol-font)))
;; --------------------------------------------

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
				  ; "~/projects-work/deepcis/deepcis.org"
				  )))
       ;; '(org-agenda-files (quote ("~/droak/notes")))
       '(org-default-notes-file "~/droak/notes/work.org"))
      ))
