;; pyhon configuration

;; install required pip packages as listed in:
;; https://github.com/jorgenschaefer/elpy

;; Used resource:
;; https://realpython.com/blog/python/emacs-the-best-python-editor/
;;
;; TODO check 
;; https://www.fullstackpython.com/emacs.html
;; http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/
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

;; connecto to a noteboko:
;; ein:notebooklist-open

(install-package 'elpy
		 'ein			;emacs ipyton notebook
		 'anaconda-mode
		 'flycheck
		 'py-autopep8
		 )

;; enable elpy
(elpy-enable)
;; use ipython

;; specify to use python3
;; (setq py-python-command "python3")

(setq python-shell-interpreter "~/bin/anaconda3/bin/python3")
(if (at-work)
    (setq python-shell-interpreter "~/bin/python_tf")
)
(setq elpy-rpc-python-command "python3")

(elpy-use-ipython)

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


