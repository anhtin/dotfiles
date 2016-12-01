# Base16 Shell
BASE16_SHELL="$ASSETS/base16-seti.dark.sh"
[[ -e "$BASE16_SHELL" ]] && source $BASE16_SHELL

# Enable 256-color gruvbox palette (for vim)
source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh"

# ZSH options
setopt nocorrectall     # Disable autocorrect (Did you mean?)
