(defpackage #:papyrus/src/papyrus
  (:nicknames #:papyrus)
  (:use #:cl #:papyrus/src/reader #:named-readtables)
  (:export #:papyrus #:papyrus-markdown #:papyrus-org))
(in-package #:papyrus/src/papyrus)

(defreadtable #:papyrus
    (:merge :standard)
  (:macro-char #\Newline #'markdown-reader))

(defreadtable #:papyrus-markdown
    (:merge :standard)
  (:macro-char #\Newline #'markdown-reader))

(defreadtable #:papyrus-org
    (:merge :standard)
  (:macro-char #\Newline #'org-reader))

(defreadtable #:papyrus-pod
    (:merge :standard)
  (:macro-char #\Newline #'pod-reader))
