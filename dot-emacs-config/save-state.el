;---Save the State of Emacs to be Loaded next time it is started---
(defun gk-state-saver ()
;;Save names and cursor positions of all loaded files in ".emacs.files"
  (interactive)
  (setq fname (format "%s.emacs.files" gk-startdir))
  (cond 
   ((buffer-file-name)
    (setq currentbuffer (buffer-name)))
   (t
    (setq currentbuffer nil)))
  (cond
   ((y-or-n-p (format "Save state to %s? " fname))
	(switch-to-buffer "*state-saver*")
	(kill-buffer "*state-saver*")
	(switch-to-buffer "*state-saver*")
	(setq bl (buffer-list))
	(while bl
	  (setq buffer (car bl))
	  (setq file (buffer-file-name buffer))
	  (cond 
	   (file 
	p	(insert "(find-file \"" file "\")\n")
		(switch-to-buffer buffer)
		(setq mypoint (point))
		(switch-to-buffer "*state-saver*")
		(insert (format "(goto-char %d)\n" mypoint))))
	  (setq bl (cdr bl)))
	(cond
	 (currentbuffer
	  (insert (format "(switch-to-buffer \"%s\")\n" currentbuffer))))
	(set-visited-file-name fname)
	(save-buffer)
	(kill-buffer ".emacs.files")
	(cond
	 (currentbuffer
	  (switch-to-buffer currentbuffer))))))


;--- Save state when killing emacs ----------
(add-hook 
 'kill-emacs-hook
 '(lambda () 
    (gk-state-saver)))

;--- Remember from where emacs was started --
(defvar gk-startdir default-directory)
(message "state save directory is: %s" gk-startdir)
(sleep-for 1)


;--- Load files from .emacs.files -----------
(cond
 ((file-exists-p ".emacs.files")
  (load-file ".emacs.files")))
