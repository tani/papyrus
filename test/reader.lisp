(defpackage #:papyrus/test/reader
  (:use #:cl #:parachute #:papyrus/src/reader))
(in-package #:papyrus/test/reader)

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

(define-test markdown-reader-test
  (let ((stream (make-string-input-stream md)))
    (is equalp
     '(progn
       (defun hello-world-1 ()
         (print "Hello, World!"))
       (defun hello-world-2 ()
         (print "Hello, World!")))
     (markdown-reader stream nil nil))))

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

(define-test org-reader-test
  (let ((stream (make-string-input-stream org)))
    (is equalp
     '(progn
       (defun hello-world-1 ()
         (print "Hello, World!"))
       (defun hello-world-2 ()
         (print "Hello, World!")))
     (org-reader stream nil nil))))

(defvar pod "
=pod

=head1 This is an org file

This is a paragraph.

This is another paragraph.

=over

=item This is a list item

=item This is another list item

=back

This is a inline code block: =echo 'hello world'=

This is a code block:

=cut

(defun hello-world-1 ()
  (print \"Hello, World!\"))

=pod

=begin text

This is a code block

=end text

=cut

(defun hello-world-2 ()
  (print \"Hello, World!\"))

")

(define-test pod-reader-test
  (let ((stream (make-string-input-stream pod)))
    (is equalp
     '(progn
       (defun hello-world-1 ()
         (print "Hello, World!"))
       (defun hello-world-2 ()
         (print "Hello, World!")))
     (pod-reader stream nil))))
