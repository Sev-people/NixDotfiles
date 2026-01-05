;; --- Sane defaults -------------------------------------------------------
(menu-bar-mode -1) (tool-bar-mode -1) (scroll-bar-mode -1) (blink-cursor-mode -1) (electric-indent-mode -1) (electric-pair-mode 1)
(setq org-startup-indented t org-edit-src-content-indentation 0) ; Indentation
(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files"))) ; Trash collection
(setq ring-bell-function 'ignore) ; Stop bell sounds
(global-visual-line-mode 1) ; Truncate lines
(setq custom-file null-device) ; Prevent custom-set-variables from editing this file
(transient-mark-mode -1) ; Removes mark higlighting
(repeat-mode) ; Useful mode for repeated commands

;; --- Keybindings -------------------------------------------------------
; Zooming in and out
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; --- Org mode -------------------------------------------------------
(use-package org :load-path "~/.dotfiles/emacs/elpa/org-mode/lisp/")
(require 'org)
(require 'org-indent)

; Allows multi-line emphasis markers
(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)

; Makes emphasis markers work around em dashes
(setq org-emphasis-regexp-components
      '("-—[:space:]('\"{"
	"-—[:space:].,:!?;'\")}\\["
	"[:space:]"
	"."
	1))

(setq org-startup-folded t
      org-return-follows-link t)
; (add-hook 'org-mode-hook #'variable-pitch-mode)

; Table of contents
(use-package toc-org
    :ensure t
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

;; --- Theme -------------------------------------------------------
(modify-all-frames-parameters '((internal-border-width . 16))) ; Window margins/padding

(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 140 :weight 'light) ; Font
(set-face-attribute 'fixed-pitch nil :family "JetBrainsMono Nerd Font" :height 1.0 :weight 'light) ; Font
(set-face-attribute 'variable-pitch nil :family "Latin Modern Mono" :height 1.0 :weight 'normal) ; Variable pitch font

; Defining colors
(defconst theme-colors
  '((fg          . "#EBE9E7")
    (bg          . "#141414")
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
(set-face-attribute 'org-block nil :inherit 'fixed-pitch :foreground (alist-get 'meek theme-colors) :background (alist-get 'lowlight theme-colors))
(set-face-attribute 'org-block-begin-line nil :foreground (alist-get 'meek theme-colors) :background (alist-get 'lowlight theme-colors))
(set-face-attribute 'org-block-end-line nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-checkbox-statistics-done nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-checkbox-statistics-todo nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-cite nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-cite-key nil :foreground (alist-get 'crucial theme-colors))
(set-face-attribute 'org-clock-overlay nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch) :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-column nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-column-title nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-date nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-date-selected nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-default nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-document-info nil :foreground (alist-get 'meek theme-colors) :weight 'light)
(set-face-attribute 'org-document-info-keyword nil :foreground (alist-get 'meek theme-colors) :weight 'light)
(set-face-attribute 'org-document-title nil :font "Latin Modern Mono" :foreground (alist-get 'fg theme-colors) :weight 'normal)
(set-face-attribute 'org-done nil :foreground (alist-get 'meek theme-colors) :strike-through t)
(set-face-attribute 'org-drawer nil :foreground (alist-get 'meek theme-colors) :weight 'light)
(set-face-attribute 'org-ellipsis nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-footnote nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-formula nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-headline-done nil :foreground (alist-get 'green theme-colors))
(set-face-attribute 'org-imminent-deadline nil :foreground (alist-get 'urgent theme-colors))
(set-face-attribute 'org-latex-and-related nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-link nil :foreground (alist-get 'focus theme-colors))
(set-face-attribute 'org-list-dt nil :foreground (alist-get 'strong theme-colors) :weight 'semi-bold)
(set-face-attribute 'org-macro nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch) :foreground (alist-get 'meek theme-colors) :weight 'light)
(set-face-attribute 'org-mode-line-clock nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-mode-line-clock-overrun nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-priority nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-property-value nil :foreground (alist-get 'meek theme-colors) :weight 'light)
(set-face-attribute 'org-quote nil :foreground (alist-get 'fg theme-colors) :background (alist-get 'faint theme-colors))
(set-face-attribute 'org-scheduled nil :foreground (alist-get 'strong theme-colors))
(set-face-attribute 'org-scheduled-previously nil :foreground (alist-get 'strong theme-colors) :weight 'light)
(set-face-attribute 'org-scheduled-today nil :foreground (alist-get 'focus theme-colors))
(set-face-attribute 'org-sexp-date nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch) :foreground (alist-get 'meek theme-colors) :weight 'light)
(set-face-attribute 'org-table nil :inherit 'fixed-pitch)
(set-face-attribute 'org-tag nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-tag-group nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-target nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-time-grid nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-todo nil :foreground (alist-get 'orange theme-colors))
(set-face-attribute 'org-upcoming-deadline nil :foreground (alist-get 'strong theme-colors))
(set-face-attribute 'org-upcoming-distant-deadline nil :foreground (alist-get 'fg theme-colors))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch) :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-verse nil :foreground (alist-get 'meek theme-colors))
(set-face-attribute 'org-warning nil :foreground (alist-get 'crucial theme-colors))
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(dolist (face '(org-level-1 org-level-2 org-level-3 org-level-4 org-level-5 org-level-6 org-level-7 org-level-8))
  (set-face-attribute face nil :font "Latin Modern Mono" :weight 'normal :height 1.0))

;; --- GTD system -------------------------------------------------------
; Keywords
(defconst my/gtd-dest-map
  '(("projects.org"  . "PROJ")
    ("waiting.org"   . "WAIT")
    ("next.org"      . "NEXT")
    ("calendar.org"  . "TODO")
    ("reference/reference.org" . nil)
    ("someday.org"   . "IDEA"))
  "GTD file structure & keyword correspondance.")

; GTD tags And TODO Keywords
(setq org-tag-persistent-alist '((:startgroup . nil)
		      ("@work" . ?w) ("@knowledge" . ?k)
		      ("@misc" . ?m) ("@academic" . ?a)
		      (:endgroup . nil)
		      ))
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "FILE(f)" "PROJ(p)" "IDEA(i)" "WAIT(w)" "|" "DONE(d)")))

