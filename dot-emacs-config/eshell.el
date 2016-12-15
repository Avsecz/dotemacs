;; get history
(require 'helm-eshell)
(define-key shell-mode-map (kbd "C-c C-l") 'helm-comint-input-ring)

(add-hook 'eshell-mode-hook
          (lambda ()
            (eshell-cmpl-initialize)
            (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete)
	    (define-key eshell-mode-map (kbd "C-c C-l") 'helm-eshell-history)
	    (define-key eshell-mode-map (kbd "C-p") 'eshell-previous-input)
	    (define-key eshell-mode-map (kbd "C-n") 'eshell-next-input)
	    (define-key eshell-mode-map (kbd "<up>") 'previous-line)
	    (define-key eshell-mode-map (kbd "<next>") 'next-line)
	    (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history))
	  )

;; http://www.howardism.org/Technical/Emacs/eshell-fun.html
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-c <SPC>") 'eshell-here)
(global-set-key (kbd "C-!") 'eshell-here)

(defun eshell/x (&rest args)
  (delete-single-window))
