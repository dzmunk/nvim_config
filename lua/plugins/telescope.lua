-- plugins/telescope.lua
local telescope = require('telescope')
telescope.setup {
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/" },
  },
}

-- Keybindings for Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
