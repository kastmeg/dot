CREATE_LINKS_IN	:= ${HOME}
VIMPLUG_URL	:= https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
VIMPLUG_PATH	:= ${HOME}/.local/share/nvim/site/autoload/plug.vim

all: vimplug

.PHONY: stow
stow:
	stow -vS --target=${CREATE_LINKS_IN} --ignore="(README.md|Makefile|.gitignore)" .

.PHONY: vimplug
vimplug: stow
	curl -sSLf -o "${VIMPLUG_PATH}" --create-dirs "${VIMPLUG_URL}"
	nvim -c "PlugInstall" -c "exit" -c "exit" 

.PHONY: pkgs
pkgs:
	sudo pacman -S --noconfirm \
		neovim \
		python-neovim \
		python2-neovim \
		go \
		cargo

.PHONY: clean
clean:
	stow --target=${CREATE_LINKS_IN} -v -D .
	rm -rf "${VIMPLUG_PATH}"

