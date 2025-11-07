Emacs `treesit` integration
===========================

Requires Emacs to have tree-sitter support built in, which has been the default 
since version 29.

Instructions
------------

Copy the `misc/emacs/god-ts-mode.el` into your `load-path`, e.g.: `/usr/share/emacs/site-lisp/god-ts-mode.el`

In your emacs configuration:
```lisp
(add-to-list 'treesit-language-source-alist '(god "https://github.com/wreedb/tree-sitter-god"))
;  associate god-ts-mode with *.god files
(add-to-list 'auto-mode-alist '("\\.god\\'" . god-ts-mode))
; optional: configure the indentation width, default is 4
(setopt god-ts-mode-indent-offset 2)
```
You will also want to run:
```
M-x treesit-install-language-grammar
```
and select `god` from the menu after adding it to the sources alist.
