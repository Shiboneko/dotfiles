;;----------------------------------------------------------------------------
;; set Melpa Repository
;;----------------------------------------------------------------------------
(message "Setting Repositorys")
(require 'package)
(package-initialize)
(setq package-archives
      '(("marmalade" . "http://marmalade-repo.org/packages/")
	("gnu" . "http://elpa.gnu.org/packages/")
	("org" . "http://orgmode.org/elpa/")
	("melpa" . "https://melpa.org/packages/")
	("melpa-stable" . "https://stable.melpa.org/packages/")
	)
      )

;;----------------------------------------------------------------------------
;; define Custom Functions
;;----------------------------------------------------------------------------

(message "Define Custom Functions")
(defun my/emacs-config ()
  (interactive)
  (find-file (concat user-emacs-directory "init.el"))
  )
;;----------------------------------------------------------------------------
;; Initialize use-package
;;----------------------------------------------------------------------------
(message "Initialize use-package")


(unless (package-installed-p 'use-package)
    (package-refresh-contents)
      (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

;;(require 'highlight-symbol)
;;(require 'auto-highlight-symbol)
;;(require 'sublimity)
;;(require 'sublimity-scroll)
;;(require 'sublimity)
;;(require 'minimap)
;;(require 'beacon)
;;(require 'powerline)
;;(require 'smooth-scrolling)
;;(require 'impatient-mode)
;;(require 'recentf)

;-----------------------------------------------------------------------------
;; setup Programm parameters
;;----------------------------------------------------------------------------
(message "Setting up Program Settings")
(tool-bar-mode -1)
(menu-bar-mode 1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)
(add-to-list 'load-path "~/.emacs.d/tweaks/")
(setq compilation-scroll-output t)
(global-set-key (kbd "<f9>") 'compile)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(setq font-lock-maximum-decoration t)
(use-package "relative-line-numbers")
(add-hook 'prog-mode-hook 'relative-line-numbers-mode t)
(add-hook 'prog-mode-hook 'line-number-mode t)
(add-hook 'prog-mode-hook 'column-number-mode t)
(setq suggest-key-bindings 1) ; wait 1 seconds

;;-----------------------------------------------------------------------------
;; Backup Settings
;;-----------------------------------------------------------------------------
(message "Setup Backup Settings")
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;(message "Deleting old backup files...")
;(let ((week (* 60 60 24 7))
;      (current (float-time (current-time))))
;  (dolist (file (directory-files temporary-file-directory t))
;    (when (and (backup-file-name-p file)
;               (> (- current (float-time (fifth (file-attributes file))))
;                  week))
;      (message "%s" file)
;      (delete-file file))))



;;-----------------------------------------------------------------------------
;; customize theme
;;-----------------------------------------------------------------------------

;; (message "Customize Theme")
;;(use-package "smart-mode-line")
(use-package "powerline-evil")
 (use-package "powerline"
 :config
 (load-library "init-powerline")
 )
;; (use-package "smart-mode-line-powerline-theme")

;;(setq sml/no-confirm-load-theme t)
;;(sml/setup)
;; (set-face-attribute 'mode-line nil
;;                      :foreground "Black"
;;                    :background "DarkOrange"
;;                      :box "Purple")
(setq powerline-arrow-shape 'curve)
;;(powerline-evil-vim-color-theme)
;;(setq sml/theme 'powerline)

;; ;(load-theme 'spolsky t)
(air--powerline-default-theme)

;;-----------------------------------------------------------------------------
;; set Font
;;-----------------------------------------------------------------------------
(message "Setup Font")
(if (member "envypn" (font-family-list))
    (set-face-attribute
     'default nil :font "DejaVu Sans Mono 10"))


;;----------------------------------------------------------------------------
;; setup telephone line
;;----------------------------------------------------------------------------
;; (setq telephone-line-lhs
;;       '((evil   . (telephone-line-evil-tag-segment))
;;         (accent . (telephone-line-vc-segment
;;                    telephone-line-erc-modified-channels-segment
;;                    telephone-line-process-segment))
;;         (nil    . (telephone-line-minor-mode-segment
;;                    telephone-line-buffer-segment))))
;; (setq telephone-line-rhs
;;       '((evil   . (telephone-line-airline-position-segment))
;;         (accent . (telephone-line-major-mode-segment))
;;         (nil    . (telephone-line-misc-info-segment))))






;;----------------------------------------------------------------------------
;; setup Transparency Keys
;;----------------------------------------------------------------------------

(message "Setup Transparency Keys")
(defun djcb-opacity-modify (&optional dec)
  "modify the transparency of the emacs frame; if DEC is t,
    decrease the transparency, otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'alpha)) ; nil before setting
          (oldalpha (if alpha-or-nil alpha-or-nil 100))
          (newalpha (if dec (- oldalpha 10) (+ oldalpha 10))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil (list (cons 'alpha newalpha))))))

 ;; C-8 will increase opacity (== decrease transparency) ;; C-9 will decrease opacity (== increase transparency
 ;; C-0 will returns the state to normal
(global-set-key (kbd "C-8") '(lambda()(interactive)(djcb-opacity-modify)))
(global-set-key (kbd "C-9") '(lambda()(interactive)(djcb-opacity-modify t)))
(global-set-key (kbd "C-0") '(lambda()(interactive)(modify-frame-parameters nil `((alpha . 100)))))


;;----------------------------------------------------------------------------
;; Set Global Modes
;;----------------------------------------------------------------------------

(message "Activate Global Modes")
(use-package "company")
(global-company-mode 1)

(use-package "auto-highlight-symbol")
(global-auto-highlight-symbol-mode 1)

(relative-line-numbers-mode 1)
(use-package "beacon")
(beacon-mode 1)
(use-package "tabbar")
;;(minimap-mode 1)
(tabbar-mode 1)
(use-package "evil")
(evil-mode 1)
(use-package "nyan-mode")
(nyan-mode 1)
(use-package "ido")
(ido-mode 1)
(use-package "recentf")
(recentf-mode 1)
(electric-pair-mode 1)
(use-package "rainbow-mode")
(rainbow-mode 1)

(load-library "tabbar-tweaks")
;;-----------------------------------------------------------------------------
;; set custom keybindings
;;----------------------------------------------------------------------------

(message "Set Custom Keybindings")
;;(global-set-key (kbd "C-s") 'evil-write)
;;(global-set-key (kbd ("Tab") 'company-complete)
(global-set-key (kbd "C-z") 'undo)

;;----------------------------------------------------------------------------
;; Customize Minimap
;;----------------------------------------------------------------------------
;; (setq minimap-window-location 'right)
;; (setq minimap-width-fraction 0.05)
;; (setq minimap-minimum-width 15)
;; (setq minimap-always-recenter nil)
;; (setq minimap-update-delay 1)


;;----------------------------------------------------------------------------
;; Customize Company
;;----------------------------------------------------------------------------
(message "Customize Company")
(setq company-tooltip-align-annotations t)
(add-to-list 'company-backends 'company-c-headers)
(global-set-key (kbd "C-<tab>") 'company-complete)


;;----------------------------------------------------------------------------
;; Customize Evil Mode
;;----------------------------------------------------------------------------
(message "Customize Evil Mode")
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))


(setq evil-want-fine-undo t)

(setq evil-operator-state-cursor '("red" hollow))
(setq evil-move-cursor-back nil)


;;----------------------------------------------------------------------------
;; Customize Scroll Behavior
;;----------------------------------------------------------------------------
(message "Customize Scroll Behavior")
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(0.07))

;;----------------------------------------------------------------------------
;; Set Programming Modes
;;----------------------------------------------------------------------------
(message "Setup Programming Modes")
(add-hook 'prog-mode (lambda ()
		       (company-mode 1)
		       (eldoc-mode 1)
		       (global-set-key (kbd "C-S-c") 'comment-or-uncomment-region)
		       (global-set-key (kbd "C-SPC") 'company-complete-common)
		       )
	  )
 
;;----------------------------------------------------------------------------
;; Set Python Mode
;;----------------------------------------------------------------------------
(message "Setup Python Mode")
(add-hook 'python-mode-hook (lambda ()
			      (jedi:setup)
			      (jedi-mode 1)
			      (setq jedi:complete-on-dot t)
			      (company-mode 0)
			      ;;(eldoc-mode 1)
			      ;;(flycheck-mode 1)
			      ;;;(company-quickhelp-mode 1)
			      ;;;(add-to-list 'company-backends 'company-jedi)
			      (global-set-key (kbd "C-S-c") 'comment-or-uncomment-region)
			      (global-set-key (kbd "C-<tab>") 'jedi:complete)
			      )
	  
	  )
;;----------------------------------------------------------------------------
;; Set C Mode
;;----------------------------------------------------------------------------
(message "Setup C Mode")
(add-hook 'c-mode-hook (lambda ()
			 (electric-pair-mode 1)
			 (setq c-default-style "linux" c-basic-offset 4)
			 (local-set-key  (kbd "C-c o") 'ff-find-other-file)
			 )
	  )
;;----------------------------------------------------------------------------
;; Set Javascript Mode
;;----------------------------------------------------------------------------
(message "Setup Javascript mode")
;;(add-hook 'js2-mode-hook 'ac-js2-setup-auto-complete-mode)


(dolist (hook '(js-mode-hook
                js2-mode-hook
                js3-mode-hook
                inferior-js-mode-hook
                ))
  (add-hook hook
            (lambda ()
              (tern-mode t)

              (add-to-list (make-local-variable 'company-backends)
                           'company-tern)
	      )))



;;----------------------------------------------------------------------------
;; Set Java Mode
;;----------------------------------------------------------------------------

;;(use-package "meghanada")
;;(add-hook 'java-mode-hook
;;          (lambda ()
;;           ;; meghanada-mode on
;;            (meghanada-mode t)
;;            (add-hook 'before-save-hook 'delete-trailing-whitespace)))
;; (use-package "meghanada"
;;  :ensure t
;;  :init
;;  ;; Don't auto-start
;;  ;;(setq meghanada-auto-start nil)
;;  (add-hook 'java-mode-hook #'meghanada-mode)
;;  (add-hook 'java-mode-hook 'flycheck-mode))

;; (use-package realgud
;;   :ensure t)

(use-package "eclim")
(custom-set-variables
 '(eclim-eclipse-dirs '("~/.eclim//eclipse"))
 '(eclim-executable "~/.eclim/eclipse/eclim"))


(use-package "eclimd")
(use-package "javadoc-lookup")

(add-hook 'java-mode-hook (lambda ()
			    (eclim-mode)
			    )
	  )



;;----------------------------------------------------------------------------
;; Setup Latex Mode
;;----------------------------------------------------------------------------

(use-package "auctex")
(use-package "company-auctex")

;;----------------------------------------------------------------------------
;; Setup Docker Mode
;;----------------------------------------------------------------------------

(use-package "dockerfile-mode")
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
;;----------------------------------------------------------------------------
;; sml/setup variables
;;----------------------------------------------------------------------------

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    (quote
;;     ("0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "e8a976fbc7710b60b069f27f5b2f1e216ec8d228fe5091f677717d6375d2669f" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "22fd89870f06d0a1ec7b25156aeeb27492d67eb0ec0a424e2636ad85ee1e1604" "9b402e9e8f62024b2e7f516465b63a4927028a7055392290600b776e4a5b9905" "6df30cfb75df80e5808ac1557d5cc728746c8dbc9bc726de35b15180fa6e0ad9" "0ae52e74c576120c6863403922ee00340a3bf3051615674c4b937f9c99b24535" "f1a6cbc40528dbee63390fc81da426f1b00b4fc09a60fe35752f5838b12fbe0a" "cedd3b4295ac0a41ef48376e16b4745c25fa8e7b4f706173083f16d5792bb379" "a802c77b818597cc90e10d56e5b66945c57776f036482a033866f5f506257bca" "40f6a7af0dfad67c0d4df2a1dd86175436d79fc69ea61614d668a635c2cd94ab" default)))
;;  '(package-selected-packages
;;    (quote
;;     (company-tern tern-auto-complete tern ac-js2 zone-nyan zenburn-theme web-mode typing-game tss tronesque-theme tide telephone-line tao-theme tabbar sublimity sublime-themes sr-speedbar spacemacs-theme spaceline solarized-theme smooth-scrolling smart-mode-line-powerline-theme skewer-mode scroll-restore relative-line-numbers rainbow-mode powerline-evil popup-complete pager-default-keybindings on-screen nyan-mode multiple-cursors multi-web-mode monokai-theme moe-theme minimap jedi impatient-mode highlight-symbol helm-fuzzy-find hc-zenburn-theme green-phosphor-theme find-dired+ elpy doremi-cmd dired+ darktooth-theme company-web company-shell company-quickhelp company-lua company-jedi company-c-headers color-theme-sanityinc-tomorrow color-theme clean-buffers calmer-forest-theme beacon bash-completion base16-theme badwolf-theme badger-theme auto-highlight-symbol arduino-mode airline-themes)))
;;  '(tabbar-separator (quote (0.5))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(package-selected-packages
   (quote
    (eclim meghanada meghanda powerline-evil smart-mode-line-powerline rainbow-mode nyan-mode use-package tabbar smart-mode-line relative-line-numbers powerline evil company beacon auto-highlight-symbol)))
 '(tabbar-separator (quote (0.5))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
