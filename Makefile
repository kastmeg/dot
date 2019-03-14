TARGET 	:= ${HOME}
NOFOLD	:= --no-folding

.PHONY: stow restow unstow
stow:
	stow -vS --target=${TARGET} ${NOFOLD} --ignore="(README.md|Makefile|.gitignore)" .

restow:
	stow -vR --target=${TARGET} ${NOFOLD} --ignore="(README.md|Makefile|.gitignore)" .

unstow:
	stow -vD --target=${TARGET} .

