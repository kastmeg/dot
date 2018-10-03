```ascii
                 ▄▄               ▄
                ██             ▄▄ █ ▄▄
               ██               █████
 ▄███▄▄▄█     ██               ▀▀ █ ▀▀
 ▀   ▀▀▀     ▄█▀                  ▀
            ▄█▀         ██
           ▄█▀          ▀▀
```
# My (slightly bugged) dotfiles

## Install
```bash
git clone https://github.com/eikaas/dotfiles ~/.dotfiles && cd ~/.dotfiles 
make install
```

## Docker
The provided Dockerfile creates an archlinux image with the dotfiles installed & configured. A great way to test the config without messing up any existing environment

```bash
make image
make run
```

## Misc.
### Ligatures
The following AUR-packages were installed to get ligatures to display correctly.
* termite-git
* termite-terminfo-git

### Bugs
* base16 not working
* zplug won't install the required plugins at build time. This leads to sweat, duckt-tape and feces dominating the Makefile unfortunately
* And probably a whole lot more at the moment
