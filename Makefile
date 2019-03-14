.PHONY: install uninstall
install:
	stow -vs --target=${HOME} --ignore="(README.md|Makefile|.gitignore)" .

uninstall:
	stow vD --target=${HOME} .

