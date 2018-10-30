NAME      := eikaas/dotfiles
TAG       := $$(git rev-parse --short HEAD)
HOSTNAME  := dokr-$$(git rev-parse --short HEAD | cut -c 1-4)
IMAGE     := ${NAME}:${TAG}
LATEST    := ${NAME}:latest
IMG_USR   := eikxyz

ZPLUG_HOME := ${HOME}/.local/share/zplug

.PHONY: image run

# Build a docker environment based on the dotfiles 
# (nasty hack to bake the zplug plugins into the image)
image: 
	@docker build --build-arg user=${IMG_USR} -t zplug_hack_tmp .
	@docker run -it --hostname zplug_hack_tmp zplug_hack_tmp
	@docker commit --change='CMD ["/usr/bin/zsh"]' -m "install zplug packages" $(shell docker ps -l -q) ${IMAGE}
	@docker tag ${IMAGE} ${LATEST}

# Run the dotfiles in a docker container
run: image
	docker run --rm -it --hostname ${HOSTNAME} ${IMAGE}

# Install the dotfiles to the current directory's parent directory
install:
	stow -vS --target=${HOME} --ignore="(README.md|Makefile|Dockerfile)" .
	curl -sSLfo "${XDG_DATA_HOME}/nvim/site/autoload/plug.vim" --create-dirs \
    		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
	vim -c "PluginInstall" -c "exit" -c "exit"
	[[ -d ${ZPLUG_HOME} ]] || git clone https://github.com/zplug/zplug ${ZPLUG_HOME}


uninstall:
	stow --target=${HOME} -v -D .
