all: README.md README.l

README.md: README.l.md
	perl bin/lmd2md.pl < README.l.md > README.md

README.l: README.l.md
	perl bin/lmd2l.pl < README.l.md > README.l

.PHONY: clean

clean:
	rm *~
