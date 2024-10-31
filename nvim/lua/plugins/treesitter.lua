-- plugins/treesitter.lua
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'lua', 'python', 'bash' },
  highlight = { enable = true },
}
