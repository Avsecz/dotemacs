;; functions to get system name

;; --------------------------------------------
;; vzeto iz
;; https://sigquit.wordpress.com/2008/09/28/single-dot-emacs-file/
(defun insert-system-name()
  (interactive)
  "Get current system's name"
  (insert (format "%s" system-name))
  )

;; naredi isto za službo
(defun at-home-ubuntu ()
  (interactive)
  "Return true if you are at home"
  (string-equal system-name "ubuntu.ubuntu-domain")
  )

(defun at-qbm ()
  (interactive)
  "Return true if you are at home"
  (string-equal system-name "qbm-ubuntu")
  )

(defun at-work ()
  (interactive)
  "Return true if you are at work"
  (string-prefix-p "gagneur-desk07" system-name)
  )

