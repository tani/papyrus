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

*Lambda* is a name of programming style and a tool to do it. The author of *Lambda* developed it to do literate programming in LISP better than WEB developed by Donald Knuth. WEB and it's derived softwares were used in various programming languages. They require developers compiling to get a source code. It is necessary to do literate programming in C and Pascal, but isn't necessary to do it in Common Lisp because Common Lisp has the reader macro which changes source code when the system reads it.

<div style="display:flex;height:200px;justify-content:center;">
  <img src="img/web.png" width="250px"/>
  <img src="img/lambda.png" width="250px"/>
</div>

*Lambda* makes your markdown executable with the reader macro of Common Lisp. For example, the author wrote this document in *Lambda*. You can execute `sbcl --script lambda.l.md`. How about this one? Let's make your project more beautiful.
### Copyright

Copyright (c) 2017 TANIGUCHI Masaya All Rights Reserved

### License

GPLv3. See the appendix.

### Precaution

This is a newborn project. Please send me your feedback when you find a issue.

- [Project home](https://github.com/ta2gch/lambda)

## Tutorials

In *Lambda*, you can write any texts but have to write a title (`#`) at the top of the file like a following and make the extension of file name being `.l.md` and write with Markdown especially CommonMark whose specification is in [commonmark.org](https://commonmark.org). And *Lambda* evaluate codeblocks between ` ```lisp ` and ` ``` ` and does'nt evaluate other codeblocks which has four spaces or ` ```sh ` and ` ``` `.

    # My First Document

    This is my first document.
    This will say "Hello, world!".

    ```lisp
    (defun hello ()
      (princ "Hello, world!"))
    ```

if you try this tutorial, save as `hello.l.md` the document which is used in this section. Now, to treat your documents you have three ways, **REPL**, **ASDF** and **Command Line**. And these are quick tutorials for them. For more information, please see the **Source Code** section.

### REPL

REPL is a good environment to try your documents of *Lamda*.
We can load them and test the behaivor quickly. It is conveniense to use them with *SLIME*.

#### Installation

Sorry, *Lambda* is NOT available in QuickLisp.
Currently, You can install *Lambda* with [Roswell](https://github.com/roswell/roswell).

    $ ros install ta2gch/lambda

It will install a comman line tool.
See also **Command Line** section.

#### Load a Document

*Lambda* provides some functions. For example, to make your REPL loding the file written in *Lambda*;

    > (lambda:lambdaload #p"hello.l.md")
    nil
    > (hello)
    Hello, World!

`lambda:lambdaload` is the same interface of `cl:load`. To load many files written in *Lambda* at once you have to write a ASDF system. See **ASDF** section.

#### Convert a Document

It has already made been beautifull that the documents of *Lambda* is, but if you need to get a Common Lisp code to make your project a production, *Lambda* provides a usefully tool.

    > (lambda:lambdaconvert #p"hello.l.md" #p"hello.lisp")

Or if you need a complete HTML file of your project, I recommend you using Pandoc, but Lambda provides too.

    > (lambda:lambdaconvert #p"hello.l.md" #p"hello.html")

Of cause, we can get a markdown without codeblocks which are between ` ```lisp ` and ` ``` `.

    > (lambda:lambdaconvert #p"hello.l.md" #p"hello.md")

As you notice, `lambda:lambdaconvert` detect the output file type automatically.

### ASDF

You can use *Lambda*'s syntax in your project without installation but in your `.asd` file you have to put a small snippet which this project, *Lambda*, uses too. This snippet sets a reader macro which effects the ASDF's loading to load documents and defines a class to tell ASDF what are loadable. Now let's write a small project whose tree of directories is a following.

    tutorial.asd
    src/
      tutorial.l.md

`src/tutorial.l.md` is that you wrote in **REPL** section, and `tutorial.asd` is this.

At first you write the definition of the package of this file.

    (in-package :cl-user)
    (defpackage :tutorial-asd
      (:use :cl :asdf))
    (in-package :tutorial-asd)

And you put the snippet that sets a reader macro which effects the ASDF's loading to load documents and defines a class to tell ASDF what are loadable.

    ;; TODO
    (set-dispatch-character
      #\# #\Space
      (lambda (s c1 c2)
        (do ((line (read-line s nil nil) (read-line s nil nil))
             (buffer (format nil "~a~a" c1 c2))
             (codeblock nil))
            (line (read-from-string buffer))
          (cond
            ((zerop (search "```lisp" line))
             (setf codeblock t))
            ((zerop (search "```" line))
             (setf codeblock nil))
            (codeblock
             (setf buffer (format nil "~a~%~a" buffer line)))))))

At last you define a ASDF system using a new component class `:lmd`.

    ;; TODO
    (defsystem :tutorial
      :author "Your Name"
      :license "Unlicense"
      :component ((:lmd "tutorial.l.md")))

You will have two files, `src/tutorial.l.md` and `tutorial.asd`, and be able to load this system as always like this.

    > (load #p"tutorial.asd")
    nil
    > (tutorial:hello)
    Hello, World!

Off course, users who use your project need nothing to load.
