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
    3. Command Line
3. Source Code
    1. Utilities
    2. Library
    3. Command Line
4. Appendix
    1. FAQ
    2. License texts

## About This Project

### Philosophy

*Lambda* is a name of programming style and a tool to do it.
The author of *Lambda* developed it to do literate programming in LISP better than WEB developed by Donald Knuth.
WEB and it's derived softwares were used in various programming languages.
They require developers compiling to get a source code.
It is necessary to do literate programming in C and Pascal, but isn't necessary to do it in Common Lisp because Common Lisp has the reader macro which changes source code when the system reads it.

<div style="display:float;">
  <img src="img/web.png" width="250px"/>
  <img src="img/lambda.png" width="250px"/>
</div>

*Lambda* makes your markdown executable with the reader macro of Common Lisp.
For example, The author wrote this document in *Lambda*.
You can execute `sbcl --script lambda.l.md`. How about this one? Let's make your project more beautiful.
### Copyright

Copyright (c) 2017 TANIGUCHI Masaya All Rights Reserved

### License

GPLv3. See the appendix.

### Precaution

This is a newborn project.
Please send me your feedback when you find a issue.

- [Project home](https://github.com/ta2gch/lambda)

## Tutorial and Guideline

In *Lambda*, you can write any texts but have to write a title (`#`) at the top of the file like a following and make the extension of file name being `.l.md` and write with Markdown especially CommonMark You can see the specification of CommonMark in [commonmark.org](https://commonmark.org). And Lambda evaluate codeblocks between ` ```lisp ` and ` ``` ` and does'nt evaluate other codeblocks which has four spaces or ` ```sh ` and ` ``` `.

    # My First Document

    This is my first document.
    This will say "Hello, world!".

    ```lisp
    (defun hello ()
      (princ "Hello, world!"))
    ```

if you try this tutorial, save as `hello.l.md` the document which is used in this section.
Now, to treat your documents you have three ways, **REPL**, **ASDF** and **Command Line**. And these are quick tutorials for them. For more information, please see the **Source Code** section.

### REPL

#### Installation

Sorry, *Lambda* is NOT available in QuickLisp but I'll do it in the feature. Then,

    > (ql:quickload :lambda)

Currently, You can install *Lambda* with [Roswell](https://github.com/roswell/roswell).

    $ ros install ta2gch/lambda

It will install a comman line tool when It does.
Please see also **Command Line** section.

#### Load a Document

*Lambda* provides few functions. For example, to make your REPL loding the file written in *Lambda*;

    > (lambda:lambdaload #p"hello.l.md")
    nil
    > (hello)
    Hello, World!

`lambda:lambdaload` is the same interface of `cl:load`.
To load many files written in *Lambda* at once see **ASDF** section.

#### Convert a Document
