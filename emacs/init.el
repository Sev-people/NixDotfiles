;; --- Sane defaults -------------------------------------------------------
(menu-bar-mode -1) (tool-bar-mode -1) (scroll-bar-mode -1) (blink-cursor-mode -1) (electric-indent-mode -1) (electric-pair-mode 1) (transient-mark-mode -1)
(setq org-edit-src-content-indentation 0) ; Indentation
(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files"))) ; Trash collection
(setq ring-bell-function 'ignore) ; Stop bell sounds
(global-visual-line-mode 1) ; Truncate lines
(setq custom-file null-device) ; Prevent custom-set-variables from editing this file
(repeat-mode) ; Useful mode for repeated commands
(setq sentence-end-double-space nil) ; Sentences are ended with one space

; Melpa - for direnv
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; --- Org mode -------------------------------------------------------
(use-package org :load-path "~/.dotfiles/emacs/elpa/org-mode/lisp/")
(require 'org)
(require 'org-indent)
(require 'tempo)

; Org protocol
(require 'org-protocol)

; Allows multi-line emphasis markers
(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)

; Makes emphasis markers work around em dashes
(setq org-emphasis-regexp-components
      '("-—[:space:]('\"{"
	"-—[:space:].,:!?;'\")}\\["
	"[:space:]"
	"."
	1))

(setq org-return-follows-link t)
(add-hook 'org-mode-hook 'org-indent-mode)

;; --- Theme -------------------------------------------------------
(modify-all-frames-parameters '((internal-border-width . 16))) ; Window margins/padding

(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 140 :weight 'light) ; Font

; Defining colors
(defconst theme-colors
  '((fg          . "#EBE9E7")
    (bg          . "#121212")
    (ultralight  . "#2c2c34")
    (highlight   . "#212228")
    (lowlight    . "#1A1919")
    (urgent      . "#CF6752")
    (crucial     . "#F4BF4F")
    (focus       . "#7A9EFF")
    (strong      . "#F5F2F0")
    (meek        . "#A3A3A3")
    (mild        . "#474648")
    (faint       . "#37373E")
    (black       . "#000000")
    (white       . "#FFFFFF")
    (red         . "#EC6A5E")
    (green       . "#62C554")
    (blue        . "#81a1c1")
    (yellow      . "#F2DA61")
    (orange      . "#d08770")
    (aqua        . "#85CCC6")
    (cyan        . "#00FFFF")
    (purple      . "#9D67E6"))
  "Color palette for theme.")

; Frame
(set-face-attribute 'default nil :background (alist-get 'bg theme-colors) :foreground (alist-get 'fg theme-colors))
(set-face-attribute 'cursor nil :background (alist-get 'fg theme-colors))
(set-face-attribute 'fringe nil :background (alist-get 'bg theme-colors) :weight 'light)
(set-face-attribute 'region nil :background (alist-get 'mild theme-colors))
(set-face-attribute 'secondary-selection nil :background (alist-get 'ultralight theme-colors))
(set-face-attribute 'buffer-menu-buffer nil :background (alist-get 'strong theme-colors))
(set-face-attribute 'minibuffer-prompt nil :background (alist-get 'bg theme-colors) :foreground (alist-get 'yellow theme-colors))
(set-face-attribute 'vertical-border nil :background (alist-get 'bg theme-colors) :foreground (alist-get 'mild theme-colors))
(set-face-attribute 'internal-border nil :background (alist-get 'bg theme-colors) :foreground (alist-get 'bg theme-colors))
(set-face-attribute 'show-paren-match nil :background (alist-get 'ultralight theme-colors) :foreground (alist-get 'yellow theme-colors) :weight 'bold)
(set-face-attribute 'show-paren-mismatch nil :background (alist-get 'ultralight theme-colors) :foreground (alist-get 'urgent theme-colors) :weight 'bold :box t)
(set-face-attribute 'link nil :background (alist-get 'lowlight theme-colors) :foreground (alist-get 'strong theme-colors) :underline t)
(set-face-attribute 'shadow nil :foreground (alist-get 'ultralight theme-colors) :weight 'light)
(set-face-attribute 'mode-line-active nil :background (alist-get 'faint theme-colors) :foreground (alist-get 'fg theme-colors) :box `(:line-width 2 :color ,(alist-get 'faint theme-colors)))
(set-face-attribute 'mode-line-inactive nil :background (alist-get 'lowlight theme-colors) :foreground (alist-get 'fg theme-colors) :box `(:line-width 2 :color ,(alist-get 'lowlight theme-colors)))

; Basic faces
(set-face-attribute 'error nil :foreground (alist-get 'red theme-colors) :bold t)
(set-face-attribute 'success nil :foreground (alist-get 'green theme-colors) :bold t)
(set-face-attribute 'warning nil :foreground (alist-get 'yellow theme-colors) :bold t)
(set-face-attribute 'trailing-whitespace nil :background (alist-get 'mild theme-colors))
(set-face-attribute 'escape-glyph nil :foreground (alist-get 'aqua theme-colors))
(set-face-attribute 'highlight nil :background (alist-get 'highlight theme-colors))
(set-face-attribute 'homoglyph nil :foreground (alist-get 'focus theme-colors))
(set-face-attribute 'match nil :background (alist-get 'lowlight theme-colors) :background (alist-get 'focus theme-colors))

; Font-Lock
(set-face-attribute 'font-lock-builtin-face nil :foreground (alist-get 'blue theme-colors) :weight 'light)
(set-face-attribute 'font-lock-constant-face nil :foreground (alist-get 'aqua theme-colors) :weight 'light)
(set-face-attribute 'font-lock-comment-face nil :foreground (alist-get 'meek theme-colors) :slant 'italic :weight 'normal)
(set-face-attribute 'font-lock-function-name-face nil :foreground (alist-get 'crucial theme-colors) :weight 'bold)
(set-face-attribute 'font-lock-keyword-face nil :foreground (alist-get 'focus theme-colors) :weight 'light :slant 'normal)
(set-face-attribute 'font-lock-string-face nil :foreground (alist-get 'orange theme-colors) :weight 'light)
(set-face-attribute 'font-lock-variable-name-face nil :foreground (alist-get 'strong theme-colors) :weight 'light)
(set-face-attribute 'font-lock-type-face nil :foreground (alist-get 'purple theme-colors) :weight 'light)
(set-face-attribute 'font-lock-warning-face nil :foreground (alist-get 'urgent theme-colors) :weight 'bold)
(set-face-attribute 'font-lock-preprocessor-face nil :foreground (alist-get 'aqua theme-colors) :weight 'medium)

