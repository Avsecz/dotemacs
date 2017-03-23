;; helm config
(install-package 'helm
		 'helm-projectile
		 'helm-descbinds
		 'projectile		;project management
		 'flx-ido		;suggested by projectile
		 'bind-key
		 )


;; --------------------------------------------

(require 'helm)
(require 'helm-config)
(require 'helm-projectile)
(require 'bind-key)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z


(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq
 ;; open helm buffer inside current window, not occupy whole other window
 helm-split-window-in-side-p           t 
 ;; move to end or beginning of source when reaching top or bottom of source.
 helm-move-to-line-cycle-in-source     t 
 ;; search for library in `require' and `declare-function' sexp.
 helm-ff-search-library-in-sexp        t 
 ;; scroll 8 lines other window using M-<next>/M-<prior>
 helm-scroll-amount                    8 
 helm-ff-file-name-history-use-recentf t)

(helm-mode 1)


(global-set-key (kbd "M-x") 'helm-M-x)
;; (helm-autoresize-mode nil)

;; (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

;; kill-ring
(global-set-key (kbd "M-y") 'helm-show-kill-ring)


(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; nice command:
;; helm-multi-files

;; unix locate command:
;; helm-locate

;; Nice command introduced:
;; ffap


;; more of a source code seach tool ack-grep:
;; (when (executable-find "ack-grep")
;;   (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
;;         helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

;; using semantic matching
;; TODO keybind 
(semantic-mode 1)
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)

;; using viewing man pages
(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

;; prefix / - search
;; or C-u prefix / - choose directory to start
;; prefix m - man pages
;; prefix i - imenui
;; prefix l - locate



(setq helm-locate-fuzzy-match t)

;; occur - search within the current buffer
(global-set-key (kbd "C-c h o") 'helm-occur)

;; appropos
;; prefix + a
(setq helm-apropos-fuzzy-match t)

;; fuzzy completion at point:
;; prefix + tab
(setq helm-lisp-fuzzy-completion t)

;; resume:
;; prefix b

;; google:
;; prefix g
(global-set-key (kbd "C-c h g") 'helm-google-suggest)

;; colors - prefix c

;; caclulate:
;; prefix C-,

;; history
(define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)


;; helm help
(require 'helm-descbinds)
(helm-descbinds-mode)

;;;; --------------------------------------------
;; Projectile
;; projectile + helm:
;; http://tuhdo.github.io/helm-projectile.html

;; http://projectile.readthedocs.io/en/latest/configuration/
;; .projectile file for initializatio
;; C-u C-c p f -> override the project scope. Choose the actual .projectile file
(projectile-global-mode)

(def-projectile-commander-method ?c
  "Run `compile' in the project."
  (projectile-compile-project nil))

;; Projectile:
(projectile-global-mode)

(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)
(bind-key* "C-c b" 'helm-projectile)
;; (setq projectile-enable-caching t)

;; ----------------------------------
;; Occur todo macros
;; answer minibuffer promt:
;; http://emacs.stackexchange.com/questions/10393/how-can-i-answer-a-minibuffer-prompt-from-elisp
(defun occur-todo ()
  (interactive)
  (funcall 'occur "TODO")
  ;; (with-minibuffer-input (call-interactively 'occur)
  ;;   "\\(foo\\)\\(bar\\)" "\\1");;C-u C-x C-e
  ;; (interactive)
  ;; (helm-occur) ;; inser in-between
  ;; (insert "TODO")
  )

(global-set-key (kbd "C-c t") 'occur-todo)

(defun projectile-multi-occur-todo ()
  (interactive)
  (run-with-timer .05 nil 'insert "TODO")
  (run-with-timer .1 nil 'execute-kbd-macro (kbd "RET"))
  (projectile-multi-occur)
  )
(global-set-key (kbd "C-c p SPC") 'projectile-multi-occur-todo)
