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

return M