; Org mode
(set-face-attribute 'org-level-2 nil :foreground (alist-get 'orange theme-colors))
(set-face-attribute 'org-block nil  :foreground (alist-get 'meek theme-colors) :background (alist-get 'lowlight theme-colors))
(set-face-attribute 'org-block-begin-line nil :foreground (alist-get 'meek theme-colors) :background (alist-get 'lowlight theme-colors))
(set-face-attribute 'org-block-end-line nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-checkbox nil  :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-checkbox-statistics-done nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-checkbox-statistics-todo nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-cite nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-cite-key nil :foreground (alist-get 'crucial theme-colors))
(set-face-attribute 'org-clock-overlay nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-code nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-column nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-column-title nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-date nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-date-selected nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-default nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-document-info nil :foreground (alist-get 'meek theme-colors) :weight 'light)
(set-face-attribute 'org-document-info-keyword nil :foreground (alist-get 'meek theme-colors) :weight 'light)
(set-face-attribute 'org-done nil :foreground (alist-get 'meek theme-colors) :strike-through t)
(set-face-attribute 'org-ellipsis nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-footnote nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-formula nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-headline-done nil :foreground (alist-get 'green theme-colors))
(set-face-attribute 'org-imminent-deadline nil :foreground (alist-get 'urgent theme-colors))
(set-face-attribute 'org-latex-and-related nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-link nil :foreground (alist-get 'focus theme-colors))
(set-face-attribute 'org-list-dt nil :foreground (alist-get 'strong theme-colors) :weight 'semi-bold)
(set-face-attribute 'org-macro nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-priority nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-property-value nil :foreground (alist-get 'meek theme-colors) :weight 'light)
(set-face-attribute 'org-quote nil :foreground (alist-get 'fg theme-colors) :background (alist-get 'faint theme-colors))
(set-face-attribute 'org-scheduled nil :foreground (alist-get 'strong theme-colors))
(set-face-attribute 'org-scheduled-previously nil :foreground (alist-get 'strong theme-colors) :weight 'light)
(set-face-attribute 'org-scheduled-today nil :foreground (alist-get 'focus theme-colors))
(set-face-attribute 'org-sexp-date nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-tag nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-tag-group nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-target nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-time-grid nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-todo nil :foreground (alist-get 'orange theme-colors))
(set-face-attribute 'org-upcoming-deadline nil :foreground (alist-get 'strong theme-colors))
(set-face-attribute 'org-upcoming-distant-deadline nil :foreground (alist-get 'fg theme-colors))
(set-face-attribute 'org-verbatim nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-verse nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-warning nil :foreground (alist-get 'crucial theme-colors))

