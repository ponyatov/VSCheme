CWD    = $(CURDIR)
MODULE = $(notdir $(CWD))

NOW = $(shell date +%d%m%y)
REL = $(shell git rev-parse --short=4 HEAD)

.PHONY: merge release zip

MERGE  = Makefile README.md *.js* .gitignore .vscodeignore

merge:
	git checkout master
	git checkout shadow -- $(MERGE)

release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	git checkout shadow

zip:
	git archive --format zip --output $(MODULE)_$(NOW)_$(REL).zip HEAD
