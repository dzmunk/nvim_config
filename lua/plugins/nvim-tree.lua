-- plugins/nvim-tree.lua
require('nvim-tree').setup({
  git = {
    enable = false,
  },
})

-- Keybinding to toggle Nvim-tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })

