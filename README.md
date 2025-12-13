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

winget install -e --id junegunn.fzf

winget install -e --id Neovim.Neovim.Nightly

git clone https://github.com/dzmunk/nvim_config.git C:\Users\{YOUR_USER}\AppData\Local\nvim

In windows terminal settings json include the following:
{
    "actions": 
    [
        {
            "command": 
            {
                "action": "sendInput",
                "input": "\u001b[104;5u"
            },
            "id": "User.CtrlH.CSIu"
        }
    ],
    "keybindings": 
    [
        {
            "id": "User.CtrlH.CSIu",
            "keys": "ctrl+h"
        },
        {
            "id": "Terminal.FindText",
            "keys": "ctrl+shift+f"
        },
        {
            "id": "Terminal.CopyToClipboard",
            "keys": "ctrl+shift+c"
        },
        {
            "id": "Terminal.PasteFromClipboard",
            "keys": "ctrl+shift+v"
        },
        {
            "id": "Terminal.DuplicatePaneAuto",
            "keys": "alt+shift+d"
        }
    ],
    "profiles": 
    {
        "defaults": 
        {
            "font": 
            {
                "face": "JetBrainsMonoNL Nerd Font"
            },
            "padding": "0, 0, 0, 0",
            "scrollbarState": "hidden"
        },
    }
}
