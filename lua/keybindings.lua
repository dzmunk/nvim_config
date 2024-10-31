-- keybindings.lua
vim.g.mapleader = ' '  -- Set leader key to space

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Basic keybindings
map('n', '<leader>w', ':w<CR>', opts)  -- Save
map('n', '<leader>q', ':q<CR>', opts)  -- Quit

-- Better window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)
