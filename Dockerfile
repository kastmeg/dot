FROM base/archlinux
LABEL maintainer "Robin Eikaas <robin@eika.as>"
ARG user=eikxyz

RUN pacman --noconfirm -Syu && pacman --noconfirm -S \
	git \
	zsh \
	neovim \
	python-neovim \
	python2-neovim \
	tmux \
	exa \
	neofetch \
	man \
	make \
	sudo \
	tree \
	stow \
	fakeroot \
	openssh \
	automake \
	binutils

RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
	&& locale-gen \
	&& echo 'LANG=en_US.UTF-8' > /etc/locale.conf

RUN useradd --create-home --shell /usr/bin/zsh $user
RUN gpasswd -a $user wheel
RUN echo "%wheel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR /home/$user/.dotfiles
ADD . .
RUN chown -R $user:$user /home/$user
USER $user

ENV TERM xterm-256color
ENV LANG en_US.UTF-8
ENV XDG_CONFIG_HOME /home/$user/.config
ENV XDG_DATA_HOME /home/$user/.local/share
ENV ZDOTDIR /home/$user/.config/zsh
ENV ZDATADIR /home/$user/.local/share/zsh
ENV ZPLUG_HOME /home/$user/.local/share/zplug

RUN git clone https://aur.archlinux.org/aurman.git ~/aurman && \
	cd ~/aurman && \
	makepkg --noconfirm --syncdeps --install --skippgpcheck && \
	rm -rf ~/aurman

# Install AUR packages
RUN aurman --noconfirm --noedit --skip_news -S \
	neovim-drop-in

RUN sudo pacman -Syu --noconfirm

RUN make install

WORKDIR /home/$user

RUN rm -rf \
	.bashrc \
	.bash_profile \
	.bash_logout \
	.cache

CMD ["zsh", "-ic", "zplug install"]

