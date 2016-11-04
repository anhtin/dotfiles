set foldmethod=marker

" The line above sets an option for this file, which is fold method.
" (see :h modelines and :h foldmethod)
" There are many fold methods, but marker is very suited for a vimrc.
" Folds can be dealt with by many a means, but you'll come a long way
" with knowing 'za'. Try it on the fold below!

" Autoinstall vim-plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}

" Plugins {{{
call plug#begin('~/.vim/plugged')

" This is where your plugins go.
" When you search for plugins, find them on github
" and write the name and repository like in the examples.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORSCHEMES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'morhetz/gruvbox'                  " Gruvbox colorscheme

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SUPPORT TOOLS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plug 'Valloric/YouCompleteMe'          " Autocomplete
Plug 'junegunn/vim-easy-align'          " Aligning
Plug 'tpope/vim-commentary'             " Commenting
Plug 'scrooloose/nerdtree'              " File explorer
Plug 'ctrlpvim/ctrlp.vim'               " Fuzzy file finder
Plug 'benmills/vimux'                   " Send commands to tmux pane

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTAX HIGHLIGHTING
Plug 'cypok/vim-sml'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'
Plug 'tshirtman/vim-cython'
"Plug 'digitaltoad/vim-pug'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Settings {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}
                            
call plug#end()
" }}}

" General settings {{{
set nocompatible                " Enable new features
filetype plugin indent on	    " Auto indentation
syntax on                       " Syntax highlighting

set softtabstop=4               " 4 spaces instead of tabs
set tabstop=4
set shiftwidth=4                " Indent 4 spaces at a time
set expandtab                   " Insert spaces when indenting with tabs
set backspace=indent,eol,start  " Allow backspacing of these

set clipboard=unnamed           " System wide clipboard
set showcmd                     " Show current command
set number                      " Line numbering
set splitbelow splitright       " Open new splits below and to the right
set mouse=a                     " Enable mouse mode for all
set timeout                     " Adjust shorter timeout
set timeoutlen=3000             " to counter delays
set ttimeoutlen=100
set colorcolumn=80              " Hightlight coloumn 80
set cursorline                  " Hightlight current line
set background=dark
set hidden                      " Hide buffers (keep history)
set incsearch                   " Enable incremental highlighting on search

" Use gruvbox colorscheme
let g:gruvbox_italics=0             " Disable italics
let g:gruvbox_contrast_dark='hard'  " Make darker
colorscheme gruvbox                 " Set colorscheme
let g:gruvbox_italics=1             " Enable italics 
" }}}

" Syntax highlighting {{{
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0
" }}}

" Powerline {{{
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/
    \plugin/powerline.vim
set laststatus=2
" }}}

" Key bindings {{{
" Set leader key
nnoremap <space> <Nop>
let mapleader = "\<space>"

" Quick reload configuration file
nnoremap <leader>r :source ~/.vimrc<CR>

" Exit insert mode from homerow
inoremap jj <ESC>

" Enable movement to visual lines (line wraps)
nnoremap j gj
nnoremap k gk

" Hotkeys for moving between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>c :call Compile()<CR>
nnoremap <leader>x :call Run()<CR>
" }}}

" Filetype configurations {{{
" autocmd FileType c :source ~/.vim/lang-config/c.vim
" }}}

" Functions {{{
if !exists('g:at_funcs')
    let g:at_funcs = 1

    function Compile()
        if !exists('t:compile_cmd') || empty(t:compile_cmd)
            let t:compile_cmd = input("Compile command: ")
        endif

        if !empty(t:compile_cmd)
            VimuxRunCommand(t:compile_cmd)
        endif
    endfunction

    function Run()
        if !exists('t:run_cmd') || empty(t:run_cmd)
            let t:run_cmd = input("Run command: ")
        endif

        if !empty(t:run_cmd)
            VimuxRunCommand(t:run_cmd)
        endif
    endfunction
endif
" }}}
