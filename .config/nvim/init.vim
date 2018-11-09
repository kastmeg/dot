"~~~~~~~~~~~~~~~~~~~~~~~
" Plugins:
"~~~~~~~~~~~~~~~~~~~~~~~
" Builds the markdown composer rust plugin renders markdown in 
" a browser window async. Requires a rust compiler
call plug#begin('~/.local/share/nvim/plugged')
" General
Plug 'neomake/neomake'          " Async linting framework
Plug 'scrooloose/nerdcommenter' " leader+cc, leader+cy
Plug 'scrooloose/nerdtree' 

" Git
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

" Golang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'mdempsky/gocode'        ", { 'rtp': 'nvim', 'do': '~/.local/share/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'godoctor/godoctor.vim'  " :Rename, :Refactor
Plug 'jodosha/vim-godebug'    " Add debugging break-points in vim

" Misc
Plug 'pearofducks/ansible-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'fidian/hexmode'           " :hexmode
Plug 'tpope/vim-sleuth'

" Aesthetics
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'mboughaba/i3config.vim'

" Markdown
Plug 'euclio/vim-markdown-compose', {'do': function('BuildComposer') }
Plug 'junegunn/goyo.vim'

call plug#end()

let g:deoplete#enable_at_startup = 1
"~~~~~~~~~~~~~~~~~~~~~~~
" General Settings:
"~~~~~~~~~~~~~~~~~~~~~~~
" Set spell check language
"
set spell spelllang=en_us
" Disable error bells
set noerrorbells

" Disable .swp file creation
set noswapfile

" Don't linewrap
set nowrap

" Display margin line number
set number

" Enable and configure wildmenu
set wildmenu
set wildmode=list:longest
set completeopt=longest,menuone

" Enable mouse support
set mouse=a

" Start scrolling before the cursor reaches the top or bottom of the buffer
set scrolloff=8

" Set some sane defaults
set fileformats=unix,dos,mac
set encoding=utf-8

" Yanked text ends up in the system clipboard (On Mac OS at least)
set clipboard^=unnamed
set clipboard^=unnamedplus

" Visually identify the matching paren or bracket
set showmatch

" Ignore case when searching unless mixed case is explicitly used 
" in the search term
set ignorecase
set smartcase

" Indent new lines based on the surrounding lines indentation
set smartindent

" Don't redraw during macros, registers and other untyped commands
set lazyredraw

" automatically write files on :make, :GoBuild, etc
set autowrite

"~~~~~~~~~~~~~~~~~~~~~~~
" Key Mapping:
"~~~~~~~~~~~~~~~~~~~~~~~
" Set the leader key to spacebar
let mapleader = " "

" Unbind the arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" j+k in insert mode acts as escape
inoremap jk <esc>

" leader + hjkl moves between splits
nnoremap <leader>h <C-w>h<cr>
nnoremap <leader>j <C-w>j<cr>
nnoremap <leader>k <C-w>k<cr>
nnoremap <leader>l <C-w>l<cr>

" Enable quick vimrc editing
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

autocmd Filetype go map <leader>r <Plug>(go-run)
autocmd Filetype go map <leader>t <Plug>(go-test)
autocmd Filetype go map <leader>b <Plug>(go-build)
autocmd Filetype go map <leader>gi :GoImport 

" Jump to errors with CTRL+n and CTRL+m.
noremap <C-n> :cnext<cr>
noremap <C-m> :cprevious<cr>

" Close quick-fix window
nnoremap <leader>e :cclose<cr>

nnoremap <leader>t :tabnew<cr>
nnoremap <leader>. :tabNext<cr>
nnoremap <leader>, :tabPrevious<cr>

" Replace all occurences of word under cursor
nnoremap <leader>ss :%s/\<<C-r><C-w>\>/

" Faster saving and quitting
nnoremap <leader>wq :wq!<cr>

" Quit all open windows
nnoremap <leader>q :qall!<cr>

" :Q = :q, :W = :w
command! Q q
command! W w

" Define keyboard mappings for neovim's built-in terminal
if has('nvim')
  tnoremap <Esc> <Esc><C-\><C-n>

  " mappings to move out from terminal to other views
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  " Open terminal in vertical, horizontal and new tab
  nnoremap <leader>tv :vsplit term://zsh<cr>
  nnoremap <leader>ts :split term://zsh<cr>
  nnoremap <leader>tt :tabnew term://zsh<cr>

  " always start terminal in insert mode
  autocmd BufWinEnter,WinEnter term://* startinsert

  noremap <silent> <C-T> :Ttoggle<cr>
  noremap <silent> <C-T> :Ttoggle<cr>
endif

"~~~~~~~~~~~~~~~~~~~~~~~
" Configuration:
"~~~~~~~~~~~~~~~~~~~~~~~
let g:deoplete#enable_at_startup = 1
" Disable polyglot for the following languages
let g:polyglot_disabled = ['go']

" When writing a buffer.
call neomake#configure#automake('w')
" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 100)
" When reading a buffer (after 1s), and when writing.
call neomake#configure#automake('rw', 100)

" gometalinter --install
let g:neomake_go_enabled_makers = ['go', 'golint']
let g:neomake_info_sign = {'text': 'i', 'texthl': 'NeomakeInfoSign'}
let g:neomake_error_sign = {'text': 'e', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': 'w', 'texthl': 'NeomakeWarningSign'}
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_exit = 1

" filetype overrides:
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.html setlocal noexpandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.vim setlocal expandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.yml setlocal expandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.sh setlocal expandtab tabstop=4 shiftwidth=4

" Set filetype to nginx for .conf files in the right directories
autocmd BufRead,BufNewFile
	\ /etc/nginx/*,/usr/local/nginx/*,/opt/nginx/*
	\ if &ft == 'conf' || &ft == '' |
	\ set filetype=nginx | endif

" vim-go:
" Only use quickfix error lists
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

" Nerdtree:
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" Nerdcommenter:
" Add a space between the comments-symbol and commented text
let g:NERDSpaceDelims = 1 
" Allow commenting empty lines
let g:NERDCommentEmptyLines = 1
" Trim trailing whitespace
let g:NERDTrimTrailingWhitespace = 1

" Open help in a vertical split instead
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

" Open previously edited files with the cursor in the same position
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif

" Make undo history persist through sessions
if has('persistent_undo')
  set undofile
  set undodir=~/.local/share/nvim/undo//
endif

" Gitgutter:
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '¿'
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 0
let g:gitgutter_map_keys = 0

" Enable the sign collumn even when there are no signs to display
" to avoid it popping in and out
if exists('&signcolumn')
	set signcolumn=yes
else
	let g:gitgutter_sign_column_always = 1
endif

" Configuration for base16 theme (used previously)
source ~/.config/nvim/theme/base16.vim 

" Airline:
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let NVIM_TUI_ENABLE_TRUE_COLOR=1
let NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" vimdiff
if &diff 
  highlight LineNr ctermfg=238 ctermbg=black
  highlight Cursorlinenr ctermfg=95 ctermbg=NONE
  highlight cursorline ctermfg=95 ctermbg=NONE
  set cursorline
endif

