-- plugins/nvim-tree.lua
local M = {}

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