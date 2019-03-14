TARGET := ${HOME}

.PHONY: stow unstow
stow:
	stow -vS --target=${TARGET} --ignore="(README.md|Makefile|.gitignore)" .

unstow:
	stow -vD --target=${TARGET} .