; Turning off splash screen
(setq inhibit-splash-screen t)

;; --- Org mode system -------------------------------------------------------
; Work directory
(defvar my/work-dir (expand-file-name "~/Documents/work"))
(defvar my/notes-directory (expand-file-name "~/Documents/work/notes"))

; Files used in agenda
(setq org-agenda-files (list (expand-file-name "agenda.org" my/work-dir)))

; General agenda Settings
(setq org-agenda-start-day "+0d"
      org-agenda-skip-scheduled-repeats-after-deadline t)

; Settings for agenda views
(setq org-deadline-warning-days 1)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-prefix-format
     '((agenda . " %i %?-12t% s")
       (timeline . "  % s")
       (todo . " %i ")
       (tags . " %i ")
       (search . " %i ")))

; Refile settings
(setq org-refile-use-outline-path 'file)

(setq org-refile-targets
      '((org-agenda-files . (:level . 1))
	(("/home/marc/Documents/work/archived/reference.org"
	  "/home/marc/Documents/work/archived/someday.org")
	 . (:level . 0))))

; Capture templates
(defvar my/note-categories '("readings")
  "Categories for note creation.")

(defvar my/note-templates
  '(("readings" . "#+AUTHOR:"))
  "Templates for categories.")

(defun my/sanitize-filename (name)
  "Replace spaces and special chars with -."
  (let ((sanitized (downcase (replace-regexp-in-string "[^a-zA-Z0-9_-]" "-" name))))
    (replace-regexp-in-string "-+" "-" sanitized)))

(defun my/generate-org-note-name ()
  (setq my-org-note--tag-choice (completing-read
		  "Choose a tag: "
		  my/note-categories
		  nil t))
  (setq my-org-note--title  (read-string "Title: "))
  (setq my-org-note--date (format-time-string "%Y%m%dT%H%M%S"))
  (setq my-org-note--template (or (cdr (assoc my-org-note--tag-choice my/note-templates)) ""))
  (expand-file-name (format "%s--%s__%s.org" my-org-note--date (my/sanitize-filename my-org-note--title) my-org-note--tag-choice) my/notes-directory))
   
