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
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set cindent
set colorcolumn=110
set nocompatible
set showmatch
set splitbelow
set splitright


highlight ColorColumn ctermbg=darkgray

"Turns on syntax highlighting
syntax on

filetype plugin on

"Closes vim if nerdtree buffer is last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"sonph/onehalf plugin
colorscheme onehalfdark

"rainbow brackets plugin
let g:rainbow_active = 1


" Remove newbie crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

"Key mappings
imap jj <Esc>
nmap <Space> :w<CR>
nmap <F6> :NERDTreeToggle<CR>  

