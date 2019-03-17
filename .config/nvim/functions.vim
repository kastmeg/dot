
function! EnsureVimPlug(vimplug)
	if !filereadable(a:vimplug)
		echo 'vim-plug: Downloading junegunn/vim-plug..'
		silent !\curl -SLfo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		return 1
	endif
endfunction

function! PlugInstallIf(condition)
	if a:condition
		echo 'vim-plug: Installing plugins..'
		autocmd VimEnter * PlugInstall
	endif
endfunction
