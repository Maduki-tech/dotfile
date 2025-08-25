# base config for oh my zsh
source /usr/share/oh-my-zsh/zshrc
eval "$(starship init zsh)"

#p10k instant prompt to make terminal open a bit snappier
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# user-defined overrides
# [ -d ~/.config/zsh/config.d/ ] && source <(cat ~/.config/zsh/config.d/*)

# Fix for foot terminfo not installed on most servers
alias ssh="TERM=xterm-256color ssh"
alias vi='nvim'
export STARSHIP_CONFIG=~/.config/starship/starship.toml

source ~/.config/user-dirs.dirs

source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
