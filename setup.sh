function install_brew() {
  if [[ ! -f "/opt/homebrew/bin/brew" ]]; then
    echo "Installing Brew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi  
}

install_brew
