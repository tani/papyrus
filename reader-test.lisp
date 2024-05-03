(load #p"reader.lisp")
(in-package :papyrus-reader)

(defvar md "

# This is a markdown file

This is a paragraph.

This is another paragraph.

- This is a list item
- This is another list item

This is a inline code block: `echo 'hello world'`

This is a code block:

   ;; This is a code block

```lisp
(defun hello-world-1 ()
  (print \"Hello, World!\"))
```

```
This is a code block
```

```lisp
(defun hello-world-2 ()
  (print \"Hello, World!\"))
```

")

(format t "Testing markdown reader~%")
(let ((stream (make-string-input-stream md)))
  (assert
    (equalp
     '(progn
       (defun hello-world-1 ()
         (print "Hello, World!"))
       (defun hello-world-2 ()
         (print "Hello, World!")))
       (papyrus-markdown-reader stream nil nil))))
(format t "Markdown reader test passed~%")

(defvar org "

* This is an org file

This is a paragraph.

This is another paragraph.

- This is a list item
- This is another list item

This is a inline code block: =echo 'hello world'=

This is a code block:

#+BEGIN_SRC lisp :tangle yes
(defun hello-world-1 ()
  (print \"Hello, World!\"))
#+END_SRC

#+BEGIN_SRC text
This is a code block
#+END_SRC

#+BEGIN_SRC lisp :tangle yes
(defun hello-world-2 ()
  (print \"Hello, World!\"))
#+END_SRC

")

(format t "Testing org reader~%")
(let ((stream (make-string-input-stream org)))
  (assert
    (equalp
     '(progn
       (defun hello-world-1 ()
         (print "Hello, World!"))
       (defun hello-world-2 ()
         (print "Hello, World!")))
     (papyrus-org-reader stream nil nil))))
(format t "Org reader test passed~%")
