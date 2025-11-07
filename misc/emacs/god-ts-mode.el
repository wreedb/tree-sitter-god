;; -*- lexical-binding: t; -*-

;; SPDX-FileCopyrightText: 2025 Will Reed <wreed@disroot.org>
;;
;; SPDX-License-Identifier: LGPL-3.0-or-later

(require 'treesit)

(defvar god-ts-font-lock-rules
  '(:language god
	:override t
	:feature delimiter
	(["{" "}" "[" "]"] @font-lock-bracket-face)

	:language god
	:override t
	:feature field
	((identifier) @font-lock-variable-name-face)

	:language god
	:override t
	:feature field
	((assignment) @font-lock-operator-face)

	:language god
	:override t
	:feature field
	((termination) @font-lock-misc-punctuation-face)

	:language god
	:override t
	:feature field
	((element (string) @font-lock-string-face))

	:language god
	:override t
	:feature field
	((element (number) @font-lock-number-face))

	:language god
	:override t
	:feature field
	((element (bool) @font-lock-keyword-face))

	:language god
	:override t
	:feature field
	((element (null) @font-lock-keyword-face))

	:language god
	:override t
	:feature comment
	((comment) @font-lock-comment-face)))

(defun god-ts-setup ()
  (interactive)
  (setq-local treesit-font-lock-settings
			  (apply #'treesit-font-lock-rules
					 god-ts-font-lock-rules))
  (setq-local font-lock-defaults nil)
  (setq-local treesit-font-lock-feature-list
			  '((field)
				(comment)
				(delimiter)
				(element)))
  
  (setq-local treesit-font-lock-level 5)

  (defcustom god-ts-mode-indent-offset 4
	"number of spaces for each indentation step in `god-ts-mode'."
	:type 'integerp
	:safe 'integerp)
  
  
  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 4)
  
  (setq-local treesit-simple-indent-rules
   `((god
	   ((node-is "}") parent-bol 0)
	   ((node-is "]") parent-bol 0)
	   ((node-is ";") parent-bol 0)
	   ((parent-is "document") parent-bol god-ts-mode-indent-offset)
	   ((parent-is "list") parent-bol god-ts-mode-indent-offset)
	   ((parent-is "map") parent-bol god-ts-mode-indent-offset))))
  
  (treesit-major-mode-setup))


(define-derived-mode god-ts-mode prog-mode "god[ts]"
  "major mode for editing God files with tree-sitter"

  (when (treesit-ready-p 'god)
	(treesit-parser-create 'god)
	(god-ts-setup)))

(provide 'god-ts-mode)
