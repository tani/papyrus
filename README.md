
    (defpackage #:papyrus/README
      (:use #:cl))
    (in-package #:papyrus/README)
    (named-readtables:in-readtable papyrus:md-syntax)

# Papyrus

A literate programming tool for Common Lisp + Markdown / Org mode / POD 

## About This Project

### Philosophy

*Papyrus* is the name of a programming style as well as the name of a tool
with which to implement it. The author of *papyrus* developed it to do
literate programming in LISP better than WEB, developed by Donald Knuth.
WEB and it's derived softwares are used in various programming languages.
They require developers compiling with them to obtain the source code.
It is required in order to do literate programming in C and Pascal, but isn't
in Common Lisp because Common Lisp has the reader macro which changes the
source code when the system reads it.

```mermaid
flowchart TB
  subgraph Knuth's system
  WEB -- CTANGLE --> Pascal
  WEB -- CWEAVE --> TeX
  end
  subgraph Our system
  Papyrus -- reader macro --> CommonLisp
  Papyrus --- Markdown
  end
```

*Papyrus* makes your markdown executable with the reader macro of Common Lisp.
For example, the author wrote this document with *Papyrus*. You can execute it
by running `ros run -l papyrus.asd -e '(require :papyrus)' -l README.md -q`.
How about this? Let's make your project more beautiful and useful!

```lisp
(princ "Hello, Papyrus!")
```

### Copyright

Copyright (c) 2019 -- 2024 TANIGUCHI Masaya All Rights Reserved

### License

MIT. See the [license texts](./LICENSE).

### Precaution

This is a new project. Please send me your feedback if you find any issues.

- [Project home](https://github.com/tani/papyrus)

## Tutorials

In *Papyrus*, you can write any text like the following,
and make the file extension `md`. Also, you can write with Markdown,
especially CommonMark whose specification can be found at
[commonmark.org](https://commonmark.org). *Papyrus* only evaluates codeblocks
*after* `(enable-md-syntax)` that are enclosed by ` ```lisp ` and ` ``` `.
The indented codeblock *before* `(enable-md-syntax)` is important, as this codeblock
specifies the required packages. Please do not forget it.

        (defpackage #:tutorial
          (:use #:cl)
          (:export #:hello))
        (in-package #:tutorial)
        (named-readtables:in-readtable papyrus:md-syntax)

    # My First Document

    This is my first document.
    This will say "Hello, world!".

    ```lisp
    (defun hello ()
      (princ "Hello, world!"))
    ```

If you try this tutorial, save it as `tutorial.md`, as this is the filename
used in this section. Now, there are two ways to generate the document,
**REPL** and **ASDF**. The following are quick tutorials for each. For more
information, please see the **Reference** section.

### REPL

A REPL is a good environment to experiment with your *Papyrus* documents. We
can load them and test the behaivor quickly and it is convenient to use them
with *SLIME*.

#### Installation

*Papyrus* is available in QuickLisp.
To install Just type,

    > (ql:quickload :papyrus)

Or, you can install *Papyrus* with [Roswell](https://github.com/roswell/roswell).

    $ ros install tani/papyrus

Next you can load document as follows:

    > (require :papyrus)
    nil
    > (load #p"tutorial.md")
    nil
    > (tutorial:hello)
    Hello, World!

### ASDF

Let's write a small project whose files are the following.

    tutorial.asd
    tutorial.md

`tutorial.md` is the file written in the **REPL** section, and
`tutorial.asd` is this:

    (defclass md (cl-source-file)
      ((type :initform "md")))

    (defclass org (cl-source-file)
      ((type :initform "org")))

    (defclass pod (cl-source-file)
      ((type :initform "pod")))

    (defsystem tutorial
      :version "0.1"
      :author "Your name"
      :license "MIT"
      :depends-on (#:papyrus #:named-readtables)
      :components ((:md "tutorial"))
      :description "A Literate Programming Framework")

Now that you have both files, `tutorial.md` and `tutorial.asd`,
you will be able to load this system like this.

    > (load #p"tutorial.asd")
    nil
    > (require :tutorial)
    nil
    > (tutorial:hello)
    Hello, World!

Of course, users of your project won't need to load anything else.

## Reference

### `enable-md-syntax`

This is a readtable defined for Markdown.
The codeblock enclosed by ` ```lisp ` and ` ``` ` is evaluated.

        (defpackage #:sample
          (:use #:cl)
          (:export #:sample-function))
        (in-package #:sample)
        (named-readtables:in-readtable papyrus:md-syntax)

    # Sample

    This is a sample code. The following function just says "Hello, world!"

    ```lisp
    (defun sample-function () (princ "Hello, world!"))
    ```

### `enable-org-syntax`

This is a readtable for org-mode.
The codeblock enclosed by ` #+BEGIN_SRC lisp :tangle yes ` and ` #+END_SRC ` is evaluated.
Unlike Markdown, any `#+CL:` tags are ignored when rendering the content to HTML.

    #+CL:* * (defpackage #:sample
    #+CL:* *   (:use #:cl)
    #+CL:* *   (:export #:sample-function))
    #+CL:* * (in-package #:sample)
    #+CL:* * (named-readtables:in-readtable papyrus:org-syntax)

    This is a sample code. The following function just says "Hello, world!"

    #+BEGIN_SRC lisp :tangle yes
    (defun sample-function () (princ "Hello, world!"))
    #+END_SRC

### `enable-pod-syntax`

This is a readtable defined by `named-readtables` for POD.
The codeblock outside of `=pod` and `=cut` is evaluated.
This syntax is similar to Perl's POD.

    (defpackage #:sample
      (:use #:cl)
      (:export #:sample-function))
    (in-package #:sample)
    (named-readtables:in-readtable papyrus:pod-syntax)

    =pod

    This is a sample code. The following function just says "Hello, world!"

    =cut

    (defun sample-function () (princ "Hello, world!"))

## Appendix

### Nix overlays
- [nix flakes without any frameworks.](https://github.com/tani/nix-common-lisp?tab=readme-ov-file#overlays)
  ```nix
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    papyrus = {
      url = "github:tani/papyrus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  ```
  ```nix
  let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          inputs.papyrus.overlays.default
        ];
      };
  ```
- [flake-parts](https://flake.parts/overlays.html?highlight=overlays#consuming-an-overlay)
  ```nix
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    papyrus = {
      url = "github:tani/papyrus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  ```
  ```nix
    perSystem = { system, ... }: {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.papyrus.overlays.default
        ];
        config = { };
      };
    };
  ```
### Emacs Lisp

### Recommended way

Try to use [polymode](https://github.com/vspinu/polymode)

    (require 'poly-markdown)
    (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))

### Old way

If you use emacs, there is `mmm-mode` which highlights the syntax of lisp
codeblocks in Markdown, but SLIME doesn't works well in `mmm-mode`.

    (require 'mmm-mode)
    (setq mmm-global-mode 'maybe)
    (set-face-background 'mmm-default-submode-face nil)
    (mmm-add-mode-ext-class nil "\\.md?\\'" 'lisp-markdown)
    (mmm-add-classes
     '((lisp-markdown
        :submode lisp-mode
        :front "```lisp"
        :back "```")))
