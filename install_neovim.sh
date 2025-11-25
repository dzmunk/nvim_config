#!/usr/bin/env bash

# Usage:
#   chmod +x install_neovim.sh
#   ./install_neovim.sh
#   ./install_neovim.sh --uninstall

set -euo pipefail

DIR="$HOME/neovim"

if [ "${1:-}" = "--uninstall" ]; then
  cd "$DIR"
  sudo make uninstall
  exit 0
fi

if [ -d "$DIR/.git" ]; then
  git -C "$DIR" fetch --tags --force
else
  mkdir -p "$(dirname "$DIR")"
  git clone https://github.com/neovim/neovim.git "$DIR"
fi

git -C "$DIR" -c advice.detachedHead=false checkout -f nightly
git -C "$DIR" reset --hard nightly

cd "$DIR"
make distclean || true
make CMAKE_BUILD_TYPE=Release
sudo make install

nvim --version | head -n 3
