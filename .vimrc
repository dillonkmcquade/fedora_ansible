call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'frazrepo/vim-rainbow'
Plug 'itchyny/lightline.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/' }
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
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
"
syntax on
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
colorscheme onehalfdark
let g:lightline_theme = 'onehalfdark'
nmap <F6> :NERDTreeToggle<CR>
let g:rainbow_active = 1
