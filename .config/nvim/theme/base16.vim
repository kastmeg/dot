"
" https://github.com/chriskempson/base16
"
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  let g:base16_airline=1
  source ~/.vimrc_background
endif

let g:airline_theme = 'base16_default'

" TODO: These overrides shouldn't be applied in all scenarios 
highlight Search ctermbg=black ctermfg=201
highlight GitGutterAdd ctermfg=239 ctermbg=black
highlight GitGutterChange ctermfg=239 ctermbg=black
highlight GitGutterDelete ctermfg=239 ctermbg=black
highlight GitGutterChangeDelete ctermfg=239 ctermbg=black
highlight LineNr ctermfg=238 ctermbg=black
highlight Cursorlinenr ctermfg=95 ctermbg=NONE
highlight cursorline cterm=NONE ctermbg=NONE
highlight Pmenu	ctermbg=0	ctermfg=2 guibg=0
highlight PmenuSel ctermbg=10 guibg=8
highlight PmenuSbar ctermbg=2	ctermfg=0 guibg=0
highlight PmenuThumb ctermbg=black cterm=NONE

