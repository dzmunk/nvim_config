-- plugins/lazy.lua
require('lazy').setup({
  -- Nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      require('plugins.cmp').setup()
    end,
  },

  -- Mason setup for LSP manager
  {
    'williamboman/mason.nvim',
    cmd = "Mason",
    build = ":MasonUpdate",
  },

  -- Mason-LSPConfig integration for automatic LSP installation
  {
    'williamboman/mason-lspconfig.nvim',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'pyright', 'bashls', 'lua_ls' },
      })
    end,
  },

  -- LSP Config with the custom configuration module
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require('plugins.lsp').setup()
    end,
  },

  -- WhichKey setup
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
  },

  -- Telescope setup
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    keys = require('plugins.telescope').keys,  
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' 
      }
    },
    config = function()
      require('plugins.telescope').setup()
    end,
  },

  -- Nvim-tree configuration
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = require('plugins.nvim-tree').keys,
    config = function()
      require('plugins.nvim-tree').setup()
    end,
  },

  -- Bufferline setup
  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-tree.lua', 'folke/which-key.nvim' },
    keys = require('plugins.bufferline').keys,
    config = function()
      require('plugins.bufferline').setup()
    end,
  },

  -- Treesitter for syntax highlighting and parsing
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'cpp', 'lua', 'python', 'bash' },
        highlight = { enable = true },
      }
    end,
  },
})
