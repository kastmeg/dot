if exists('$XDG_DATA_HOME')
    let nvim_data_dir=expand('$XDG_DATA_HOME' . '/nvim')
else
    let nvim_data_dir=expand('~/.local/share/nvim')
endif

let nvim_plugdir=expand(nvim_data_dir . '/plugged')
let vimplug=expand(nvim_data_dir . '/autoload/plug.vim')

if !filereadable(vimplug)
  echo 'Installing junegunn/vim-plug...'
  silent !\curl -SLfo ~/.local/share/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo 'Installing plugins...'
  autocmd VimEnter * PlugInstall
endif

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

" Loading plugins.
call plug#begin(nvim_plugdir)
Plug 'neomake/neomake'
Plug 'fidian/hexmode'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/mru.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'amix/open_file_under_cursor.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Nequo/vim-allomancer'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do':  nvim_plugdir . '/gocode/nvim/install.sh' }
Plug 'pearofducks/ansible-vim'
Plug 'junegunn/goyo.vim'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
Plug 'ternjs/tern_for_vim'
Plug 'cespare/vim-toml'
Plug 'freitass/todo.txt-vim'
Plug 'SirVer/ultisnips'

"Plug 'chriskempson/base16-vim'
"Plug 'vim-scripts/grep.vim'
"Plug 'vim-scripts/CSApprox'
"Plug 'majutsushi/tagbar'
"Plug 'Shougo/vimproc.vim', {'do' : 'make'}
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'
"Plug 'Shougo/vimshell.vim'
"Plug 'hail2u/vim-css3-syntax'
"Plug 'gorodinskiy/vim-coloresque'
"Plug 'tpope/vim-haml'
"Plug 'mattn/emmet-vim'
"Plug 'arnaud-lb/vim-php-namespace'
"Plug 'jelera/vim-javascript-syntax'

call plug#end()

filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set noerrorbells
set rnu
set nowrap
set number
set completeopt=longest,menuone
set scrolloff=8
set fileformats=unix,dos,mac
set clipboard^=unnamedplus
set showmatch
set ignorecase
set smartcase
set smartindent
set lazyredraw
set autowrite
set laststatus=2
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set hidden
set modeline
set modelines=10
set title
set titlestring=%F
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

let mapleader = " "
nnoremap <leader>h <C-w>h<cr>
nnoremap <leader>j <C-w>j<cr>
nnoremap <leader>k <C-w>k<cr>
nnoremap <leader>l <C-w>l<cr>
nnoremap <leader><enter> <C-w><C-v><C-l>:terminal<cr>
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <C-e> :cnext<cr>
nnoremap <C-m> :cprevious<cr>
nnoremap <leader>e :cclose<cr>

command! OpenInVSCode exe "silent !code --goto '" . expand("%") . ":" . line(".") . ":" . col(".") . "'" | redraw!

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

nnoremap <C-up> :tabnew<cr>
nnoremap <C-right> :tabNext<cr>
nnoremap <C-left> :tabPrevious<cr>
nnoremap <C-down> :tabclose<cr>
nnoremap <leader>ss :%s/\<<C-r><C-w>\>/
nnoremap <leader>w :w!<cr>
nnoremap <leader>wq :wq!<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>f :Goyo<cr>
nnoremap <leader>o :BufExplorer<cr>
nnoremap <leader>f :MRU<cr>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

command! Q q
command! W w
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

nmap <leader>e :exec '!'.getline('.')<cr>
nmap <leader>r :w<cr>:!chmod +x % && ./% <cr>

" Manually open the browser if needed instead
let g:markdown_composer_open_browser=0
nnoremap <leader>m :ComposerOpen<cr>

" Spell checking
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

" HTML / Javascript
autocmd Filetype html setlocal ts=2 sw=2 expandtab
let g:javascript_enable_domhtmlcss = 1
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4
augroup END

" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" GitGutter
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

" Neomake / Deoplete
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

" Set filetype to nginx for .conf files in the right directories
autocmd BufRead,BufNewFile
	\ /etc/nginx/*,/usr/local/nginx/*,/opt/nginx/*
	\ if &ft == 'conf' || &ft == '' |
	\ set filetype=nginx | endif

" Go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
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
let g:go_metalinter_autosave = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_addtags_transform = "snakecase"
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"

augroup go
  au!
  au Filetype go map <leader>gi :GoImport<cr>
  au Filetype go map <leader>gh :GoDoc<cr>
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
  au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>db <Plug>(go-doc-browser)
  au FileType go nmap <leader>r  <Plug>(go-run)
  au FileType go nmap <leader>t  <Plug>(go-test)
  au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
  au FileType go nmap <C-g> :GoDecls<cr>
  au FileType go nmap <leader>dr :GoDeclsDir<cr>
  au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
  au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
  au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>

augroup END

let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'

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

" Goyo
let g:goyo_width = 80
let g:goyo_height = 90
let g:goyo_linenr = 0

" colorscheme / Estheticcs
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

" Airline
let g:airline_theme = 'minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let NVIM_TUI_ENABLE_TRUE_COLOR=1
let NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Spell Checking
highlight clear SpellBad cterm
highlight SpellBad ctermbg=NONE ctermfg=167 cterm=underline
setlocal spelllang=en_us
set nospell

" filetype overrides:
autocmd FileType gitcommit setlocal spell complete+=kspell
autocmd BufNewFile,BufRead *.md setlocal spell complete+=kspell
autocmd BufNewFile,BufRead *.txt setlocal spell complete+=kspell
autocmd BufNewFile,BufRead *.markdown setlocal spell complete+=kspell
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.html setlocal noexpandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.vim setlocal expandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.yml setlocal expandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.sh setlocal expandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.xkb setlocal expandtab tabstop=2 shiftwidth=2 ft=xkb

" vimdiff
if &diff 
  highlight LineNr ctermfg=238 ctermbg=black
  highlight Cursorlinenr ctermfg=95 ctermbg=NONE
  highlight cursorline ctermfg=95 ctermbg=NONE
 set cursorline
endif