(setq org-capture-templates
      `(("i" "Inbox" entry
	 (file+headline ,(expand-file-name "agenda.org" my/work-dir) "Inbox")
	 "* %^{Header|Entry}\n:PROPERTIES:\n:CREATED: %u\n:END:\n%^{Description}%i" :immediate-finish t)
        ("n" "Note" plain
         (file my/generate-org-note-name)
         "%(format \"#+TITLE: %s\n#+DATE: [[%U]]\n#+IDENTIFIER: %s\n%s\n\" my-org-note--title (format-time-string \"%Y%m%dT%H%M%S\") my-org-note--template)")
	("reference" "Reference (Org Protocol)" entry
	 (file ,(expand-file-name "archived/reference.org" my/work-dir))
	 "* LINK: %:description\n:PROPERTIES:\n:CREATED: %u\n:END:\n%:annotation\n%i" :immediate-finish t)
	("m" "Misc" entry
	 (file ,(expand-file-name "archived/misc.org" my/work-dir))
	 "* %^{Header|Entry} %^g")
	("j" "Journal" entry
	 (file ,(expand-file-name "journal.org" my/work-dir)
	       "* [%U]\n"))))

; Attachments
(setq org-attach-archive-delete t)

; ICalendar export
(setq org-icalendar-use-scheduled nil
      org-icalendar-use-deadline nil
      org-icalendar-include-body nil
      org-icalendar-force-alarm t)

; Notifications and Ntfy
(advice-add
 'notifications-notify :after
 (lambda (&rest _)
   (start-process "" nil
                  "curl" "-s" "-H" "Title: Org Clock"
                  "-d" "Effort Exceeded"
                  "https://ntfy.sh/agenda_OHuVjdCt")))

; Misc. settings
(add-hook 'org-todo-repeat-hook #'org-reset-checkbox-state-subtree) ; To unmark checkboxes
(setq org-log-into-drawer t) ; For timestamp logs
(setq org-log-done nil)
(setq org-log-repeat 'time)

; Keybindings
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c l") #'org-store-link)

;; --- Coding -------------------------------------------------------
; LaTeX
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
(setq org-preview-latex-process 'dvisvgm)
(setq org-latex-default-packages-alist
      '(("" "amsmath" t)
	("" "amssymb" t)
	("" "mathtools" t)
	("" "graphics" t)))
(defun my-org-toggle-latex-editing ()
  "Toggle org-cdlatex-mode and org-latex-preview-mode."
  (interactive)
  (org-latex-preview-mode 'toggle))
(define-key org-mode-map (kbd "C-c t") #'my-org-toggle-latex-editing)

; Direnv - for flake development
(use-package direnv
  :ensure t
  :config (direnv-mode))

;; --- Programming modes -------------------------------------------------------
; Ledger
(use-package ledger-mode
  :ensure t)

; Nix
(use-package nix-mode
  :ensure t)

; Gnuplot
(use-package gnuplot
  :ensure t)

; Org babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (latex . t)
   (gnuplot . t)))

;; --- Navigation -------------------------------------------------------
; Which key
(which-key-mode 1)

; Completion
(use-package icomplete
  :ensure nil
  :hook (after-init . icomplete-vertical-mode)
  :bind (:map icomplete-minibuffer-map
         ("TAB" . icomplete-force-complete)
         ("C-n" . icomplete-forward-completions)
         ("C-p" . icomplete-backward-completions))
  :config
  (setq tab-always-indent 'complete)  ;; Starts completion with TAB
  (setq icomplete-delay-completions-threshold 0)
  (setq completion-styles '(basic substring partial-completion flex))
  (setq completion-category-overrides '((file (styles basic partial-completion flex))))
  (setq icomplete-compute-delay 0)
  (setq icomplete-show-matches-on-no-input t)
  (setq icomplete-hide-common-prefix nil)
  (setq icomplete-prospects-height 10)
  (setq icomplete-separator " . ")
  (setq icomplete-with-completion-tables t)
  (setq icomplete-in-buffer t)
  (setq icomplete-max-delay-chars 0)
  (setq icomplete-scroll t)
  (advice-add 'completion-at-point
	      :after #'minibuffer-hide-completions))
