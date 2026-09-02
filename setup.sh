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

function lua() {
  mkdir -p ~/Documents/repositories/lua/
  mkdir -p ~/Documents/repositories/luarocks/

  pushd ~/Documents/repositories/lua/

  wget https://www.lua.org/ftp/lua-5.1.5.tar.gz
  tar xzf lua-5.1.5.tar.gz
  cd lua-5.1.5
  make macosx

  mkdir /opt/lua/
  mkdir -p ~/.local/bin

  make INSTALL_TOP=/opt/lua install
  ln -s /opt/lua/bin/lua ~/.local/bin/lua
  popd
}

install_brew
tmux_tpm
stow .
lua


