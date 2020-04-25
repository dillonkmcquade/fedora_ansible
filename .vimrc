"==================================================================================
"                               VIMRC
"=================================================================================

set shortmess+=I "disable startup message
set encoding=UTF-8
set showcmd " Show (partial) command in status line.
set wrap
set showmode
set matchpairs+=<:>
set t_Co=256
set cursorline
set number
set mouse=a
set laststatus=2
set showtabline=2
set expandtab
set autoindent
set colorcolumn=110
set nocompatible
set showmatch
set splitbelow
set splitright
set relativenumber
set columns=80

highlight ColorColumn ctermbg=darkgray

"Turns on syntax highlighting
syntax on

filetype on
filetype plugin on
filetype indent on

"Closes vim if nerdtree buffer is last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"sonph/onehalf plugin
colorscheme onehalfdark

"rainbow brackets plugin
let g:rainbow_active = 1

"Ale integration with lightline
"let g:lightline#extensions#ale#enabled = 1

" Remove newbie crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

"Key mappings
imap jj <Esc>
nmap <Space> :w<CR>
nmap <F6> :NERDTreeToggle<CR>  

autocmd Filetype c setlocal shiftwidth=4 softtabstop=4 cindent
autocmd Filetype python setlocal shiftwidth=4 softtabstop=4

let g:lightline = {}
let g:lightline.colorscheme = 'jellybeans'
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline.active = { 'right': [[ 'lineinfo' ], [ 'percent' ], [ 'filetype' ], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]] }
let g:lightline#ale#indicator_warnings = "Warnings:"
let g:lightline#ale#indicator_errors = "Errors:"
