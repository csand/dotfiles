;;; init-modeline.el --- Personal modeline setup

(defconst mode-line-buffer-info
  '(:eval (concat
           (if (buffer-modified-p) "*" "-")
           " "
           (propertize (buffer-name) 'face '(:weight bold))
           " "
           (propertize (format-mode-line "%lL,%cC") 'face '(:weight light))
           )))

(defconst mode-line-evil-tag
  '(:eval (cond
           ((not (evil-visual-state-p)) (upcase (symbol-name evil-state)))
           ((eq evil-visual-selection 'block) "V-BLOCK")
           ((eq evil-visual-selection 'line) "V-LINE")
           (t "VISUAL")
           )))

(defconst mode-line-mode-list
  '(:eval (concat
           "("
           (propertize mode-name 'face '(:weight bold))
           (format-mode-line minor-mode-alist)
           ")"
           )))

(defconst mode-line-vc-info
  '(:eval (concat
           ""
           vc-mode
           " ("
           (symbol-name (vc-state (buffer-file-name)))
           ")"
           )))

(setq-default mode-line-format
              '(:eval (concat
                       ;; (if evil-mode (format-mode-line mode-line-evil-tag))
                       (if evil-mode evil-mode-line-tag)
                       (format-mode-line mode-line-buffer-info)
                       (format "%-20s" (format-mode-line mode-line-misc-info))
                       (format-mode-line mode-line-mode-list)
                       )))

;; Value:
;; ("%e"
;;  (:eval (winum-get-number-string))
;;  mode-line-front-space
;;  mode-line-mule-info
;;  mode-line-client
;;  mode-line-modified
;;  mode-line-remote
;;  mode-line-frame-identification
;;  mode-line-buffer-identification
;;  "   "
;;  mode-line-position
;;  evil-mode-line-tag
;;  (vc-mode vc-mode)
;;  "  "
;;  mode-line-modes
;;  mode-line-misc-info
;;  mode-line-end-spaces)

(provide 'init-modeline)
