-- plugins/nvim-tree.lua
local M = {}

-- Nvim-tree setup
function M.setup()
  require('nvim-tree').setup({
    git = {
      enable = false,
    },
    sync_root_with_cwd = true,
    disable_netrw = true,
    hijack_cursor = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
  })
end

return M
