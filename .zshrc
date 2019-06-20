
# The following lines were added by compinstall {{{
zstyle :compinstall filename ${HOME}'/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall }}}

# Environment variables {{{
export LANG="en_US.UTF-8"

# Architecture flags
export ARCHFLAGS="-arch x86_64"
export EDITOR="/usr/local/bin/vim"

export PATH="$HOME/.fastlane/bin:$PATH"

# Custom {{{
export DEV="$HOME/Development"
export DOTDIR="$HOME/dotfiles"
# }}}

# Binary precedence {{{
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# }}}

# Emerald {{{
export EMERALDROOT="$HOME/Downloads/emerald"
export EMERALDARCH="$(arch)"
# }}}

# Java {{{
export JAVA_HOME="$(/usr/libexec/java_home -v 10)"
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
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh

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
alias zshreset='source ~/.zshrc'
alias sct='vim ~/.scratch/scratch -c "cd ~/.scratch"'

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

# Zsh options {{{
unsetopt CORRECT        # Disable autocorrect (Did you mean?)
set -o ignoreeof        # Don't let CTRL+D exit shell
# }}}

# Key bindings {{{
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
# }}}

# zim {{{
# User configuration sourced by interactive shells
#

# Change default zim location 
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Source zim
if [[ -s ${ZIM_HOME}/init.zsh ]]; then
  source ${ZIM_HOME}/init.zsh
fi
# }}}

# fzf {{{
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--reverse --border"
# }}}

# z {{{
. /usr/local/etc/profile.d/z.sh
# }}}

# Options {{{
unsetopt share_history
# }}}
