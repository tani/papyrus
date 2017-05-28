
    (in-package #:cl-user)
    (defpackage #:lambda.README
      (:use :cl :lambda :named-readtables))
    (in-package #:lambda.README)
    (in-readtable :lambda)

# Lambda
This project is a work in progress.

## Table of Contents

1. About This Project
    1. Philosophy
    2. Copyright
    3. License
    4. Precaution
2. Tutorial
    1. REPL
    2. ASDF
3. Reference
    1. Lamdba
4. Appendix(./appendix.md)
    1. FAQ
    3. Emacs Lisp

## About This Project

### Philosophy

*Lambda* is a name of programming style and a tool to do it. The author of
*Lambda* developed it to do literate programming in LISP better than WEB
developed by Donald Knuth. WEB and it's derived softwares were used in various
programming languages. They require developers compiling to get a source code.
It is necessary to do literate programming in C and Pascal, but isn't necessary
to do it in Common Lisp because Common Lisp has the reader macro which changes
source code when the system reads it.

<div style="display:flex;height:200px;justify-content:center;">
  <img src="img/web.png" width="250px"/>
  <img src="img/lambda.png" width="250px"/>
</div>

*Lambda* makes your markdown executable with the reader macro of Common Lisp.
For example, the author wrote this document with *Lambda*. You can execute 
`ros run -l lambda.asd -e '(require :lambda)' -l README.md -q`.
How about this one? Let's make your project more beautiful and useful!

```lisp
(princ "Hello, Lambda!")
```

### Copyright

Copyright (c) 2017 TANIGUCHI Masaya All Rights Reserved

### License

GPLv3. See the [license texts](./LICENSE).

### Precaution

This is a newborn project. Please send me your feedback when you find a issue.

- [Project home](https://github.com/ta2gch/lambda)

## Tutorials

In *Lambda*, you can write any texts but have to write a title (`#`) at the top
of the document like a following and make the extension of the file being
`.l.md` or `.md`. To distinguish from non-executable Markdown, I recommend using
`.l.md`. And you can write with Markdown especially CommonMark whose
specification is in [commonmark.org](https://commonmark.org). And *Lambda*
evaluate codeblocks between ` ```lisp ` and ` ``` ` and does'nt evaluate other
codeblocks *after* the title (`# `). The indented codeblock *before* the title
(`# `) is important, this is a codeblock and is a definition of package.
Please don't forget.

        (in-package :cl-user)
        (defpackage :tutorial
          (:use :cl :lambda :named-readtables)
          (:export :hello)
        (in-package :tutorial)
        (in-readtable :lambda)

    # My First Document

    This is my first document.
    This will say "Hello, world!".

    ```lisp
    (defun hello ()
      (princ "Hello, world!"))
    ```

if you try this tutorial, save as `tutorial.l.md` the document which is used in
this section. Now, to treat your documents you have two ways, **REPL** and
**ASDF**. And these are quick tutorials for them. For more information, please
see the **Reference** section.

### REPL

a REPL is a good environment to try your documents of *Lamda*. We can load them
and test the behaivor quickly and it is conveniense to use them with *SLIME*.

#### Installation

Sorry, *Lambda* is NOT available in QuickLisp. Currently, You can install
*Lambda* with [Roswell](https://github.com/roswell/roswell).

    $ ros install ta2gch/lambda

Next you can load document like a following.

    > (require :lambda)
    nil
    > (load #p"tutorial.l.md")
    nil
    > (tutorial:hello)
    Hello, World!

### ASDF

Let's write a small project whose files is a following.

    tutorial.asd
    tutorial.l.md

`src/tutorial.l.md` is that you wrote in **REPL** section, and `tutorial.asd`
is this.

    (in-package :cl-user)
    (defpackage tutorial-asd
      (:use :cl :asdf))
    (in-package :tutorial-asd)
    
    (defclass lmd (cl-source-file)
      ((type :initform "md")))
    
    (defsystem tutorial
      :version "0.1"
      :author "Your name"
      :license "MIT"
      :depends-on (:lambda :named-readtables)
      :components ((:lmd "tutorial.l"))
      :description "A Literate Programming Framework")

Now, you have two files, `src/tutorial.l.md` and `tutorial.asd`, and be able to
load this system as always like this.

    > (load #p"tutorial.asd")
    nil
    > (require :tutorial)
    nil
    > (tutorial:hello)
    Hello, World!

Off course, users who use your project need nothing to load.

## Reference

## `lambda`

This is a readtable defined by `named-readtables`. You can use this with
`named-readtable:in-readtable` like this document.

        (in-package #:cl-user)
        (defpackage #:sample
          (:use :cl :named-readtables :lambda.readtable)
          (:export #:sample-function))

    # Sample

    This is a sample code. Following function just say "Hello, world!";

    ```lisp
    (defun sample-function () (princ "Hello, world!"))
    ```

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
