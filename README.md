# nvim_config

Ubuntu:

rm -rf ~/.config/nvim

rm -rf ~/.local/state/nvim

rm -rf ~/.local/share/nvim

chmod +x install_neovim.sh
./install_neovim.sh

sudo apt install npm ripgrep fzf fd-find pip

git clone https://github.com/dzmunk/nvim_config.git ~/.config/nvim


Windows:

winget install -e --id BurntSushi.ripgrep.MSVC

winget install -e --id sharkdp.fd

winget install -e --id Neovim.Neovim.Nightly

git clone https://github.com/dzmunk/nvim_config.git C:\Users\{YOUR_USER}\AppData\Local\nvim
