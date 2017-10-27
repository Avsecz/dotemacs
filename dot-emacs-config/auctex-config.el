;; auctex config file

(install-package 'auctex 
		 'auto-complete-auctex
		 'auctex-latexmk)



(setq tex-run-command "pdflatex")
(add-hook 'TeX-mode-hook
          (lambda () (TeX-fold-mode 1))); Automatically activate TeX-fold-mode.
;;--------------   -------------------------

;; reftex - added from http://piotrkazmierczak.com/2010/emacs-as-the-ultimate-latex-editor/

;; use latexmk
(auctex-latexmk-setup)
(setq auctex-latexmk-inherit-TeX-PDF-mode t)
;; -------

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil) 		;dont ask to save if you want to compile with C-c C-c
(setq TeX-PDF-mode t)
(setq-default TeX-master nil)
(require 'tex-site)

(require 'auto-complete-auctex) ; enables \begmath, \begitem shortcuts
(add-hook 'Tex-mode-hook 'yas-minor-mode) ;so that you don't get the error yas not enabled


;; math-mode - convinient shortcuts
(add-hook 'TeX-mode-hook 'LaTeX-math-mode) ;math mode by defaulty
(custom-set-variables
 '(LaTeX-math-abbrev-prefix "¸")) 	;rebind ` to ¸ in auctex

(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq reftex-plug-into-AUCTeX t)
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-label "reftex-label" "Make label" nil)
(autoload 'reftex-reference "reftex-reference" "Make label" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; bibtex
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
;; (add-hook 'reftex-load-hook '(reftex-use-external-file-finders t))
;; (setq reftex-external-file-finders
;; '(("tex" . "kpsewhich -format=.tex %f")
;;   ("bib" . "kpsewhich -format=.bib %f")))

;; (eval-after-load 'helm-mode '(add-to-list 
;;     'helm-completing-read-handlers-alist '(reftex-citation . nil) )
;; 		 )

(setq LaTeX-eqnarray-label "eq"
 LaTeX-equation-label "eq"
 LaTeX-figure-label "fig"
LaTeX-table-label "tab"
LaTeX-myChapter-label "chap"
TeX-auto-save t
TeX-newline-function 'reindent-then-newline-and-indent
TeX-parse-self t
TeX-style-path
'("style/" "auto/"
"/usr/share/emacs21/site-lisp/auctex/style/"
"/var/lib/auctex/emacs21/"
"/usr/local/share/emacs/site-lisp/auctex/style/")
LaTeX-section-hook
'(LaTeX-section-heading
LaTeX-section-title
;; LaTeX-section-toc
LaTeX-section-section
LaTeX-section-label))
(eval-after-load
    "latex"
  '(TeX-add-style-hook
    "cleveref"
    (lambda ()
      (if (boundp 'reftex-ref-style-alist)
      (add-to-list
       'reftex-ref-style-alist
       '("Cleveref" "cleveref"
         (("\\cref" ?c) ("\\Cref" ?C) ("\\cpageref" ?d) ("\\Cpageref" ?D)))))
      (reftex-ref-style-activate "Cleveref")
      (add-to-list 'reftex-ref-style-default-list "Cleveref")
      (TeX-add-symbols
       '("cref" TeX-arg-ref)
       '("Cref" TeX-arg-ref)
       '("cpageref" TeX-arg-ref)
       '("Cpageref" TeX-arg-ref)))))


;; biblatex citation style:

;; (eval-after-load 'reftex-vars
;;   '(progn
;;      ;; (also some other reftex-related customizations)
;;      (setq reftex-cite-format
;;            '((?\C-m . "\\cite[]{%l}")
;; 	     (?a . "\\autocite[]{%l}")
;;              (?p . "\\parencite[]{%l}")
;;              (?f . "\\footcite[][]{%l}")
;;              (?t . "\\textcite[]{%l}")
;;              (?o . "\\citepr[]{%l}")
;; 	     (?F . "\\fullcite[]{%l}")
;;              (?n . "\\nocite{%l}")
;; 	     ;; (?x . "[]{%l}")
;; 	     ;; (?X . "{%l}")
;; 	     ))))
;; (setq reftex-cite-prompt-optional-args t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
'(TeX-source-correlate-method (quote synctex))
'(TeX-source-correlate-start-server t)
'(inhibit-startup-screen t))


; Make RefTeX interact with AUCTeX, http://www.gnu.org/s/auctex/manual/reftex/AUCTeX_002dRefTeX-Interface.html

;; this line caused a bug in reftex!!!!! : :/


;; (setq reftex-file-extensions
;;       '(("tex" ".Rnw" ".nw" ".tex")
;;         ("bib" ".bib")))



;; -----------------------
;; viewing pdf's

;; I could change this
(load "~/.emacs.d/dot-emacs-config/auctex-okular.el")
;; autocompletion?  https://www.gnu.org/software/auctex/manual/auctex/FAQ.html iz te strani

;; -----

(eval-after-load "tex"
       '(add-to-list 'TeX-command-list
		     '("myLaTeX" "sh ./myLaTeX.sh %s" TeX-run-command nil t :help "run your compilation command together with bibtex") t))

;; (defun reftex-format-cref (label def-fmt)
;;   (format "\\cref{%s}" label))
;; (setq reftex-format-ref-function 'reftex-format-cref)


;; set \\cref to default: (you could change this)
(setq reftex-refstyle "\\cref")



;; I don't need this anymore as bibliography parsing works perfectly
;; (setq reftex-default-bibliography 
;;       '("~/bayesRare/master_thesis/master_tex/bibliography/ziga_collection.bib"
;; 	;; "~/bayesRare/master_thesis/master_tex/bibliography/references.bib"
;; 	"~/bayesRare/master_thesis/master_tex/bibliography/hand_made_references.bib"))



;; --------------------------------------------
;; orgtbl-mode as default?
(add-hook 'LaTeX-mode-hook 'orgtbl-mode)
;; don't mess around with sub/superscripts
(setq org-export-with-sub-superscripts nil)
(global-set-key (kbd "C-c C-a ") 'align-current)

(define-key LaTeX-mode-map
  (kbd "C-c t") 'orgtbl-insert-radio-table)

;; --------------------------------------------
;; define your own font shortcut
;; http://tex.stackexchange.com/questions/239544/adding-keybord-shortcut-for-auctex-in-emacs
(add-to-list 'LaTeX-font-list
  '(?\C-v "\\verb+" "+"))

;; ---------------------------------
;; custome variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1")
 '(LaTeX-math-abbrev-prefix "¸")
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-start-server t)
)
