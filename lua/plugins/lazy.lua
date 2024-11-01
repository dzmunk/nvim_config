-- plugins/lazy.lua
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable', -- latest stable release
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Mason for LSP management
  { 'williamboman/mason.nvim', config = true },
  { 'williamboman/mason-lspconfig.nvim', config = true },

  -- LSP Config
  'neovim/nvim-lspconfig',

  -- WhichKey
  { 'folke/which-key.nvim' },

  -- Telescope
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Nvim-tree
  { 'nvim-tree/nvim-tree.lua' },

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },

  -- Nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
  },

})
