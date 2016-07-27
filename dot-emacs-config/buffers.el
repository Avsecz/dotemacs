;; handle buffers 
;; - scrolling
;; - splitting (shortcuts)
;; - shrink/enlarge window
;; 
(install-package 'scroll-restore
		 'smooth-scrolling
		 'transpose-frame	;for swaping the windows
		 'fic-mode		;highlight TODO's in text
		 'projectile		;project management
		 'flx-ido		;suggested by projectile
		 )

;; http://projectile.readthedocs.io/en/latest/configuration/
;; .projectile file for initializatio
;; C-u C-c p f -> override the project scope. Choose the actual .projectile file
(projectile-global-mode)

(def-projectile-commander-method ?c
  "Run `compile' in the project."
  (projectile-compile-project nil))

;; highlight TODO comments in code
(require 'fic-mode)
;; use the following keywords -- "FIXME" "TODO" "BUG"
(add-hook 'elpy-mode-hook 'turn-on-fic-mode)
(add-hook 'ess-mode-hook 'turn-on-fic-mode)
(add-hook 'sh-mode-hook 'turn-on-fic-mode)

;; Projectile:
(projectile-global-mode)



;;----------------------------------------------------
;;    scrolling
;;
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)
(and (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(require 'smooth-scrolling)		 
;; http://www.emacswiki.org/emacs/SmoothScrolling
(setq smooth-scroll-margin 2)
;;----------------------------------------------------
;;close buffer completions after finding the right option
(add-hook 'minibuffer-exit-hook 
	  '(lambda ()
	     (let ((buffer "*Completions*"))
	       (and (get-buffer buffer)
		    (kill-buffer buffer)))))


;; --------------------------------------------
;; easy keys to split window. Key based on ErgoEmacs keybinding
(global-set-key (kbd "M-5") 'delete-other-windows) ; expand current pane
(global-set-key (kbd "M-3") 'split-window-vertically) ; split pane top/bottom
;; (global-set-key (kbd "C-!") 'split-window-horizontally)
(global-set-key (kbd "M-4") 'split-window-horizontally)
(global-set-key (kbd "M-1") 'other-window) ; cursor to other pane
;; (global-set-key (kbd "M-SPC") 'other-window) ; this would overwrite "just-one-space"
;;(global-set-key (kbd "<C-tab>") 'other-window) ; cursor to other pane
(global-set-key (kbd "M-2") 'delete-window) ; close current pane
;;(define-key global-map (kbd "<C-S-iso-lefttab>") 'previous-multiframe-window)
(define-key global-map (kbd "M-¸") 'previous-multiframe-window)
(global-set-key (kbd "S-<up>") 'windmove-up)
(global-set-key (kbd "S-<down>") 'windmove-down)
(global-set-key (kbd "S-<right>") 'windmove-right)
(global-set-key (kbd "S-<left>") 'windmove-left)
;; (global-set-key (kbd "<M-kp-4>") 'shrink-window-horizontally)
;; (global-set-key (kbd "<M-kp-2>") 'shrink-window)
;; (global-set-key (kbd "<M-kp-8>") 'enlarge-window)
;; (global-set-key (kbd "<M-kp-6>") 'enlarge-window-horizontally)

(global-set-key (kbd "<M-S-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<M-S-down>") 'shrink-window)
(global-set-key (kbd "<M-S-up>") 'enlarge-window)
(global-set-key (kbd "<M-S-right>") 'enlarge-window-horizontally)

;; kill buffer rebind to C-shift-w
(global-set-key (kbd "C-S-w") 'kill-this-buffer)


;; Swap buffers
;; http://stackoverflow.com/questions/1774832/how-to-swap-the-buffers-in-2-windows-emacs
;; ‘flip-frame’ … Flip vertically

       ;; +------------+------------+      +------------+------------+
       ;; |            |     B      |      |            D            |
       ;; |     A      +------------+      +------------+------------+
       ;; |            |     C      |  =>  |            |     C      |
       ;; +------------+------------+      |     A      +------------+
       ;; |            D            |      |            |     B      |
       ;; +-------------------------+      +------------+------------+
(global-set-key (kbd "C-x M-3") 'flip-frame)
;; ‘flip-frame’ … Flip vertically

;;        +------------+------------+      +------------+------------+
;;        |            |     B      |      |            D            |
;;        |     A      +------------+      +------------+------------+
;;        |            |     C      |  =>  |            |     C      |
;;        +------------+------------+      |     A      +------------+
;;        |            D            |      |            |     B      |
;;        +-------------------------+      +------------+------------+
(global-set-key (kbd "C-x M-4") 'flop-frame)

;; ‘rotate-frame-clockwise’ … Rotate 90 degrees clockwise

;;        +------------+------------+      +-------+-----------------+
;;        |            |     B      |      |       |        A        |
;;        |     A      +------------+      |       |                 |
;;        |            |     C      |  =>  |   D   +--------+--------+
;;        +------------+------------+      |       |   B    |   C    |
;;        |            D            |      |       |        |        |
;;        +-------------------------+      +-------+--------+--------+
(global-set-key (kbd "C-x M-1") 'rotate-frame-clockwise)

;;------------------------------------------------------------------------------------------
;; restore the cursor after browsing
;; http://emacs.stackexchange.com/questions/61/let-emacs-move-the-cursor-off-screen/2273#2273
(require 'scroll-restore)
;; Allow scroll-restore to modify the cursor face
;; (setq scroll-restore-handle-cursor t)
;; ;; Make the cursor invisible while POINT is off-screen
;; (setq scroll-restore-cursor-type t)
;; ;; Jump back to the original cursor position after scrolling
;; (setq scroll-restore-jump-back t)
;; ;; ;; Toggle scroll-restore-mode with the Scroll Lock key
;; (global-set-key (kbd "<Scroll_Lock>") 'scroll-restore-mode)
(scroll-restore-mode t)
;;------------------------------------------------------------------------------------------

;; --------------------------------------------
;; open the buffer menu diffectly

;; (global-set-key "\C-x\C-b" 'buffer-menu)

(global-set-key (kbd "C-x C-b") 'my-buffer-menu)
(defun my-buffer-menu()
  (interactive)
  (buffer-menu)
  (Buffer-menu-toggle-files-only 1))

;; convenient shortcut for ibuffer

(global-set-key (kbd "C-x M-b") 'ibuffer)
