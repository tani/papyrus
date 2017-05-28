## Appendix

### FAQ

- Why doesn't *Lambda* have something like `<<foo>>=` ?
  Because CommonLisp has already had the great flexible macro system.
  You have to use it.

### Emacs Lisp

If you use emacs, there are `mmm-mode` which highlights the syntax of lisp
codeblock of Markdown, but SLIME doesn't works well in `mmm-mode`.

    (require 'mmm-mode)
    (setq mmm-global-mode 'maybe)
    (set-face-background 'mmm-default-submode-face nil)
    (mmm-add-mode-ext-class nil "\\.l.md?\\'" 'lambda-markdown)
    (mmm-add-classes
     '((lambda-markdown
        :submode lisp-mode
        :front "```lisp"
        :back "```")))
    (add-to-list 'auto-mode-alist '("\\.l.md?\\'" . markdown-mode))
