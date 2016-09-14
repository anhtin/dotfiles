export ARCHFLAGS="-arch x86_64"     # Architecture flags
export PATH="/usr/local/bin:$PATH"  # User-installed binaries takes precedence

# Variables {{{
export DEV="${HOME}/Development"
# }}}

# Aliases {{{
alias zshreset='. ~/.zshrc'
alias py='python'
alias py3='python3'
alias trans='transmission-remote'
# }}}

# zsh config {{{

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

# }}}

# Applications {{{

# Python virtualenv {{{
export PIP_REQUIRE_VIRTUALENV=true      # PIP only in python virtual environment
export WORKON_HOME=${HOME}/.virtualenvs # Virtualenvwrapper

source /usr/local/bin/virtualenvwrapper.sh
# }}}

# GO {{{
export GOPATH=${HOME}/Development/Go                # Go workspace path
export PATH=${PATH}:${GOPATH}/bin                       # Add go binaries to PATH
#export PATH=$PATH:/usr/local/opt/go/libexec/bin    # Go binary location
# }}}

# LaTeX {{{
export PATH="$PATH:/Library/TeX/texbin"
# }}}

# }}}

# User config {{{

# User-created binaries {{{
export PATH="${PATH}:${DEV}/bash/bin"
# }}}

# Type completion {{{
zmodload zsh/complist
autoload -U compinit
compinit -u
autoload bashcompinit
bashcompinit
zstyle ':completion:*' show-ambiguity true

autoload -U colors
colors
zstyle ':completion:*' show-ambiguity "1;2;$color[fg-red]"

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down 

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
# }}}

# Base16 Shell {{{
BASE16_SHELL="${HOME}/.base16-seti.dark.sh"
[[ -e "${BASE16_SHELL}" ]] && source ${BASE16_SHELL}
# }}}

# zgen {{{
source ${HOME}/.zgen/zgen.zsh

if ! zgen saved; then
  zgen oh-my-zsh

  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/fasd
  zgen oh-my-zsh plugins/pip

  zgen load zsh-users/zsh-completions src
  zgen load zsh-users/zsh-history-substring-search
  zgen oh-my-zsh plugins/vi-mode
  #zgen load command-not-found
  #zgen load autoenv

  #zgen load Lokaltog/powerline
  zgen oh-my-zsh plugins/colored-man-pages
  zgen load chrissicool/zsh-256color
  # zgen oh-my-zsh themes/robbyrussell
  zgen load anhtin/prompt prompt

  # Must be after plugins and compinit
  zgen load zsh-users/zsh-syntax-highlighting


  zgen save
fi
# }}}

# General configurations {{{

# Enable 256-color gruvbox palette
source "${HOME}/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh"

# pyenv shims and autocompletion
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# }}}

# }}}

# Functions {{{
# Run pip globally
gpip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
# }}}
