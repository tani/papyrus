# lambda
lambda makes your markdown file executable.

## Usage

Lambda execute codeblock in `.l.md` as a code of Common Lisp

### Script mode

In the shell,
```sh
$ lambda --load README.l.md --quit # script
$ lambda -l README.l.md -q # shortcut
```

### REPL mode

In the shell,
```sh
$ lambda --load README.l.md # launch the REPL
$ lambda -l README.l.md # shortcut
```

Or, in the REPL

```lisp
> (lambda:load #p"README.l.md")
```
### export mode

In the shell,

```sh
$ lambda --html README.l.md # export .html file
$ lambda --lisp README.l.md # export .lisp file
$ lambda --markdown README.l.md # export .md file
```
Or, in the REPL

```lisp
> (lambda:export :html #p"README.l.md")
> (lambda:export :lisp #p"README.l.md")
> (lambda:export :markdown #p"README.l.md")
```

## Installation

```sh
$ ros install ta2gch/lambda
```