; GTD root and default notes file
(setq my/gtd-root (expand-file-name "~/Documents/work/organization/"))
(setq org-default-notes-file (expand-file-name "inbox.org" my/gtd-root))

; Files used in agenda
(setq org-agenda-files `(
	,(expand-file-name "calendar.org" my/gtd-root)
	,(expand-file-name "agenda.org" my/gtd-root)))

; General agenda Settings
(setq org-agenda-span 1
org-agenda-start-day "+0d"
org-agenda-skip-timestamp-if-done t
org-agenda-skip-deadline-if-done t
org-agenda-skip-scheduled-if-done t
org-agenda-skip-scheduled-if-deadline-is-shown t
org-agenda-skip-timestamp-if-deadline-is-shown t)

; Agenda views format
(setq org-agenda-prefix-format '(
(agenda . "  %?-2i %t ")
 (todo . " %i %-12:c")
 (tags . " %i %-12:c")
 (search . " %i %-12:c")))

(setq org-agenda-hide-tags-regexp ".*")

; Settings for agenda views
(setq org-deadline-warning-days 0)
(setq org-agenda-current-time-string "")
(setq org-agenda-time-grid '((daily) () "" ""))
(setq org-agenda-start-on-weekday nil)

; Custom agenda view
(setq org-agenda-custom-commands
      '(("x" "Custom Agenda"
	 ; Routine today
	 ((agenda ""
		  ((org-agenda-span 1)
		   (org-agenda-entry-types '(:timestamp))
		   (org-agenda-skip-function
		    '(org-agenda-skip-entry-if 'todo 'any))
		   (org-agenda-overriding-header "Routine")))

	  ; TODOs scheduled today
	  (agenda ""
		  ((org-agenda-span 1)
		   (org-agenda-show-current-time-in-grid nil)
		   (org-agenda-skip-function
		    '(org-agenda-skip-entry-if 'nottodo 'any))
		   (org-agenda-overriding-header "Work Today")))

	  ; Deadlines in the next 7 days
	  (agenda ""
		  ((org-agenda-span 7)
		   (org-agenda-files '("~/Documents/work/organization/calendar.org"))
		   (org-agenda-prefix-format '((agenda . "  %?-2i %t %s")))
		   (org-agenda-show-current-time-in-grid nil)
		   (org-agenda-entry-types '(:deadline :scheduled))
		   (org-agenda-overriding-header "Calendar")))))))

; Capture templates
(setq org-capture-templates
      `(("i" "Inbox" entry
	 (file+headline ,(expand-file-name "inbox.org" my/gtd-root) "Inbox")
	 "* FILE %^{Header|Entry} \n:PROPERTIES:\n:Captured: %u\n:End:\n%^{Description}%i" :immediate-finish t)))

