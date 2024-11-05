-- plugins/telescope.lua
local M = {}
local last_searched_folder = ""

-- Telescope setup function
function M.setup()
  require('telescope').setup {
    defaults = {
      find_command = { 
        "rg", 
        "--files", 
        "--color=never", 
        "-g", "!.git/",             -- Ignore `.git` directory
        "-g", "!build",             -- Ignore `build` directory
        "-g", "!__pycache__",       -- Ignore `__pycache__` directory
        "-g", "!node_modules"       -- Ignore `node_modules` directory
      },
    },
  }
end

-- Key mappings for Telescope
M.keys = {
  { 'n', '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
  { 'n', '<leader>fF', '<cmd>Telescope git_files<cr>', desc = 'Find Files' },
  { 'n', '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
  { 'n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent Files' },
  { 'n', '<leader>fd', function()
      local folder = vim.fn.input("Search folder: ", last_searched_folder, "file")
      if folder == "" or vim.loop.fs_stat(folder) then
        last_searched_folder = folder
        require('telescope.builtin').live_grep({ cwd = folder })
      else
        print('Invalid or non-existent folder!')
      end
    end,
    desc = 'Live Grep in Specific Folder'
  },
}

return M