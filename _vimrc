set nocompatible              " be iMproved, required
syntax on
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
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

Plugin 'junegunn/goyo.vim'

Plugin 'morhetz/gruvbox'

Plugin 'sickill/vim-monokai'

Plugin 'mattn/calendar-vim'

Plugin 'raingo/vim-matlab'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" All of your Plugins must be added before the following line
call vundle#end()            " required

"filetype plugin indent on    " required
"" To ignore plugin indent changes, instead use:
""filetype plugin on
""
"" Brief help
"" :PluginList       - lists configured plugins
"" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
"" :PluginSearch foo - searches for foo; append `!` to refresh local cache
"" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
""
"" see :h vundle for more details or wiki for FAQ
"" Put your non-Plugin stuff after this line
""
"
"
""""Mappings""
command! -nargs=1 Scur vimgrep "<args>" " **"

command Vtb vertical botright terminal

command! Date call Date()
nnoremap ,<C-D> :Date<CR> 

map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar>cw<CR>

nnoremap ,<space> :noh<CR>

nnoremap <silent> <C-S> :w<CR>

nnoremap <c-I> <Esc><c-^>

map <F11> <Esc>:call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)<CR>

map <F11><F10> <Esc>:call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 1)<CR><Esc>
"
"
"
""Easier navigation.
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
"
let g:VimTodoListsDatesEnabled = 1
"
""" Settings """
""Saving the backup files to another directory
set backupdir=~/vimtmp
set directory=~/vimtmp
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
"set lines=70
language english
colorscheme gruvbox
set visualbell "no sound"
"
"
"
"
"Makes bash open in the working directory
" let $CHERE_INVOKING=1
"
" Default path for Cygwin 64-bit, change accordingly
 " set shell=\"C:\msys64\msys2.exe\"\
 " set shell=C:\Dev\cmder_mini\Cmder.exe
"
" set shell=\"C:\Program\ Files\Git\git-bash.exe\"\ -f
"
"" Without --login, Cygwin won't mount some directories such as /usr/bin/
 " set shellcmdflag=--login\ -c
"
" Default value is (, but bash needs "
 " set shellxquote=\"
"
" Paths will use / instead of \
 " set shellslash
"
"
"
"My functions
"
function Date()
    if(&filetype ==# "markdown")
      :read !date
      :exe "normal I#"
    endif


endfunction

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
