(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; enabling narrowing
(put 'narrow-to-defun  'disabled nil) 
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
;; default file coding
(setq default-buffer-file-coding-system 'utf-8-unix)
