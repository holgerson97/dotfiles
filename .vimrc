set splitbelow
set splitright
set number
set encoding=utf-8

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Flagging Unnecessary Whitespaces
au BufRead,BufNewFile *.py,*.pyw,*.yml,*.yaml match BadWhitespace /\s\+$/

" Python intendation
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

let python_highlight_all=1
syntax on

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" YAML intendation
au BufNewFile,BufRead *.yml,*.yaml
    \ set expandtab
    \ set tabstop=2
    \ set shiftwidth=2
    \ set autoindent


set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Python autocomplete
" need: https://github.com/ycm-core/YouCompleteMe#mac-os-x-super-quick-installation
Bundle 'Valloric/YouCompleteMe'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)



" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
