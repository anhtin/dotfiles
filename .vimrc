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
Plug 'nanotech/jellybeans.vim'          " Jellybeans colorscheme
Plug 'morhetz/gruvbox'                  " Gruvbox colorscheme

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SUPPORT TOOLS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plug 'Valloric/YouCompleteMe'           " Autocomplete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTAX HIGHLIGHTING
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'
"Plug 'digitaltoad/vim-pug'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                            
call plug#end()
" }}}

" General settings {{{
set nocompatible                " enable new features
filetype plugin indent on	    " auto indentation
syntax on                       " syntax highlighting

set softtabstop=4               " 4 spaces instead of tabs
set tabstop=4
set shiftwidth=4                " indent 4 spaces at a time
set expandtab                   " insert spaces when indenting with tabs
set backspace=indent,eol,start  " Allow backspacing of these

set clipboard=unnamed           " System wide clipboard
set showcmd                     " show current command
set number                      " line numbering
set splitbelow splitright       " Open new splits below and to the right
set mouse=a                     " enable mouse mode for all
set timeout                     " Adjust shorter timeout
set timeoutlen=3000             " to counter delays
set ttimeoutlen=100
set cc=80                       " Hightlight coloumn 80
set background=dark

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

" YCM {{{
" Not using YCM anymore
"let g:ycm_collect_identifiers_from_tags_files = 1   " Read tags from Ctags file
"let g:ycm_use_ultisnips_completer = 1               " Default 1, just ensure
"let g:ycm_seed_identifiers_with_syntax = 1          " Completion for keyword
"let g:ycm_complete_in_comments = 1                  " Completion in comments
"let g:ycm_complete_in_strings = 1                   " Completion in string
"let g:ycm_confirm_extra_conf = 0                    " Ignore confirmation message
" }}}

" Filetype configurations {{{
autocmd FileType c :source ~/.vim/lang-config/c.vim
" }}}
