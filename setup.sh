function install_brew() {
  if [[ ! -f /opt/homebrew/bin/brew ]]; then
    echo "Installing Brew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi  
}

function tmux_tpm() {
  if [[ ! -f ~/.config/tmux/plugins/tpm/tpm ]]; then
    echo "Installing tmux plugin manger ..."
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
  fi
}

install_brew
tmux_tpm
