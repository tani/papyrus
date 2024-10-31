(defpackage #:papyrus/src/papyrus
  (:nicknames #:papyrus)
  (:use #:cl #:papyrus/src/reader #:named-readtables)
  (:export #:md-syntax
           #:org-syntax
           #:pod-syntax))
(in-package #:papyrus/src/papyrus)

(defreadtable md-syntax
  (:merge :standard)
  (:macro-char #\Newline #'md-reader))

(defreadtable org-syntax
  (:merge :standard)
  (:macro-char #\Newline #'org-reader))

(defreadtable pod-syntax
  (:merge :standard)
  (:macro-char #\Newline #'pod-reader))
