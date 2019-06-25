;; Packaging
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; Eye candy
(load-theme 'wombat)
(menu-bar-mode -1)
(when window-system
  (set-frame-font "DejaVu Sans Mono 10")
  (tooltip-mode -1)
  (tool-bar-mode -1))
(require 'all-the-icons)

;; Global minor modes and configuration
(column-number-mode t)
(delete-selection-mode 1)
(global-font-lock-mode t)
(line-number-mode t)
(projectile-mode t)
(show-paren-mode t)
(transient-mark-mode t)
(toggle-scroll-bar -1)
(setq
 font-lock-maximum-decoration t
 history-length 999
 indent-tabs-mode nil
 inhibit-startup-echo-area-message t
 inhibit-startup-screen t
 initial-scratch-message nil
 require-final-newline t
 scroll-conservatively 1
 scroll-preserve-screen-position t
 scroll-step 1
 tab-width 8
 )

;; Encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Backup
(setq
 auto-save-file-name-transforms (\` ((".*" "~/.filebackups" t)))
 backup-by-copying t
 backup-directory-alist (\` ((".*" . "~/.filebackups")))
 delete-old-versions t
 kept-new-versions 99
 kept-old-versions 99
 make-backup-files t
 vc-make-backup-files t
 version-control t
 )

;; Mouse
(setq
 mouse-drag-copy-region nil
 mouse-wheel-follow-mouse t
 mouse-wheel-progressive-speed nil
 mouse-wheel-scroll-amount '(3 ((shift) . 3))
 mouse-yank-at-point t
 )

;; Keymap
(global-set-key (kbd "ESC <up>") 'windmove-up)
(global-set-key (kbd "ESC <down>") 'windmove-down)
(global-set-key (kbd "ESC <right>") 'windmove-right)
(global-set-key (kbd "ESC <left>") 'windmove-left)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-[ 1 ; 3 a") 'windmove-up)
(global-set-key (kbd "M-[ 1 ; 3 b") 'windmove-down)
(global-set-key (kbd "M-[ 1 ; 3 c") 'windmove-right)
(global-set-key (kbd "M-[ 1 ; 3 d") 'windmove-left)
(global-set-key (kbd "M-[ 1 ; 5 A") 'backward-paragraph)
(global-set-key (kbd "M-[ 1 ; 5 B") 'forward-paragraph)
(global-set-key (kbd "M-[ 1 ; 5 C") 'forward-word)
(global-set-key (kbd "M-[ 1 ; 5 D") 'backward-word)
(global-set-key (kbd "M-[ a") 'backward-paragraph)
(global-set-key (kbd "M-[ b") 'forward-paragraph)
(global-set-key (kbd "M-[ c") 'forward-word)
(global-set-key (kbd "M-[ d") 'backward-word)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-x") 'kill-region)
(global-set-key (kbd "\C-x\C-m") 'execute-extended-command)
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-n") 'new-scratchpad)

;; Programming
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(defun my-c-mode-hook ()
  (setq
   c-default-style "linux"
   c-basic-offset 8
   indent-tabs-mode nil
   copmany-tooltip-align-assignment t
   lsp-enable-snippet nil
   gdb-many-windows t
   gdb-show-main t))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

;; Custom functions
(defun new-scratchpad ()
  "Create a new scratchpad."
  (interactive)
  (switch-to-buffer (concat "scratch-" (number-to-string (abs (random))))))

;; Aliases
(defalias 'yes-or-no-p 'y-or-n-p)

;; Hooks
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Automatically handled by package management
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet flycheck-clang-analyzer flycheck-clang-tidy flycheck-clangcheck flycheck-color-mode-line company-box all-the-icons company-lsp dap-mode flymake-cppcheck json-mode company flycheck lsp-ui lsp-mode cmake-mode projectile))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;; init.el ends here
