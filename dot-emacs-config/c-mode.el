;; config for C programming

;; add c to company
(install-package 'company-c-headers)
(add-to-list 'company-backends 'company-c-headers)

;; http://tuhdo.github.io/c-ide.html
;; also cool tutorial from this guy
;; http://tuhdo.github.io/emacs-for-proglang.html

;; also great mode
;; https://www.cs.bu.edu/teaching/tool/emacs/programming/
