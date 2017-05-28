### Source Code

The code of *Lambda* is very simple.
In this Section, *Lambda* defines `lambda:lambdaconvert` and
`lambda:lambdaload`.

Here is a definition of this package. The nicknames is `lmd` you can use it
in a REPL like `lmd:lambdaconvert`. *Lambda* uses `3bmd` to covert a document
from Markdown to HTML.

```lisp
(in-package :cl-user)
(defpackage :lambda
  (:nicknames :lmd)
  (:use :cl :3bmd)
  (:export :lambdaload :lambdaconvert))
(in-package :lambda)
```

#### Copy a `*readtable*`

It asigns global `*readtable*` to local variable.

```lisp
(defmacro local-readtable (&body body)
  `(let ((*readtable* (copy-readtable nil)))
     ,@body))
```

#### Read All Texts from the File

Main algorithm of *Lambda* reader is taht adds `line` `buffer` in a codeblock.

```lisp
(defmacro lambda-reader/step (buffer line codeblock op)
  `(cond
     ((equalp 0 (search "```lisp" ,line)) (setf ,codeblock t))
     ((equalp 0 (search "```" ,line)) (setf ,codeblock nil))
     ((funcall ,op codeblock)
      (setf ,buffer (format nil "~a~%~a" ,buffer ,line)))))
```

Main loop of *Lambda* reader is that does `lambda-reader/step` until the end of
file, and return the result as string. `op` in the arguments expects `cl:not`
or `cl:identity`.

```lisp
(defun lambda-reader/main (stream op)
  (do ((line (read-line stream nil nil)
             (read-line stream nil nil))
       (buffer (if (funcall op nil) "# " ""))
       (codeblock nil))
      ((not line) buffer)
    (lambda-reader/step buffer line codeblock op)))
```

It returns symbols wrapped with `(progn)` and it is asigned `# ` of
`*readtable*` in the next chapter.

```lisp
(defun lambda-reader (stream c1 c2)
  (declare (ignore c1 c2))
  (read-from-string
   (format nil "(progn ~a)" (lambda-reader/main stream  #'identity))))
```

#### Load a Script

It asigns `lambda:lambda-reader` to `# ` of `*readtable*` and calls `cl:load`.

```lisp
(defun lambdaload (pathspec)
  (local-readtable
   (set-dispatch-macro-character #\# #\Space #'lambda-reader)
   (with-open-file (in pathspec) (load in))))
```

#### Convert a Document

It extracts codeblock of lisp from `src` and saves as `dest`.

```lisp
(defun lambdaconvert/lisp (src dest)
  (with-open-file (in src)
    (with-open-file (out dest)
      (princ (lambda-reader/main in #'identity) out))))
```

It extracts markdown from `src` and saves as `dest`.

```lisp
(defun lambdaconvert/markdown (src dest)
  (with-open-file (in src)
    (with-open-file (out dest)
      (princ (lambda-reader/main in #'not) out))))
```

It extracts markdown and converts HTML, finally saves as `dest`.

```lisp
(defun lambdaconvert/html (src dest)
  (with-open-file (in src)
    (with-open-file (out dest)
      (parse-string-and-print-to-stream
        (lambda-reader/main in #'not) out))))
```

It detects the extension of given file but uses `pathname-type` that
will return `"md"` which is same as `tutorial.md` when is given
`tutorial.l.md`.

- `md` `markdown`
- `html`
- `lisp` `lsp` `l`

```lisp
(defun lambdaconvert (src dest)
  (cond
   ((or (string= "md" (pathname-type dest))
        (string= "markdown" (pathname-type dest)))
    (lambdaconvert/markdown src dest))w
   ((string= "html" (pathname-type dest))
    (lambdaconvert/html src dest))
   ((or (string= "lisp" (pathname-type dest))
        (string= "lsp" (pathname-type dest))
        (string= "l" (pathname-type dest)))
    (lambdaconvert/lisp src dest))))
```

