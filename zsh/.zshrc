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

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light joshskidmore/zsh-fzf-history-search

# Load completions
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

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

[ -f ~/.config/.variables ] && source ~/.config/.variables
[ -f ~/.config/.aliasrc ] && source ~/.config/.aliasrc
[ -f ~/.config/.tmux_sessionrc ] && source ~/.config/.tmux_sessionrc

export PATH=$PATH:$GOPATH/bin
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/bin/tailscale
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Use GNU Sed instead of the MacOS preinstalled
export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

source <(fzf --zsh)

notify_via_ntfy() {
    local exit_status=$?  # Capture the exit status before doing anything else
    local status_icon="$([ $exit_status -eq 0 ] && echo magic_wand || echo warning)"
    local last_command=$(history | tail -n1 | sed -e 's/^[[:space:]]*[0-9]\{1,\}[[:space:]]*//' -e 's/[;&|][[:space:]]*alert$//')

    curl -s -X POST "https://$NTFY" \
        -H "Title: Terminal" \
        -H "X-Priority: 3" \
        -H "Tags: $status_icon" \
        -d "Command: $last_command (Exit: $exit_status)"

    echo "Tags: $status_icon"
    echo "$last_command (Exit: $exit_status)"
}

# Add an "alert" alias for long running commands using ntfy.sh
alias alert='notify_via_ntfy'

export PATH="$(brew --prefix)/opt/curl/bin:$PATH"
export GPG_TTY=$(TTY)
<<<<<<< HEAD
=======
source ~/.aliasrc
>>>>>>> 3a3a0ac (stowing)
