# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light joshskidmore/zsh-fzf-history-search

# Load completions
autoload -Uz compinit && compinit

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

alias tailscale="/Applications/Tailscale.localized/Tailscale.app/Contents/MacOS/Tailscale"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/nilscarstensen/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nilscarstensen/Downloads/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/nilscarstensen/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nilscarstensen/Downloads/google-cloud-sdk/completion.zsh.inc'; fi


[ -f ~/.variables ] && source ~/.variables
[ -f ~/.aliasrc ] && source ~/.aliasrc
[ -f ~/.config/.tmux_sessionrc ] && source ~/.config/.tmux_sessionrc
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"

[[ -s "/Users/nilscarstensen/.gvm/scripts/gvm" ]] && source "/Users/nilscarstensen/.gvm/scripts/gvm"
