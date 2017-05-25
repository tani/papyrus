# Lambda

*Lambda* is a literate LISP programming tool.
You write a code once and get two texts, `.md` and `.lisp`. *Lambda* is a neme of programming style and utilities to do it.

## Usage

You have three ways to use *lambda*.

- REPL
- Shell
- ASDF

### REPL

#### Installation

You can install *lambda* by Quicklisp.

    (ql:quickload :lambda)

#### Functions

*lambda* provides two functions.

- convert
- load



##### Convert


`lambda:convert` converts from `.l.md` to three types.

###### Lisp

`lambda:convert` extracts codeblocks in source code and merges them.

    (lambda:convert #p"README.l.md" #p"README.l")

###### Markdown

`lambda:convert` removes codeblocks between ` ```lisp ` and ` ``` `.

    (lambda:convert #p"README.l.md" #p"README.md")

###### HTML

`lambda:convert` remove codeblocks and converts to HTML.

    (lambda:convert #p"README.l.md" #p"README.html")

##### Load


`lambda:load` loads `.l.md` as lisp.

    (lambda:load #p"README.l.md")

### Shell

#### Installation

You can install *lambda* by two ways, _Brew_ and _Roswell_.

    ros install ta2gch/lambda

#### Convert

*lambda* extract codeblocks in source code and merge them.

    lambda README.l.md README.l

And remove codeblocks between ` ```lisp ` and ` ``` `.

    lambda README.l.md README.md

### ASDF

In ASDF, you have to write this in .asd file to load .l.md file

    (set-dispatch-character
     #\# #\Space
     (lambda (s c1 c2)
       (read-from-string
        (do ((line (read-line stream nil nil))
         (buffer (format nil "~a~a" c1 c2))
         (codeblock nil))
        (line buffer)
          (cond
        ((zerop (search "```lisp" line)) (setf codeblock t))
        ((zerop (search "```" line)) (setf codeblock nil))
        (codeblock
         (setf buffer (concatenate 'string buffer #(#\Newline) line))))))))
