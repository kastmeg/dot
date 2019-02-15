"      ╔════════════════════════════════╗
"      ║                                ║
"      ║  █▟█▌ ▟█▙ ▐▙█▙  ██  ▐▙██▖▗▟██▖ ║
"      ║  █▘  ▐▛ ▜▌▐▛ ▜▌  █  ▐▛ ▐▌▐▙▄▖▘ ║
"      ║  █   ▐▌ ▐▌▐▌ ▐▌  █  ▐▌ ▐▌ ▀▀█▖ ║
"      ║  █   ▝█▄█▘▐█▄█▘▗▄█▄▖▐▌ ▐▌▐▄▄▟▌ ║
"      ║  ▀    ▝▀▘ ▝▘▀▘ ▝▀▀▀▘▝▘ ▝▘ ▀▀▀  ║
"      ║ ▐▙██▖ ▟█▙  ▟█▙ ▐▙ ▟▌ ██  ▐█▙█▖ ║
"      ║ ▐▛ ▐▌▐▙▄▟▌▐▛ ▜▌ █ █   █  ▐▌█▐▌ ║
"      ║ ▐▌ ▐▌▐▛▀▀▘▐▌ ▐▌ ▜▄▛   █  ▐▌█▐▌ ║
"      ║ ▐▌ ▐▌▝█▄▄▌▝█▄█▘ ▐█▌ ▗▄█▄▖▐▌█▐▌ ║
"      ║ ▝▘ ▝▘ ▝▀▀  ▝▀▘   ▀  ▝▀▀▀▘▝▘▀▝▘ ║
"      ║ configuration (/w cool boxart) ║
"      ╚════════════════════════════════╝
" ╔══════════════════════════════════════════╗
" ║ About                                    ║
" ╟──────────────────────────────────────────╢
" ║ My neovim config. Mostly used for        ║
" ║ * Go                                     ║
" ║ * Shell                                  ║
" ║ * Markdown                               ║
" ║                                          ║
" ║ Certainly has its quirks and probably    ║
" ║ meant for general consumption.           ║
" ╟──────────────────────────────────────────╢
" ║ Boxes?                                   ║
" ╟──────────────────────────────────────────╢
" ║ Don't let the boxes fool you! Probably   ║
" ║ the coolest thing about this file.       ║
" ║                                          ║
" ║ This vim config isn't even particularly  ║
" ║ well suited to box-construction.         ║
" ║                                          ║
" ║ Heres a good reference for unicode box   ║
" ║ elements:                                ║
" ║                                          ║
" ║ * jrgraphix.net/r/Unicode/2500-257F      ║
" ║                                          ║
" ║ Vim-plugin to surround text in awesome   ║
" ║ box-art would be nice                    ║
" ╚══════════════════════════════════════════╝
" ╔══════════════════════════════════════════╗
" ║ Keybindings                              ║
" ╟──────────────────────────────────────────╢
" ║ * <L>eader key is mapped to space        ║
" ║ * Arrow-keys manage tabs                 ║
" ╟╌╌╌╌╌╌╌╌╌┬╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╢
" ║ ^C-Up   │ New Tab                        ║
" ║ ^C-Down │ Close Tab                      ║
" ║ ^C-Left │ Previous Tab                   ║
" ║ ^C-Right│ Next Tab                       ║
" ╟─────────┼────────────────────────────────╢
" ║ ^X^F    │ Complete Path                  ║
" ║ ^N      │ Complete Word (^Next ^Prev)    ║
" ║ <L>o    │ Open Buffer Explorer           ║
" ║ <L>f    │ Open MRU                       ║
" ║ <L>ss   │ Replace word under cursor      ║
" ║ <L>[ret]│ Open terminal                  ║
" ║ <L>ev   │ Open init.vim in a v-split     ║
" ║ <L>sv   │ Source init.vim                ║
" ║         │                                ║
" ╟─────────┴────────────────────────────────╢
" ║                                          ║
" ╚══════════════════════════════════════════╝
"
" ╔═══════════╗
" │ Variables │
" ╰───────────╯
let PLUGDIR=$XDG_DATA_HOME . '/nvidia/plugged'
let VIMHOME=$XDG_CONFIG_HOME . '/nvim'

" ╔═══════════╗
" │ Functions │
" ╰───────────╯
" Requires a working rust compiler
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

" ╔═════════╗
" │ Plugins │
" ╰─────────╯
call plug#begin(PLUGDIR)
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do':  PLUGDIR . '/gocode/vim/install.sh' }
Plug 'Nequo/vim-allomancer'
Plug 'fidian/hexmode'
Plug 'tpope/vim-sleuth'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ekalinin/Dockerfile.vim'
Plug 'junegunn/goyo.vim'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'SirVer/ultisnips'
Plug 'pearofducks/ansible-vim'
Plug 'vim-scripts/mru.vim'
Plug 'amix/open_file_under_cursor.vim'
Plug 'Raimondi/delimitMate'
Plug 'pangloss/vim-javascript'
Plug 'ternjs/tern_for_vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'maxbrunsfeld/vim-yankstack'
call plug#end()

