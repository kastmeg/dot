runtime functions.vim

let must = EnsureVimPlug(expand('~/.local/share/nvim/site/autoload/plug.vim'))
call plug#begin(expand('~/.local/share/nvim/plugged'))
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'freitass/todo.txt-vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
"Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do':  '~/.local/share/nvim/plugged/gocode/nvim/symlink.sh' }
"Plug 'fidian/hexmode'
call plug#end()
"call PlugInstallIf(must)

" colorscheme allomancer   " Set the colorscheme

set relativenumber  " Use relative line numbers
set nowrap          " dont wrap lines
set scrolloff=16    " Scroll when cursor is this many lines from the window edge
set showmatch       " show matching brackets
set ignorecase      " Be smart about ignoring case in patterns
set smartcase
set smartindent     " Smart autoindenting when starting new lines
set lazyredraw      " Makes vim not redraw while executing macros
set noexpandtab     " Dont expand tabs with spaces
set tabstop=8       " The number of spaces a <tab> is shown as
set shiftwidth=8    " shiftwidth should match tabstop
set laststatus=2    " always show status line

" Enable the bottom right cursor information and set its format+color
set ruler
set rulerformat=%25(%c\x%l\ 0x%O\ %1*\[0x%B\]%0*%) 
hi User1 ctermfg=Black ctermbg=Red

" Set the status line
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Display a symbol for trailing whitespace and <tab>'s
set list
set listchars=tab:→\ ,trail:⌁
highlight ExtraWhitespace ctermfg=11
match ExtraWhitespace /\s\+$/

" Recolor the vertical split
hi VertSplit ctermbg=bg ctermfg=11

" Change the vertical split symbol
set fillchars+=vert:\╵

" Let <space> be the <leader> key
let mapleader = " "

" Move between window splits
nnoremap <leader>h <C-w>h<cr>
nnoremap <leader>j <C-w>j<cr>
nnoremap <leader>k <C-w>k<cr>
nnoremap <leader>l <C-w>l<cr>

" open vim config
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" source vim config
nnoremap <leader>sv :source $MYVIMRC<cr>

" jump to the next error
nnoremap <C-e> :cnext<cr>

" close error window
nnoremap <leader>e :cclose<cr>

" Open current file in vscode
command! OpenInVSCode exe "silent !code --goto '" . expand("%") . ":" . line(".") . ":" . col(".") . "'" | redraw!

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" fixes some annoyances
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

autocmd BufNewFile,BufRead *.html setlocal noexpandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.vim setlocal expandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.yml setlocal expandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.sh setlocal expandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.xkb setlocal expandtab tabstop=2 shiftwidth=2 ft=xkb

" configure neomake/deoplete
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

set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

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

" Airline
let g:airline_theme = 'minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let NVIM_TUI_ENABLE_TRUE_COLOR=1
let NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" git-gutter configuration
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

" Spellcheck config
highlight clear SpellBad cterm
highlight SpellBad ctermbg=NONE ctermfg=167 cterm=underline
setlocal spelllang=en_us
" disable spellcheck by default
set nospell
" .. and enable it based on the file type instead
autocmd FileType gitcommit setlocal spell complete+=kspell
autocmd BufNewFile,BufRead *.md setlocal spell complete+=kspell
autocmd BufNewFile,BufRead *.txt setlocal spell complete+=kspell
autocmd BufNewFile,BufRead *.markdown setlocal spell complete+=kspell


