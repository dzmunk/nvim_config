-- plugins/lazy.lua
require('lazy').setup({
  -- Mason setup for managing LSP servers and external tools
  {
    'williamboman/mason.nvim',
    cmd = "Mason",
    build = ":MasonUpdate",  -- Automatically update Mason on install/update
  },

  -- Nvim-cmp for auto-completion setup
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",    -- Buffer source for nvim-cmp
      "hrsh7th/cmp-path",      -- Path source for nvim-cmp
    },
    config = function()
      require('plugins.cmp').setup()
    end,
  },

  -- WhichKey setup for displaying key mappings
  {
    'folke/which-key.nvim',
    event = "VeryLazy",  -- Load lazily to optimize startup
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

  -- LSP Config with custom configuration for LSP servers
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys = require('plugins.lsp').keys,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require('plugins.lsp').setup()
    end,
  },

  -- Treesitter for syntax highlighting and parsing
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',  -- Update Treesitter parsers
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'cpp', 'lua', 'python', 'bash' },
        highlight = { enable = true },
      }
    end,
  },

  -- Nvim-tree for file navigation
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = require('plugins.nvim-tree').keys,
    config = function()
      require('plugins.nvim-tree').setup()
    end,
  },

  -- Bufferline setup for buffer management
  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-tree.lua', 'folke/which-key.nvim' },
    keys = require('plugins.bufferline').keys,
    config = function()
      require('plugins.bufferline').setup()
    end,
  },

  -- Telescope setup for fuzzy finding
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    keys = require('plugins.telescope').keys,  
    dependencies = {
      'nvim-lua/plenary.nvim',  -- Essential Lua functions for Telescope
      {
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' 
      }
    },
    config = function()
      require('plugins.telescope').setup()
    end,
  },
})
