runtime functions.vim

let must = EnsureVimPlug(expand('~/.local/share/nvim/site/autoload/plug.vim'))
call plug#begin(expand('~/.local/share/nvim/plugged'))
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-go'
Plug 'stamblerre/gocode', { 'rtp': 'vim', 'do':  '~/.local/share/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'freitass/todo.txt-vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'fidian/hexmode'
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'stevearc/vim-arduino'
Plug 'sudar/vim-arduino-syntax'
Plug 'cakebaker/scss-syntax.vim'
"Plug 'airblade/vim-gitgutter'
call plug#end()
call PlugInstallIf(must)

let base16colorspace=256
set background=dark
set termguicolors
source ~/.config/nvim/colorscheme.vim

set hidden              " Enables you to swap buffers without nag about unwritten buffers
set relativenumber      " Use relative line numbers
set nowrap              " dont wrap lines
set scrolloff=16        " Scroll when cursor is this many lines from the window edge
set showmatch           " show matching brackets
set ignorecase          " Be smart about ignoring case in patterns
set smartcase
set smartindent         " Smart autoindenting when starting new lines
set lazyredraw          " Makes vim not redraw while executing macros
set noexpandtab         " Dont expand tabs with spaces
set tabstop=8           " The number of spaces a <tab> is shown as
set shiftwidth=8        " shiftwidth should match tabstop
set noshowmode          " lightline displays the mode information
"set foldmethod=syntax   " Enables vim-go to fold sections of code

" Display a symbol for trailing whitespace and <tab>'s
"set list
"set listchars=tab:→\ ,trail:⌁
"highlight ExtraWhitespace ctermfg=11
"match ExtraWhitespace /\s\+$/

" Recolor the vertical split
hi VertSplit ctermbg=bg ctermfg=11

" Change the vertical split symbol
set fillchars+=vert:\╵

" Let <space> be the <leader> key
let mapleader = " "

nnoremap <leader>r :GoRun<cr>

" Move between window splits
nnoremap <leader>h <C-w>h<cr>
nnoremap <leader>j <C-w>j<cr>
nnoremap <leader>k <C-w>k<cr>
nnoremap <leader>l <C-w>l<cr>

" Leaves insert mode
inoremap jk <esc>

nnoremap <leader>wq :wq!<cr>
nnoremap <leader>q :q!<cr>

" Next buffer
nnoremap <leader><right> :bn<cr>
nnoremap <leader>bn :bn<cr>

" Previous buffer
nnoremap <leader><left> :bp<cr>
nnoremap <leader>bp :bp<cr>

" Open file using :FZF
nnoremap <leader>o :FZF<cr>

"  Lists buffer and
nnoremap <leader><up> :ls<cr>

" open vim config
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" source vim config
nnoremap <leader>sv :source $MYVIMRC<cr>

" jump to the next error
nnoremap <C-e> :cnext<cr>

nnoremap <leader>er oif err != nil {<cr> return err<cr>}<cr>

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
autocmd BufNewFile,BufRead *.php setlocal noexpandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.vim setlocal expandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.yml setlocal expandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.sh setlocal expandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.xkb setlocal expandtab tabstop=2 shiftwidth=2 ft=xkb
autocmd BufNewFile,BufRead *.scss setlocal noexpandtab tabstop=4 shiftwidth=4 

" configure neomake/deoplete
silent! call neomake#configure#automake('w')
silent! call neomake#configure#automake('nw', 100)
silent! call neomake#configure#automake('rw', 100)

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#source_importer = 1
let g:deoplete#sources#go#unimported_packages = 1

let g:neomake_go_enabled_makers = ['go', 'golint']
let g:neomake_info_sign = {'text': 'i', 'texthl': 'NeomakeInfoSign'}
let g:neomake_error_sign = {'text': 'e', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': 'w', 'texthl': 'NeomakeWarningSign'}
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_exit = 1

" C-k to select-and-expand a snippet from the deoplete popup (Use C-n and C-p to select it). C-k can also be used to jump to the next field in the snippet.
" Tab to select the next field to fill in the snippet.
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 spell
let g:go_gocode_propose_source = 1
let g:go_gocode_unimported_packages = 1
let g:go_gocode_socket_type = 'unix'
let g:go_template_autocreate = 1
let g:go_decls_mode = 'fzf'
let g:go_term_mode = "split"
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
let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_autosave =  1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_addtags_transform = "snakecase"
let g:go_fmt_command = "goimports"
let g:go_snippet_engine = "neosnippet"
"let g:go_info_mode = 'gocode' " 'guru'
"let g:go_fmt_fail_silently = 1
" let g:go_fmt_options = {'gofmt': '-s'}
let g:go_auto_sameids = 0   " highlight all uses of the identifier under the cursor
" Updatetime in milliseconds
let g:go_updatetime = 250

augroup go
  au!
  au Filetype go nnoremap <leader>gi :GoImport<cr>
  au Filetype go nnoremap <leader>gh :GoDoc<cr>
  au Filetype go inoremap <C-e> <esc>:GoIfErr<cr>
  au Filetype go inoremap <C-j> <esc>:GoAddTags json,omitempty<cr>
  au FileType go nnoremap <leader>dd <Plug>(go-def-vertical)
  au FileType go nnoremap <leader>dv <Plug>(go-doc-vertical)
  au FileType go nnoremap <leader>db <Plug>(go-doc-browser)
  au FileType go nnoremap <leader>r <Plug>(go-run)
  au FileType go nnoremap <leader>gt <Plug>(go-test)
  au FileType go nnoremap <leader>gt <Plug>(go-coverage-toggle)
  au FileType go nnoremap silent <leader>l <Plug>(go-metalinter)
  "au FileType go nmap <C-g> :GoDecls<cr>
  "au FileType go nmap <leader>dr :GoDeclsDir<cr>
  "au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
  "au FileType go imap <C-g>dr <esc>:<C-u>GoDeclsDir<cr>
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
autocmd BufNewFile,BufRead *.ino setlocal ts=4 sw=4 noexpandtab

let g:arduino_dir = "/usr/share/arduino"
