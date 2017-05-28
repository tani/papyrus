
    (in-package :cl-user)
    (defpackage :lambda.README
      (:use :cl :lambda :named-readtables))
    (in-package :lambda.README)
    (in-readtable :lambda)

# Lambda
This project is a work in progress.

## Table of Contents

1. About This Project
    1. Philosophy
    2. Copyright
    3. License
    4. Precaution
2. [Tutorial](./tutorial.md)
    1. REPL
    2. ASDF
    3. Command Line
3. [Source Code](./lambda.l.md)
4. [Appendix](./appendix.md)
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
For example, the author wrote this document in *Lambda*. You can execute `sbcl
--script lambda.l.md`. How about this one? Let's make your project more
beautiful.
### Copyright

Copyright (c) 2017 TANIGUCHI Masaya All Rights Reserved

### License

GPLv3. See the appendix.

### Precaution

This is a newborn project. Please send me your feedback when you find a issue.

- [Project home](https://github.com/ta2gch/lambda)

