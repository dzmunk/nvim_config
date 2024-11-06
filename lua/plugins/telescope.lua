-- plugins/telescope.lua
local M = {}
local last_searched_folder = ""  -- Store the last searched folder for reuse

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
  { mode = "n", lhs = "<leader>ff", rhs = "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  { mode = "n", lhs = "<leader>fF", rhs = "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
  { mode = "n", lhs = "<leader>fg", rhs = "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  { mode = "n", lhs = "<leader>fr", rhs = "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
  {
    mode = "n",
    lhs = "<leader>fd",
    rhs = function()
      local folder = vim.fn.input("Search folder: ", last_searched_folder, "file")
      if folder == "" or vim.loop.fs_stat(folder) then
        last_searched_folder = folder
        require('telescope.builtin').live_grep({ cwd = folder })
      else
        print("Invalid or non-existent folder!")
      end
    end,
    desc = "Live Grep in Specific Folder"
  },
}

return M
