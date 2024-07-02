if status is-interactive
  and not set -q TMUX
    exec tmux
end

starship init fish | source

# pnpm
set -gx PNPM_HOME "/Users/waldorf/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
set -gx PATH /usr/local/bin $PATH

thefuck --alias | source

# Alias for Neovim
alias v='nvim'

# Remove fish welcome message

set fish_greeting

#Zoxide aliases

fzf --fish | source
zoxide init fish | source

neofetch
