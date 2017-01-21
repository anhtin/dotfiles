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
    
# zgen {{{
source "${HOME}/.zgen/zgen.zsh"

# load zgen
if ! zgen saved; then
    # prezto options
    zgen prezto editor key-bindings 'vi'
    zgen prezto utility:ls color 'yes'
    zgen prezto prompt theme 'sorin'
    zgen prezto syntax-highlighting color 'yes'

    # prezto and modules
    zgen prezto
    zgen prezto editor
    zgen prezto utility
    [[ "$ZGEN_SYNTAX_HIGHLIGHTING" == "yes" ]] \
        && zgen prezto syntax-highlighting
    zgen prezto history-substring-search
    zgen prezto fasd
    zgen prezto git
    zgen prezto syntax-highlighting
    zgen prezto prompt

    # other plugins
    zgen load chrissicool/zsh-256color
    zgen load zlsun/solarized-man
    zgen load rupa/z

    # generate the init script from plugins above
    zgen save
fi
# }}}

# Custom configurations
DOTDIR="$HOME/dotfiles"

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
