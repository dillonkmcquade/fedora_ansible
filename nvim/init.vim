"=================================================================================
"                               VIMRC
"=================================================================================
"
" set viminfo location
if !has('nvim') | set viminfofile=$XDG_STATE_HOME/vim/viminfo | endif

"automate plugin setup on new host
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
        silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/colors
        silent !curl "https://raw.githubusercontent.com/sonph/onehalf/master/vim/colors/onehalfdark.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/colors/onehalfdark.vim
	autocmd VimEnter * PlugInstall
endif

"Basic Settings
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
set laststatus=3
set title
set showtabline=1
set expandtab
set autoindent
set nocompatible
set showmatch
set wildmode=longest:list,full
set wildmenu
set splitbelow
set splitright
set relativenumber
syntax on
filetype on
filetype plugin on
filetype indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
autocmd Filetype c setlocal cindent
"plugin manager
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'alvan/vim-closetag'
Plug 'PhilRunninger/nerdtree-buffer-ops'
call plug#end()

"Key mappings
nmap <Space> :w<CR>

"NERDTree 
"---------------
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"map tab to toggle nerdtree
noremap <TAB> :NERDTreeToggle<CR>  

"sonph/onehalf plugin
colorscheme onehalfdark

"remove highlighting everywhere
let g:ale_set_highlights = 0

"Ale settings
let g:ale_fixers = {
                  \ 'javascript': ['prettier', 'eslint'],
                  \ 'scss': ['prettier', 'eslint'],
                  \ 'javascriptreact': ['prettier', 'eslint']}
let g:ale_linters= {
                  \ 'javascript': ['eslint']}
let g:ale_fix_on_save = 1

let g:lightline#extensions#ale#enabled = 1 ""lightline ale extension 

"rainbow brackets plugin
let g:rainbow_active = 1

"closetag file types
let g:closetag_filenames = "*.html,*.xhtml,*.js,*.jsx,*.xml"

" Remove newbie crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap j gj
nnoremap k gk
nnoremap ; :



"---------------------Status Line ---------------------------------    
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)

endfunction
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null |tr -d '\n'")
endfunction
function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?' '.l:branchname.' ':''
endfunction

set statusline=%<%1*\ %t\ %*\ %h%m%r\ %{StatuslineGit()}%=%-5.{LinterStatus()\ }\ %-14.(%l,%c%V%)\ %P
hi StatusLine ctermfg=103 ctermbg=236
hi TabLine ctermfg=103 ctermbg=236 
hi TabLineSel ctermfg=236 ctermbg=103
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=103 ctermbg=232


"------------------------------------------------------------------


"Lightline settings and ALE integration
let g:lightline = {
                  \ 'colorscheme': 'jellybeans',
                  \ 'active': {
                  \     'right': [[ 'lineinfo' ], [ 'percent' ], [ 'filetype' ], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]],
                  \     'left': [[  'mode', 'paste'], ['readonly', 'filename'], ['modified', 'gitbranch' ]],
                  \},
                  \ 'component_function': {
                  \     'gitbranch': 'FugitiveHead',
                  \},
                  \}
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
let g:lightline#ale#indicator_warnings = "Warnings:"
let g:lightline#ale#indicator_errors = "Errors:"

