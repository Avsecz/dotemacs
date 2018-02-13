
;; default shell
;; from
;; https://github.com/kaushalmodi/.emacs.d/blob/master/setup-files/setup-shell.el
(setq-default sh-shell-file "/bin/bash")

;; CWL mode
(install-package 'cwl-mode
		 )

(require 'cwl-mode)

