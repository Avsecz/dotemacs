;; hide/show shortcuts + turn on visual line for some modes 
;; outline mode (hide/show)
;; auto-complete-mode

;; Do not hide comments when hidding all
(setq hs-hide-comments-when-hiding-all nil)

(add-hook 'Tex-mode-hook 'outline-minor-mode) ;;LaTeX
(add-hook 'Tex-mode-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'show-entry)
	    (local-set-key (kbd "C-c <left>")  'hide-entry)
	    (local-set-key (kbd "C-c <up>")    'hide-body)
	    (local-set-key (kbd "C-c <down>")  'show-all)
	    ))

;; text mode
(add-hook 'text-mode-hook 'outline-minor-mode) 
(add-hook 'text-mode-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'show-entry)
	    (local-set-key (kbd "C-c <left>")  'hide-entry)
	    (local-set-key (kbd "C-c <up>")    'hide-body)
	    (local-set-key (kbd "C-c <down>")  'show-all)
	    ))


;; Show hide blocks
(add-hook 'c-mode-common-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
	    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
	    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
	    (local-set-key (kbd "C-c <down>")  'hs-show-all)
	    (hs-minor-mode t)))

(add-hook 'elpy-mode-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
	    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
	    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
	    (local-set-key (kbd "C-c <down>")  'hs-show-all)
	    (hs-minor-mode t)))
(add-hook 'c++-mode-common-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
	    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
	    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
	    (local-set-key (kbd "C-c <down>")  'hs-show-all)
	    (hs-minor-mode t)))
(add-hook 'ess-mode-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
	    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
	    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
	    (local-set-key (kbd "C-c <down>")  'hs-show-all)
	    (hs-minor-mode t)))

(add-hook 'sh-mode-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
	    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
	    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
	    (local-set-key (kbd "C-c <down>")  'hs-show-all)
	    (hs-minor-mode t)))


;;---------we don't tile words if the line is too short-----;;
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'gnuplot-mode-hook 'turn-on-visual-line-mode)
(add-hook 'c-mode-hook 'turn-on-visual-line-mode)
(add-hook 'java-mode-hook 'turn-on-visual-line-mode)
(add-hook 'c++-mode-hook 'turn-on-visual-line-mode)
(add-hook 'tex-mode-hook 'turn-on-visual-line-mode)




(defun hs-hide-leafs-recursive (minp maxp)
  "Hide blocks below point that do not contain further blocks in
    region (MINP MAXP)."
  (when (hs-find-block-beginning)
    (setq minp (1+ (point)))
    (funcall hs-forward-sexp-func 1)
    (setq maxp (1- (point))))
  (unless hs-allow-nesting
    (hs-discard-overlays minp maxp))
  (goto-char minp)
  (let ((leaf t))
    (while (progn
	     (forward-comment (buffer-size))
	     (and (< (point) maxp)
		  (re-search-forward hs-block-start-regexp maxp t)))
      (setq pos (match-beginning hs-block-start-mdata-select))
      (if (hs-hide-leafs-recursive minp maxp)
	  (save-excursion
	    (goto-char pos)
	    (hs-hide-block-at-point t)))
      (setq leaf nil))
    (goto-char maxp)
    leaf))

;; Run hs-hide-level
(defun hs-hide-leafs ()
  "Hide all blocks in the buffer that do not contain subordinate
    blocks.  The hook `hs-hide-hook' is run; see `run-hooks'."
  (interactive)
  (hs-life-goes-on
   (save-excursion
     (message "Hiding blocks ...")
     (save-excursion
       (goto-char (point-min))
       (hs-hide-leafs-recursive (point-min) (point-max)))
     (message "Hiding blocks ... done"))
   (run-hooks 'hs-hide-hook)))


;; hide all comments
(defun hs-hide-all-comments ()
  "Hide all top level blocks, if they are comments, displaying only first line.
Move point to the beginning of the line, and run the normal hook
`hs-hide-hook'.  See documentation for `run-hooks'."
  (interactive)
  (hs-life-goes-on
   (save-excursion
     (unless hs-allow-nesting
       (hs-discard-overlays (point-min) (point-max)))
     (goto-char (point-min))
     (let ((spew (make-progress-reporter "Hiding all comment blocks..."
                                         (point-min) (point-max)))
           (re (concat "\\(" hs-c-start-regexp "\\)")))
       (while (re-search-forward re (point-max) t)
         (if (match-beginning 1)
	     ;; found a comment, probably
	     (let ((c-reg (hs-inside-comment-p)))
	       (when (and c-reg (car c-reg))
		 (if (> (count-lines (car c-reg) (nth 1 c-reg)) 1)
		     (hs-hide-block-at-point t c-reg)
		   (goto-char (nth 1 c-reg))))))
         (progress-reporter-update spew (point)))
       (progress-reporter-done spew)))
   (beginning-of-line)
   (run-hooks 'hs-hide-hook)))