" ╔══════════╗
" │ Settings │
" ╰──────────╯
set noerrorbells
set nowrap
set number
set rnu
set completeopt=longest,menuone
set scrolloff=8
set fileformats=unix,dos,mac
set encoding=utf8
set clipboard^=unnamedplus
set showmatch
set ignorecase
set smartcase
set smartindent
set lazyredraw
set autowrite
set laststatus=2
set statusline=%{HasPaste()}%t%m%r%h%w\ %l,%c,%p%%\ %y
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" ╔═════════════╗
" │ Keybindings │
" ╰─────────────╯
let mapleader = " "
nnoremap <leader>h <C-w>h<cr>
nnoremap <leader>j <C-w>j<cr>
nnoremap <leader>k <C-w>k<cr>
nnoremap <leader>l <C-w>l<cr>
nnoremap <leader><enter> <C-w><C-v><C-l>:terminal<cr>
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
noremap <C-e> :cnext<cr>
noremap <C-m> :cprevious<cr>
nnoremap <leader>e :cclose<cr>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <C-up> :tabnew<cr>
nnoremap <C-right> :tabNext<cr>
nnoremap <C-left> :tabPrevious<cr>
nnoremap <C-down> :tabclose<cr>

nnoremap <leader>ss :%s/\<<C-r><C-w>\>/
nnoremap <leader>3 :s/^/# /g<cr>/ohbabybabyhowwasisupposedtoknowuhoouh<cr>
nnoremap <leader>w :w!<cr>
nnoremap <leader>wq :wq!<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>f :Goyo<cr>
nnoremap <leader>o :BufExplorer<cr>
nnoremap <leader>f :MRU<cr>
command! Q q
command! W w

" ╔════════════════╗
" │ Spell checking │
" ╰────────────────╯
set spell spelllang=en_us
highlight clear SpellBad cterm
highlight SpellBad ctermbg=NONE ctermfg=167 cterm=underline
setlocal spelllang=en_us
set nospell
autocmd FileType gitcommit setlocal spell complete+=kspell
autocmd BufNewFile,BufRead *.md setlocal spell complete+=kspell
autocmd BufNewFile,BufRead *.txt setlocal spell complete+=kspell
autocmd BufNewFile,BufRead *.markdown setlocal spell complete+=kspell
autocmd BufNewFile,BufRead *.markdown Goyo
autocmd BufNewFile,BufRead *.md Goyo

" ╔══════════╗
" │ UltiSnip │
" ╰──────────╯
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"
let g:UltiSnipsEditSplit="vertical"

" ╔═══════════╗
" │ GitGutter │
" ╰───────────╯
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '¿'
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 0
let g:gitgutter_map_keys = 0

if exists('&signcolumn')
	set signcolumn=yes
else
	let g:gitgutter_sign_column_always = 1
endif

" ╔════════════════════╗
" │ NeoMake / Deoplete │
" ╰────────────────────╯
call neomake#configure#automake('w')
call neomake#configure#automake('nw', 100)
call neomake#configure#automake('rw', 100)

let g:deoplete#enable_at_startup = 1
let g:polyglot_disabled = ['go']
let g:neomake_go_enabled_makers = ['go', 'golint']
let g:neomake_info_sign = {'text': 'i', 'texthl': 'NeomakeInfoSign'}
let g:neomake_error_sign = {'text': 'e', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': 'w', 'texthl': 'NeomakeWarningSign'}
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_exit = 1

" ╔════════╗
" │ Golang │
" ╰────────╯
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype go map <leader>r <Plug>(go-run)
autocmd Filetype go map <leader>t <Plug>(go-test)
autocmd Filetype go map <leader>b <Plug>(go-build)
autocmd Filetype go map <leader>gi :GoImport<cr>
autocmd Filetype go map <leader>gh :GoDoc<cr>

let g:go_list_type = "quickfix"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_type_info = 1
let g:go_addtags_transform = "snakecase"
let g:go_fmt_command = "gofmt"
let g:go_metalinter_autosave = 1
" ╔═══════════════╗
" │ Miscellaneous │
" ╰───────────────╯
let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'

let g:goyo_width = 80
let g:goyo_height = 90
let g:goyo_linenr = 0

set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

" Open help in a vertical split instead
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

" Open previously edited files with the cursor in the same position
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif

" Persistent undo-history
if has('persistent_undo')
  set undofile
  set undodir=~/.local/share/nvim/undo//
endif

" ╔═════════════════════════╗
" │ Colorscheme & Esthetics │
" ╰─────────────────────────╯
colorscheme allomancer

hi VertSplit ctermbg=bg ctermfg=11
set fillchars+=vert:\╵

if &diff
  highlight LineNr ctermfg=238 ctermbg=black
  highlight Cursorlinenr ctermfg=95 ctermbg=NONE
  highlight cursorline ctermfg=95 ctermbg=NONE
 set cursorline
endif

set listchars=tab:→\ ,trail:⌁
set list
highlight ExtraWhitespace ctermfg=11
match ExtraWhitespace /\s\+$/

let g:airline_theme = 'minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let NVIM_TUI_ENABLE_TRUE_COLOR=1
let NVIM_TUI_ENABLE_CURSOR_SHAPE=1
