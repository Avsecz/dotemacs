;; useful functions for editing
;; redo

;; support for docker
(install-package 'dockerfile-mode)

;; redo command ---------------------------------
;; (require 'redo+) ; - it doesn't work properly...

(require 'redo)

(global-set-key [(control :)] 'redo)
(setq x-select-enable-clipboard t)

;; If this is a script what you wrote - make it automatically executable
(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)

;; center with C-l
(global-set-key [(control l)]  'centerer)

(defun centerer ()
  "Repositions current line: once middle, twice top, thrice bottom"
  (interactive)
  (cond ((eq last-command 'centerer2)  ; 3 times pressed = bottom
	 (recenter -1))
	((eq last-command 'centerer1)  ; 2 times pressed = top
	 (recenter 0)
	 (setq this-command 'centerer2))
	(t                             ; 1 time pressed = middle
	 (recenter)
	 (setq this-command 'centerer1))))

(defun insert-date ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%a %Y-%m-%d - %l:%M %p")))


;; http://stackoverflow.com/questions/3124844/what-are-your-favorite-global-key-bindings-in-emacs
;; Magit rules!
(global-set-key (kbd "C-x g") 'magit-status)
