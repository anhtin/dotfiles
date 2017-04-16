# Lines configured by zsh-newuser-install {{{
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd nomatch notify
unsetopt beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install }}}

# The following lines were added by compinstall {{{
zstyle :compinstall filename ${HOME}'/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall }}}

# Environment variables {{{
# Architecture flags
export ARCHFLAGS="-arch x86_64"
export EDITOR="/usr/local/bin/vim"

# Custom {{{
export DEV="$HOME/Development"
export ASSETS="$DOTDIR/assets"
# }}}

# Binary precedence {{{
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# }}}

# Emacs {{{
# pdf-tools
export PKG_CONFIG_PATH=/usr/local/Cellar/zlib/1.2.8/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig
# }}}

# Java {{{
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
# }}}

# LaTeX {{{
export PATH="$PATH:/Library/TeX/texbin"
# }}}

# Golang {{{
export GOPATH="$DEV/Go"
export PATH=$PATH:$GOPATH/bin
# export PATH="$PATH:/usr/local/opt/go/libexec/bin"   # Optional GOROOT
# }}}

# Python {{{
# export PIP_REQUIRE_VIRTUALENV=true        # PIP only in python virtual environment
export WORKON_HOME=${HOME}/.virtualenvs     # Virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"

source /usr/local/bin/virtualenvwrapper.sh

# pyenv shims and autocompletion
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# }}}

# Rust {{{
export PATH="$HOME/.cargo/bin:$PATH"
# }}}

# SQLite {{{
export PATH="/usr/local/opt/sqlite/bin:$PATH"
# }}}

# Yarn {{{
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
# }}}

# }}}

# Aliases {{{
alias zshreset='. ~/.zshrc'

# Haskell {{{
alias ghc='stack ghc'
alias ghci='stack ghci'
alias runghc='stack runghc'
# }}}

# Python {{{
alias py='python3'
alias pip='pip3'
# }}}

# # Neovim {{{
# alias vim='nvim'
# alias vi='command vim'
# # }}}

# }}}

# Shell configuration {{{

# Enable 256-color gruvbox palette (for vim) {{{
source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh"
# }}}

# }}}

# zgen {{{
source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
    zgen prezto utility:ls color 'yes'
    zgen prezto syntax-highlighting color 'yes'
    zgen prezto prompt theme 'pure'

    zgen prezto
    zgen prezto fasd
    zgen prezto utility
    zgen prezto history-substring-search
    zgen prezto syntax-highlighting
    zgen prezto prompt

    zgen load rupa/z
    zgen load chrissicool/zsh-256color
    zgen load zlsun/solarized-man

    zgen save
fi
# }}}

# Zsh options {{{
unsetopt CORRECT        # Disable autocorrect (Did you mean?)
set -o ignoreeof        # Don't let CTRL+D exit shell
# }}}
