;; spell check

;; maybe this solution:?
;; https://josephhall.org/nqb2/index.php/reftex-1
;; (global-auto-revert-mode t)
;;----------------------------------------------------
;; flyspell - spell checker

;;(setq-default ispell-program-name "aspell")
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
(ac-flyspell-workaround)
(setq ispell-dictionary "english")


;; modes to include
(autoload 'tex-mode-flyspell-verify "flyspell" "" t)
(add-hook 'tex-mode-hook 'flyspell-mode) ;;LaTeX
(add-hook 'LaTeX-mode-hook 'flyspell-mode) ;;LaTeX this works http://stackoverflow.com/questions/8332163/flyspell-doesnt-load-with-latex-file-in-emacs


;;-------------------------------------------------------
;; flymake - check your syntax in latex
;; (require 'flymake)

;; (defun flymake-get-tex-args (file-name)
;; (list "pdflatex"
;; (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

;; (add-hook 'LaTeX-mode-hook 'flymake-mode)

