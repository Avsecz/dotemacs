;; pyhon configuration

;; install required pip packages as listed in:
;; https://github.com/jorgenschaefer/elpy

;; Used resource:
;; https://www.fullstackpython.com/emacs.html
;; http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/
;; https://realpython.com/blog/python/emacs-the-best-python-editor/
;;
;;Packages to install with pip:
;;# Either of these
;; pip install rope
;; pip install jedi
;; # flake8 for code checks
;; pip install flake8
;; # importmagic for automatic imports
;; pip install importmagic
;; # and autopep8 for automatic PEP8 formatting
;; pip install autopep8
;; # and yapf for code formatting
;; pip install yapf
;;
;; configure flake8:
;; paste into: ~/.config/flake8
;; [flake8]
;; ignore = E111# , F401  # imported but unused
;; max-line-length = 160
;;
;; for jedi autocomplete:
;; conda install jedi
;; conda install virtualenv
;; pip install epc
;; http://tkf.github.io/emacs-jedi/latest/

;; connecto to a noteboko:
;; ein:notebooklist-open

(install-package 'elpy
		 'ein			;emacs ipyton notebook
		 ;; 'anaconda-mode
		 'flycheck
		 'py-autopep8
		 'company-jedi
		 'epc
		 'helm-pydoc
		 )

;; (require 'epc)
;; (require 'deferred)

;; (setq elpy-modules (delq 'elpy-module-company elpy-modules))
;; enable elpy
(elpy-enable)
;; use ipython

;; enable jedi
(add-hook 'python-mode-hook 'jedi:setup)
; (setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional

;; specify to use python3
;; (setq py-python-command "python3")

(setq python-shell-interpreter "~/bin/anaconda3/bin/python3")
;; (if (at-work)
;;     (setq python-shell-interpreter "~/bin/python_tf")
;; )
(setq elpy-rpc-python-command "python3")

(elpy-use-ipython)

(setq python-shell-interpreter-args "--pylab") ;; --pdb

;; disable indentation highlighting
(remove-hook 'elpy-modules 'elpy-module-highlight-indentation)

;; disable auto-complete mode for python
(add-hook 'elpy-mode-hook
          (lambda ()
             ;; (setq autopair-dont-activate t)
             (auto-complete-mode -1))
)

(setenv "WORKON_HOME"
	(concat (file-name-directory (executable-find "ipython")) "../envs")
)
(pyvenv-mode 1)


;; Autocomplete
;; (eval-after-load "python"
;;   '(define-key inferior-python-mode-map "\t" 'python-shell-completion-complete-or-indent)
;; )

;; (add-hook 'elpy-mode-hook 'anaconda-mode)
;; (add-hook 'elpy-mode-hook 'anaconda-eldoc-mode)

;; shitch buffers
(define-key elpy-mode-map (kbd "C-c C-SPC") 'elpy-shell-switch-to-shell)
(define-key inferior-python-mode-map (kbd "C-c C-SPC") 'elpy-shell-switch-to-buffer)

;; add flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
;; ignoring:
;; - E501 - Try to make lines fit within --max-line-length characters.
;; - W293 - Remove trailing whitespace on blank line.
;; - W391 - Remove trailing blank lines.
;; - W690 - Fix various deprecated code (via lib2to3).
;; - E302 - expected white lines
(require 'py-autopep8)
(setq py-autopep8-options '("--ignore=E501,W293,W391,W690,E302"))
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python special folding - overwrite C-c <up>
;; http://emacs.stackexchange.com/questions/18381/hideshow-with-python-hiding-only-one-part
;; (defun py-outline-level ()
;;   (let (buffer-invisibility-spec)
;;     (save-excursion
;;       (skip-chars-forward "\t ")
;;       (current-column))))

;; (defun hide-body-recenter ()
;;   (interactive)
;;   (hide-body)
;;   (recenter))

;; (defun my-pythonFold-hook ()
;;   (setq outline-regexp "[^ \t\n]\\|[ \t]*\\(def[ \t]+\\|class[ \t]+\\)")
;;   (setq outline-level 'py-outline-level)
;;   (outline-minor-mode t)
;;   (define-key elpy-mode-map (kbd "C-c <up>") 'hide-body-recenter)
;;   (define-key elpy-mode-map (kbd "C-c <down>") 'show-all)
;; )

;; (add-hook 'elpy-mode-hook 'my-pythonFold-hook)


;; fix from https://github.com/bbatsov/projectile/issues/1033
(fset 'projectile-go-function 'projectile-go)
;; (projectile-register-project-type 'go projectile-go-function "go build ./..." "go test ./...")

;; (defcustom projectile-go-function 'projectile-go
;;   "Function to determine if project's type is go."
;;   :group 'projectile
;;   :type 'function)

;; (projectile-register-project-type 'emacs-cask '("Cask") "cask install")
;; ;; snip
;; (projectile-register-project-type 'go projectile-go-function "go build ./..." "go test ./...")
;; tell emacs where to read abbrev definitions from...
(setq abbrev-file-name "~/.emacs.d/abbrev_defs")

;; use helm-pydoc - https://github.com/syohex/emacs-helm-pydoc
(with-eval-after-load "python"
  (define-key python-mode-map (kbd "C-c C-d") 'helm-pydoc))
