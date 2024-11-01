-- plugins/telescope.lua
local telescope = require('telescope')
telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--fixed-strings'
    },
    file_ignore_patterns = { "node_modules", ".git/", "build", "__pycache__" },
  },
}

-- Keybindings for Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })

vim.keymap.set('n', '<leader>fd', function()
  local folder = vim.fn.input("Search folder: ", "", "file")
  if folder == "" or vim.loop.fs_stat(folder) then
    require('telescope.builtin').live_grep({ cwd = folder })
  else
    print("Invalid or non-existent folder!")
  end
end, { desc = 'Live Grep in Specific Folder' })
