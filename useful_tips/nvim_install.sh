#!/bin/bash

mkdir Dowmloads; cd Downloads
#cmake dependencis
sudo apt install -y ninja-build gettext cmake unzip curl build-essential file ripgrep
#neovim installation
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
#last version nvimpy
python3 -m pip install 'pynvim @ git+https://github.com/neovim/pynvim'
# download and install Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install 20


