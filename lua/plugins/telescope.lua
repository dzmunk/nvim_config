-- plugins/telescope.lua
local M = {}

-- Telescope setup function
function M.setup()
  require('telescope').setup {
    defaults = {
      -- Set `rg` as the command for `live_grep`
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",  -- Enables case-insensitive search if no uppercase letters in search term
        "-g", "!.git/",             -- Ignore `.git` directory
        "-g", "!build",             -- Ignore `build` directory
        "-g", "!__pycache__",       -- Ignore `__pycache__` directory
        "-g", "!node_modules"       -- Ignore `node_modules` directory
      },
      -- Set `rg` as the command for `find_files`
      find_command = { 
        "rg", 
        "--files", 
        "--color=never", 
        "-g", "!.git/",             
        "-g", "!build",             
        "-g", "!__pycache__",       
        "-g", "!node_modules"       
      },
    },
  }
end

return M