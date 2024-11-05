-- plugins/nvim-tree.lua
local M = {}

-- Key mappings for Nvim-tree
M.keys = {
  { 'n', '<leader>e', ':NvimTreeToggle<CR>', desc = 'Toggle NvimTree' }
}

-- Nvim-tree setup
function M.setup()
  require('nvim-tree').setup({
    git = {
      enable = false,
    },
    update_focused_file = {
      enable = true,
    },
  })
end

return M