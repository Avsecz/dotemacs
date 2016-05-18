;; 
;; required packages for this config
(install-package 'org 
		 'outline-magic)

(require 'org)

;;----------------------------------------------------
;; make links clickable also in R like they are in org-mode
;; https://github.com/seanohalpin/org-link-minor-mode
;; BUG / unwanted feature - it can happen, that my R code has the form [[smthn][smthn]]
;; I would need to change the regex for link from [[*][*]] to ##[[*][*]]

;; 
;; (require 'org-link-minor-mode)
;; (add-hook 'R-mode-hook 'org-link-minor-mode)
;;----------------------------------------------------

;; 

(require 'org-mouse)
(define-key org-mode-map
  (kbd "C-<tab>") 'tabbar-forward)
(add-hook 'org-mode-hook 'auto-complete-mode)
(setq display-time-day-and-date t)

;; unbind M-S-<up> etc for window resizing in org
(define-key org-mode-map
  (kbd "M-S-<up>") nil)
(define-key org-mode-map
  (kbd "M-S-<down>") nil)
(define-key org-mode-map
  (kbd "M-S-<right>") nil)
(define-key org-mode-map
  (kbd "M-S-<left>") nil)

;; default browser = goolge chrome
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome-stable")

;; default viewer for pdf's in org
;; (eval-after-load "org"
;;   '(progn
;;      ;; Change .pdf association directly within the alist
;;      (setcdr (assoc "\\.png\\'" org-file-apps) "eog %s")
;;      (setcdr (assoc "\\.pdf\\'" org-file-apps) "okular %s")))

(add-hook 'org-mode-hook
      '(lambda ()
         (setq org-file-apps
           '((auto-mode . emacs)
             ("\\.mm\\'" . default)
             ("\\.x?html?\\'" . default)
             ("\\.pdf\\'" . "evince %s")
             ("\\.png\\'" . "eog %s")
	     ))))

;; --- insert here



;; ------
(add-hook 'calendar-load-hook
	  (lambda ()
	    (calendar-set-date-style 'european)))

;; Start the calendar with monday
(setq calendar-week-start-day 1)

;; use english language instead of german 
;; link - http://stackoverflow.com/questions/28913294/emacs-org-mode-language-of-time-stamps
(setq system-time-locale "C") 
(setq solar-n-hemi-seasons
      '("Frühlingsanfang" "Sommeranfang" "Herbstanfang" "Winteranfang"))

(setq general-holidays
      '((holiday-fixed 1 1 "Neujahr")
        (holiday-fixed 5 1 "1. Mai")
        (holiday-fixed 10 3 "Tag der Deutschen Einheit")))

(setq christian-holidays
      '(
        (holiday-float 12 0 -4 "1. Advent" 24)
        (holiday-float 12 0 -3 "2. Advent" 24)
        (holiday-float 12 0 -2 "3. Advent" 24)
        (holiday-float 12 0 -1 "4. Advent" 24)
        (holiday-fixed 12 25 "1. Weihnachtstag")
        (holiday-fixed 12 26 "2. Weihnachtstag")
        (holiday-fixed 1 6 "Heilige Drei Könige")
        ;; Date of Easter calculation taken from holidays.el.
        (let* ((century (1+ (/ displayed-year 100)))
               (shifted-epact (% (+ 14 (* 11 (% displayed-year 19))
                                    (- (/ (* 3 century) 4))
                                    (/ (+ 5 (* 8 century)) 25)
                                    (* 30 century))
                                 30))
               (adjusted-epact (if (or (= shifted-epact 0)
                                       (and (= shifted-epact 1)
                                            (< 10 (% displayed-year 19))))
                                   (1+ shifted-epact)
                                 shifted-epact))
               (paschal-moon (- (calendar-absolute-from-gregorian
                                 (list 4 19 displayed-year))
                                adjusted-epact))
               (easter (calendar-dayname-on-or-before 0 (+ paschal-moon 7))))
          (filter-visible-calendar-holidays
           (mapcar
            (lambda (l)
              (list (calendar-gregorian-from-absolute (+ easter (car l)))
                    (nth 1 l)))
            '(
              (-48 "Rosenmontag")
              ( -2 "Karfreitag")
              (  0 "Ostersonntag")
              ( +1 "Ostermontag")
              (+39 "Christi Himmelfahrt")
              (+49 "Pfingstsonntag")
              (+50 "Pfingstmontag")
              (+60 "Fronleichnam")
              ))))
        (holiday-fixed 8 15 "Mariä Himmelfahrt")
        (holiday-fixed 11 1 "Allerheiligen")
        (holiday-float 11 3 1 "Buß- und Bettag" 16)
        (holiday-float 11 0 1 "Totensonntag" 20)))

(setq calendar-holidays
      (append general-holidays local-holidays other-holidays
              christian-holidays solar-holidays))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 



(eval-after-load 'outline
  '(progn
     (require 'outline-magic)
     (define-key outline-minor-mode-map (kbd "<backtab>") 'outline-cycle)))
(setq org-return-follows-link t)

;; new keybind:
;; (global-set-key (kbd "<f6>") (lambda() (interactive)(find-file "~/.file.org")))
;; define a new function - open file.org
(defun mylibr ()
  (interactive)(find-file "~/file.org"))

;; (autoload 'org-mode-flyspell-verify "flyspell" "" t)
(add-hook 'org-mode-hook 'flyspell-mode) ;;flyspell for org
;; (ac-flyspell-workaround)
;; (setq ispell-dictionary "english")


;; -----------------
;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; ---- config from http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner/ 
(setq org-directory "~/droak/notes")

(custom-set-variables
 '(org-agenda-files (quote ("~/droak/notes/my.org" "~/droak/notes/notes.org" "~/droak/notes/work.org" "~/projects")))
 ;; '(org-agenda-files (quote ("~/droak/notes")))
 '(org-default-notes-file "~/droak/notes/my.org")
 ;; '(org-default-notes-file "~/notes.org")
 '(org-agenda-skip-deadline-if-done t)	;dont' show in agenda if done
 '(org-agenda-skip-scheduled-if-done t)
 ;; use a special general column view for agenda
 '(org-agenda-overriding-columns-format "%40ITEM(Task) %TODO %SCHEDULED %11Effort(Est. Effort){:} %6CLOCKSUM(T-done)  %6CLOSED(Closed)")
 ;; '(org-deadline-warning-days 14)
 '(org-agenda-ndays 7)			;always show only the next 7 days
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-show-all-dates t)
 '(org-reverse-note-order t)
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-agenda-custom-commands
   (quote (("h" agenda "home" ((org-agenda-tag-filter-preset '("HOME"))))
	   ("w" agenda "work" ((org-agenda-tag-filter-preset '("WORK"))))
	   ("d" todo "DELEGATED" nil)
	   ("c" todo "DONE|DEFERRED|CANCELLED" nil)
	   ("W" todo "WAITING" nil)
	   ("l" agenda "21 days" ((org-agenda-ndays 21)))
	   ("A" agenda "#A tasks"
	    ((org-agenda-skip-function
	      (lambda nil
		(org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
	     (org-agenda-ndays 1)
	     (org-agenda-overriding-header "Today's Priority #A tasks: ")))
	   ("u" alltodo "Unscheduled"
	    ((org-agenda-skip-function
	      (lambda nil
		(org-agenda-skip-entry-if (quote scheduled) (quote deadline)
					  (quote regexp) "\n]+>")))
	     (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
 '(org-remember-store-without-prompt t)
 ;; (org-remember-templates
 ;;  (quote ((116 "* TODO %?\n  %u" "~/todo.org" "Tasks")
 ;; 	  (110 "* %u %?" "~/notes.org" "Notes"))))
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler)))
 )




;; *quick capture* with C-c c -> save to /droak/notes/notes.org

(setq org-default-notes-file (concat org-directory "~/droak/notes/inbox.org"))

;; (define-key global-map "\C-cc" 'org-capture)


;; directly choose org-capure C-c i
(define-key global-map "\C-cc"
  (lambda () (interactive) (org-capture nil "i")))

(setq org-capture-templates
      '(;; ("t" "Todo" entry (file+headline "~/droak/notes/notes.org" "Tasks")
	;;  "* TODO %?\n  %i\n  %a")
        ;; ("j" "Journal" entry (file+datetree "~/org/journal.org")
        ;;      "* %?\nEntered on %U\n  %i\n  %a")
        ("i" "Inbox" entry (file "~/droak/notes/inbox.org")
	 "* %U %?\n %i \n  %a")
	))


;; global todo's
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "PROJ(p)" "DELEGATED(l)" "APPT(a)" "|" "DONE(d)" "DEFERRED(f)" "CANCELLED(c)")))

;; global tags
(setq org-tag-alist 
      '(("HOME" . ?h) 
	("WORK" . ?w) 
	("someday_maybe" . ?s)
	("@city" . ?c)
	("google" . ?g)
	("buy" . ?b)
	("Brigita" . ?B)
	("read" . ?r)
	("program" . ?p)
	;; ("project" . ?p)
	))



;; mobile org

;; (setq org-mobile-directory "~/droak/MobileOrg")
;; ;; (setq org-mobile-inbox-for-pull "~/droak/notes/from-mobile.org")
;; (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

;; project tag is not inheritable
(setq org-tags-exclude-from-inheritance '("project"))

;; open a link in thunderbird - requires thunderlink installed
(require 'org)

(org-add-link-type "thunderlink" 'org-thunderlink-open)
(defun org-thunderlink-open (path)
  "Opens a specified email in Thunderbird with the help of the add-on ThunderLink." (start-process "myname" nil "thunderbird" "-thunderlink" (concat "thunderlink:" path)))

(provide 'org-thunderlink)

;; use a different colour for the weekend
;; used from https://gist.github.com/stardiviner/7908902

(set-face-attribute 'org-agenda-date-weekend nil
                    :foreground nil
                    :background nil
                    :box '(:color "gray" :line-width -2 :style nil)
                    :bold t)

;; Diary entry (holidays)
(set-face-attribute 'org-agenda-diary nil
                    :foreground "green"
                    :background nil
                    :bold 'normal
                    :box '(:color "green" :line-width 2 :style nil))



;; calender settings


;; mark the today's date 
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;; colour the weekends with orange
;; http://stackoverflow.com/questions/24008106/how-to-highlight-weekend-days-in-emacs-calendar
(defadvice calendar-generate-month
    (after highlight-weekend-days (month year indent) activate)
  "Highlight weekend days"
  (dotimes (i 31)
    (let ((date (list month (1+ i) year)))
      (if (or (= (calendar-day-of-week date) 0)
              (= (calendar-day-of-week date) 6))
          (calendar-mark-visible-date date 'font-lock-doc-string-face)))))




;; set initial buffer to org agenda
;; http://stackoverflow.com/questions/2010539/how-can-i-show-the-org-mode-agenda-on-emacs-start-up 

(setq initial-buffer-choice (lambda ()
			      (org-agenda-list 1)
			      (delete-other-windows)
			      (get-buffer "*Org Agenda*")))


;; --------------------------------------------
;; include R support
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (sh . t)
   (emacs-lisp . t)
   (latex . t)
   ))
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)   
(add-hook 'org-mode-hook 'org-display-inline-images)   
(setq org-confirm-babel-evaluate nil) ;; don't ask me to evaluate babel code 

;; custom variables
(custom-set-variables
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
    ("~/droak/notes/embl.org" "~/bayesRare/main.org" "~/droak/notes/my.org" "~/droak/notes/notes.org")))
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
 )
