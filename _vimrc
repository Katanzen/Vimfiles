set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"
Plugin 'VundleVim/Vundle.vim'

Plugin 'itchyny/lightline.vim'

Plugin 'scrooloose/nerdtree'

Plugin 'jiangmiao/auto-pairs'

Plugin 'tpope/vim-commentary'

Plugin 'tpope/vim-surround'
"Plugin 'altercation/vim-colors-solarized'

"Plugin 'rafi/awesome-vim-colorschemes'

"Plugin 'mattn/emmet-vim'

"Plugin 'prettier/vim-prettier'

"Plugin 'sudar/vim-arduino-syntax'

Plugin 'junegunn/goyo.vim'

Plugin 'morhetz/gruvbox'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"



"Saving the backup files to another directory
set backupdir=~/vimtmp
"//,.
set directory=~/vimtmp
"//,.


"""Mappings"""
nnoremap ,<space> :noh<CR>

nnoremap <C-T>  <S-^>i//<Esc>

nnoremap <C-S> :w<CR>

map <F11> <Esc>:call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)<CR>

map <F11><F10> <Esc>:call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 1)<CR><Esc>

"Starts the prettier on the current file.
map <C-L> <Esc>:Prettier<CR>



""" Settings """
source $VIMRUNTIME/vimrc_example.vim
set laststatus=2
set number
set rnu
set expandtab
set tabstop=4
set shiftwidth=4
set diffexpr=MyDiff()
set encoding=utf-8
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=l
set guioptions-=L
set lines=50

"No sound
set visualbell


"Makes bash open in the working directory
let $CHERE_INVOKING=1

" Default path for Cygwin 64-bit, change accordingly
set shell=C:\cygwin64\bin\bash.exe

" set shell=\"C:\Program\ Files\Git\git-bash.exe\"\ -f

" Without --login, Cygwin won't mount some directories such as /usr/bin/
set shellcmdflag=--login\ -c

" Default value is (, but bash needs "
set shellxquote=\"

" Paths will use / instead of \
set shellslash

colorscheme gruvbox

function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg1 = substitute(arg1, '!', '\!', 'g')
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg2 = substitute(arg2, '!', '\!', 'g')
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let arg3 = substitute(arg3, '!', '\!', 'g')
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            if empty(&shellxquote)
                let l:shxq_sav = ''
                set shellxquote&
            endif
            let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    let cmd = substitute(cmd, '!', '\!', 'g')
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
    endif
endfunction
