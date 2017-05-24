# lambda
lambda makes your markdown file executable.

## Usage

Lambda execute codeblock in `.l.md` as a code of Common Lisp

### Script mode

In the shell,
```sh
$ llmd --load README.l.md --quit # script
$ llmd -l README.l.md -q # shortcut
```

### REPL mode

In the shell,
```sh
$ llmd --load README.l.md # launch the REPL
$ llmd -l README.l.md # shortcut
```

Or, in the REPL

```
> (llmd :load #p"README.l.md")
```

### Output mode

In the shell,

```sh
$ llmd --html README.l.md # output .html file
$ llmd --lisp README.l.md # output .lisp file
```
Or, in the REPL

```
> (llmd :html #p"README.l.md")
> (llmd :lisp #p"README.l.md")
```

## Installation

```
$ ros install ta2gch/lambda
```
