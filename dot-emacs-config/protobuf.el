;; protobuf-mode

(install-package 'protobuf-mode
		 'flycheck-protobuf)
(require 'protobuf-mode)

;; enable flyspell
(dolist (hook '(protobuf-mode-hook))
  (add-hook hook (lambda () (flycheck-mode 1))))
