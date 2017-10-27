;; functions to get system name

;; --------------------------------------------
;; vzeto iz
;; https://sigquit.wordpress.com/2008/09/28/single-dot-emacs-file/
(defun insert-system-name()
  (interactive)
  "Get current system's name"
  (insert (format "%s" system-name))
  )

;; functions to get where you are located
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

;; --------------------------------------------
(defun find-first-non-ascii-char ()
  "Find the first non-ascii character from point onwards."
  ;; https://www.emacswiki.org/emacs/FindingNonAsciiCharacters
  ;; - for debugging
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
        (message "No non-ascii characters."))))
