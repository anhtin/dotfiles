# Custom configurations
DOTDIR=$HOME/dotfiles

configs=(
    env.zsh
    alias.zsh
    latex.zsh
    shell.zsh
    virtualenv.zsh
)

for file in ${configs[*]}; do
    source $DOTDIR/custom/$file
done

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