; Set deadline for GTD entries
(defun gtd-set-deadline ()
  "Set a deadline for a GTD project/task."
  (interactive)
  (org-up-heading-all 0)
  (let ((date (read-string "Deadline (empty to skip): ")))
    (unless (string-empty-p date)
      (org-deadline nil date)
      (let* ((calendarfile (expand-file-name "calendar.org" my/gtd-root))
	     (calendarheader "Calendar")
	     (pos (with-current-buffer (find-file-noselect calendarfile t)
		    (widen)
		    (or (org-find-exact-headline-in-buffer calendarheader)
			(user-error "No headline in %s" calendarfile)))))
	(org-refile 3 nil (list calendarheader calendarfile nil pos))
	(with-current-buffer (find-buffer-visiting calendarfile)
	  (save-buffer))))))

; Refile GTD entries
(defun gtd-refile-with-keyword ()
  "Refile current heading to a GTD target file and update its TODO keyword."
  (interactive)
  (org-up-heading-all 0)
  (let* ((choice (completing-read "Move to: " (mapcar #'car my/gtd-dest-map))) ; Prompt to choose GTD file
	 (keyword (cdr (assoc choice my/gtd-dest-map))) ; TODO keyword associated to chosen GTD file
	 (header (capitalize (string-remove-suffix ".org" choice))) ; Maps filename.org to Filename
	 (file (expand-file-name choice my/gtd-root)) ; Chosen GTD file path
	 (nextaction ""))
    ; Change TODO keyword
    (when keyword
      (org-todo keyword))
    (setq current-prefix-arg nil)
    ; Project template
    (when (member choice '("projects.org"))
      (org-priority nil)
      (org-set-tags-command)
      (gtd-set-deadline))
    ; Prompt for the next action
    (when (member choice '("next.org"))
      (while (string-blank-p nextaction) (setq nextaction (read-string "Next Action (cannot be empty): ")))
      (org-set-property "NextAction" nextaction)
      (org-priority nil)
      (org-set-tags-command))
    ; Prompt for date
    (when (member choice '("calendar.org")) (org-schedule nil))
    ; Refile header
    (let* ((pos (with-current-buffer (find-file-noselect file t)
		  (widen)
		  (or (org-find-exact-headline-in-buffer header)
		      (user-error "No headline in %s" file)))))
      (org-refile nil nil (list header file nil pos)))
    ; Save current buffer
    (save-buffer)
    ; Save buffer header is being moved to
    (setq target-buf (find-buffer-visiting file))
    (with-current-buffer target-buf
      (save-buffer))))

; Project management
(require 'org-mouse)

(setq org-after-note-stored-hook
      (list
       (lambda ()
	 (org-up-heading-all 0)
	 (org-store-link t)
	 ; Set NextAction
	 (let ((nextaction "") (priority (string-to-char (org-mouse-get-priority))) (tags (org-get-tags)) (link (substring-no-properties (org-store-link t))))
	   (while (string-blank-p nextaction) (setq nextaction (read-string "Next Action: ")))
	   (org-set-property "NextAction" nextaction)
	   ; Add next.org entry
	   (let ((org-capture-templates
		  `(("x" "Project action" entry
		     (file+headline ,(expand-file-name "next.org" my/gtd-root) "Next")
		     "* NEXT %(identity nextaction) for: %(identity link)\n:PROPERTIES:\n:Captured: %u\n:End:\n%i" :immediate-finish t :before-finalize (lambda () (org-priority priority) (org-set-tags tags))))))
	     (org-capture nil "x"))))
       (save-buffer)))

(defun gtd-manage-project ()
  "Manage current GTD project."
  (interactive)
  (org-up-heading-all 0)
  ; Add purpose and vision
  (unless (org-entry-get (point) "Purpose")
    (let ((purpose ""))
      (while (string-blank-p purpose) (setq purpose (read-string "Purpose: ")))
      (org-set-property "Purpose" purpose)))
  (unless (org-entry-get (point) "SuccessCriteria")
    (let ((criteria ""))
      (while (string-blank-p criteria) (setq criteria (read-string "Success Criteria: ")))
      (org-set-property "SuccessCriteria" criteria)))
  ; Brainstorm
  (org-add-note))

; Misc. settings
(add-hook 'org-todo-repeat-hook #'org-reset-checkbox-state-subtree) ;; To unmark checkboxes
(setq org-log-into-drawer t) ;; For timestamp logs
; Remove timestamp logging when tasks are completed
(setq org-log-done nil)
(setq org-log-repeat nil)

; GTD keybindings
(defun gtd-agenda ()
  "Open custom agenda view."
  (interactive)
  (org-agenda nil "x"))

(defun gtd-dir ()
  "Open GTD directory."
  (interactive)
  (find-file "~/Documents/work/organization"))

(defvar-keymap gtd-prefix-map
  :doc "GTD prefix key map."
  "c" #'org-capture
  "a" #'gtd-agenda
  "d" #'gtd-dir
  "p" #'gtd-manage-project
  "m" 'gtd-refile-with-keyword)

(keymap-set global-map "C-c d" gtd-prefix-map)

;; --- Note taking -------------------------------------------------------
(defvar notes-directory "~/Documents/work/notes/"
  "Directory where all notes are stored.")

(defvar note-categories '("readings" "lectures")
  "Categories for note creation.")

(defvar note-templates
  '(("readings" . "#+author:\n#+startup: latexpreview"))
  "Templates for categories.")

(defun sanitize-filename (name)
  "Replace spaces and special chars with -."
  (let ((sanitized (downcase (replace-regexp-in-string "[^a-zA-Z0-9_-]" "-" name))))
    (replace-regexp-in-string "-+" "-" sanitized)))

(defun create-note ()
  "Create a new note in CATEGORY."
  (interactive)
  (let* ((tag-choice (completing-read
		  "Choose a tag: "
		  note-categories
		  nil t)))
  (let* ((title (read-string "Title: "))
	 (date (format-time-string "%Y%m%dT%H%M%S"))
	 (safe-title (sanitize-filename title))
	 (filename (expand-file-name
		    (format "%s--%s__%s.org" date safe-title tag-choice)
		    notes-directory))
	 (template (or (cdr (assoc tag-choice note-templates)) "")))
    (find-file filename)
    ; Insert template or minimal header
    (insert (format "#+title: %s\n#+tag: %s\n#+date: [%s]\n%s\n" title tag-choice (format-time-string "%Y-%m-%d") template))
    (save-buffer)
    (org-mode))))

(global-set-key (kbd "C-c n") #'create-note)
;; --- Coding -------------------------------------------------------
; LaTeX
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
(setq org-preview-latex-default-process 'dvisvgm)
(setq org-latex-default-packages-alist
      '(("" "amsmath" t)
	("" "amssymb" t)
	("" "mathtools" t)
	("" "graphics" t)))

;; --- Navigation -------------------------------------------------------
; Which key
(which-key-mode 1)

; Completion
(use-package icomplete
  :ensure nil
  :hook (after-init . fido-vertical-mode)
  :bind (:map icomplete-minibuffer-map
         ("TAB" . icomplete-force-complete)
         ("C-n" . icomplete-forward-completions)
         ("C-p" . icomplete-backward-completions))
:config
(setq tab-always-indent 'complete)  ;; Starts completion with TAB
(setq icomplete-delay-completions-threshold 0)
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

; Avy
(use-package avy
  :ensure t
  :bind ("C-;" . avy-goto-char-timer))
