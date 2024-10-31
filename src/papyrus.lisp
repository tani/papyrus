(defpackage #:papyrus/src/papyrus
  (:nicknames #:papyrus)
  (:use #:cl #:papyrus/src/reader)
  (:export #:enable-md-syntax
           #:enable-org-syntax
           #:enable-pod-syntax))
(in-package #:papyrus/src/papyrus)

(defun set-macro-character-once (char fn)
  (let ((old-readtable (copy-readtable)))
    (flet ((new-fn (stream char)
              (copy-readtable old-readtable *readtable*)
              (funcall fn stream char)))
      (set-macro-character char #'new-fn))))

(defun enable-md-syntax()
  (set-macro-character-once #\Newline #'md-reader))

(defun enable-org-syntax ()
  (set-macro-character-once #\Newline #'org-reader))

(defun enable-pod-syntax ()
  (set-macro-character-once #\Newline #'pod-reader))
