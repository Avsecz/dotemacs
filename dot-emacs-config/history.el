;; functions to recover history

;; get the recently open files list
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key  [f12] 'recentf-open-files)

;;---------------------------------------------------
;; Bookmarks, currently disabled
;; http://ergoemacs.org/emacs/bookmark.html
;; http://www.emacswiki.org/emacs/BookMarks
;; Start emacs with bookmark list
;; (setq inhibit-splash-screen t)

;; (require 'bookmark)
;; (bookmark-bmenu-list)
;; ;; (switch-to-buffer "*Bookmark List*")

;; (setq bookmark-save-flag 1) ; auto-save


;; Options:
;; 1 - everytime bookmark is changed, automatically save it
;; t - save bookmark when emacs quits 
;; nil - never auto save.
;; 
;; bookmark location: ~/.emacs.d/bookmarks
;;---------------------------------------------------

;; ----------------------------------------------------------------------------------------
;; reopen killed buffer like in a browser: C-Shift-t
;; ----------------------------------------------------------------------------------------
(defvar killed-file-list nil
  "List of recently killed files.")

(defun add-file-to-killed-file-list ()
  "If buffer is associated with a file name, add that file to the
`killed-file-list' when killing the buffer."
  (when buffer-file-name
    (push buffer-file-name killed-file-list)))

(add-hook 'kill-buffer-hook #'add-file-to-killed-file-list)

(defun reopen-killed-file ()
  "Reopen the most recently killed file, if one exists."
  (interactive)
  (when killed-file-list
    (find-file (pop killed-file-list))))

(global-set-key (kbd "C-T") 'reopen-killed-file)
