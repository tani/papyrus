(defsystem #:papyrus
  :class :package-inferred-system
  :version "1.1.0"
  :author "TANIGUCHI Masaya"
  :license "MIT"
  :depends-on (#:named-readtables #:papyrus/src/papyrus)
  :description "A Literate Programming Tool"
  :in-order-to ((test-op (test-op #:papyrus/test))))

(defsystem #:papyrus/test
  :depends-on (#:parachute #:papyrus/test/reader)
  :perform (test-op (op c)
             (symbol-call :parachute :test :papyrus/test/reader)))

