set foldmethod=marker

" Autoinstall vim-plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}

" Plugins {{{
call plug#begin('~/.vim/plugged')

" Colorscheme {{{

" Gruvbox {{{
Plug 'morhetz/gruvbox'              " Gruvbox colorscheme

" Settings
let g:gruvbox_italics=0             " Disable italics
let g:gruvbox_contrast_dark='hard'  " Make darker
let g:gruvbox_italics=1             " Enable italics
" }}}

" }}}

" tpope {{{
Plug 'tpope/vim-commentary'         " Toggle comments
Plug 'tpope/vim-surround'           " Easy quoting, paranthesizing and tagging
" }}}

" vim + tmux integration {{{
Plug 'benmills/vimux'                   " Send commands to tmux pane
Plug 'christoomey/vim-tmux-navigator'   " Integrate tmux and vim panes
" }}}

" airline {{{
Plug 'vim-airline/vim-airline'

" Settings
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
  endif
let g:airline_powerline_fonts=1
let g:airline_detect_paste=1
" let g:airline#extensions#whitespace#enabled=0
" Themes {{{
Plug 'vim-airline/vim-airline-themes'

" Settings
let g:airline_theme='base16_default'
let g:airline_base16_improved_contrast = 1
let g:airline#themes#base16#constant = 1
" }}}
"
" }}}

" Language specifics {{{

" CSS {{{
Plug 'ap/vim-css-color'
" }}}

" Haskell {{{
Plug 'dag/vim2hs'
Plug 'alx741/vim-hindent'

" Settings {{{
let g:haskell_conceal = 0
let g:haskell_quasi = 0
let g:haskell_interpolation = 0
let g:haskell_regex = 0
let g:haskell_jmacro = 0
let g:haskell_shqq = 0
let g:haskell_sql = 0
let g:haskell_json = 0
let g:haskell_xml = 0
let g:haskell_hsp = 0
let g:haskell_tabular = 0

let g:hindent_line_length = 80
" }}}

" }}}

" HTML {{{
Plug 'mattn/emmet-vim'                  " Tag abbreviation expansion

" Settings {{{
let g:user_emmet_install_global = 0     " Don't enable for all files
autocmd FileType html,css,js,javascript.jsx EmmetInstall

" let g:user_emmet_mode='n'               " only enable normal mode functions.
let g:user_emmet_mode='a'               " enable all function in all mode.
" }}}

" }}}

" Javascript {{{
Plug 'pangloss/vim-javascript'

" React {{{
Plug 'mxw/vim-jsx'

" Syntax highlighting
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0
" }}}

" Vue {{{
Plug 'posva/vim-vue'
" }}}

" }}}

" Python {{{
Plug 'hynek/vim-python-pep8-indent'

" Jinja2 {{{
Plug 'Glench/Vim-Jinja2-Syntax'
" }}}

" }}}

" }}}

call plug#end()
" }}}

" Settings {{{
" Standard boilerplate
set nocompatible                " Enable new features
filetype plugin indent on	    " Auto indentation
syntax on                       " Syntax highlighting

" Whitespace
set softtabstop=4               " 4 spaces instead of tabs
set tabstop=4
set shiftwidth=4                " Indent 4 spaces at a time
set expandtab                   " Insert spaces when indenting with tabs
set backspace=indent,eol,start  " Allow backspacing of these

" Visual interface
set number                      " Line numbering
set showcmd                     " Show current command
set cursorline                  " Hightlight current line
set colorcolumn=80              " Hightlight coloumn 80
set laststatus=2                " Show status bar

" Timers
set timeout                     " Adjust shorter timeout
set timeoutlen=3000             " to counter delays
set ttimeoutlen=100

" Interactivity
set hidden                      " Hide buffers (keep history)
set mouse=a                     " Mouse mode for all
set incsearch                   " Incremental highlighting on search
set splitbelow splitright       " Open new splits below and to the right
set clipboard=unnamed           " System-wide clipboard
set wildmenu
set wildmode=full,full

" Filepaths {{{
set path+=**                        " Enable recursive file search
set wildignore+=*/node_modules/*    " Exclude node modules

" Store all swapfiles in one place {{{
let s:swapdir = expand('~/.vim/swaps')
if !isdirectory(s:swapdir)
    call mkdir(s:swapdir, 'p')
endif
execute 'set directory=' . s:swapdir . '//'
" }}}

" }}}

" Colorscheme
set background=dark
colorscheme gruvbox
" }}}

" Auto commands {{{
au FileType * setlocal formatoptions-=o     " Disable auto-comment on o/O
augroup Web
    au FileType html,json,javascript,vue setlocal
                \ shiftwidth=2
                \ tabstop=2
                \ softtabstop=2
augroup END
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
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Hotkeys for moving between buffers
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
" }}}
