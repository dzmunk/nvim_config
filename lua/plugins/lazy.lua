local last_searched_folder = ""

-- plugins/lazy.lua
require('lazy').setup({
  -- Mason setup for managing LSP servers and external tools
  {
    'williamboman/mason.nvim',
    cmd = "Mason",
    build = function()
      -- Explicitly load Mason before running MasonUpdate
      require("mason")
      if vim.fn.exists(":MasonUpdate") == 2 then
        vim.cmd("MasonUpdate")
      end
    end,
    config = function()
      require("mason").setup()  -- Setup Mason
    end,
  },

  -- Mason-LSPConfig integration for automatic LSP installation
  {
    'williamboman/mason-lspconfig.nvim',
    event = { "BufReadPost", "BufNewFile" },
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
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "gd", vim.lsp.buf.definition, desc = "LSP Go to Definition", mode = "n" },
      { "gD", vim.lsp.buf.declaration, desc = "LSP Go to Declaration", mode = "n" },
      { "gr", vim.lsp.buf.references, desc = "LSP Show References", mode = "n" },
      { "gi", vim.lsp.buf.implementation, desc = "LSP Go to Implementation", mode = "n" },
      { "<C-k>", vim.lsp.buf.signature_help, desc = "LSP Signature Help", mode = "n" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "LSP Code Action", mode = "n" },
      { "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic", mode = "n" },
      { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic", mode = "n" },
      { "<leader>dl", vim.diagnostic.setloclist, desc = "Diagnostic List", mode = "n" },
      { "go", "<cmd>ClangdSwitchSourceHeader<CR>", desc = "LSP Switch Header/Source", mode = "n" },
      { "gs", "<cmd>ClangdShowSymbolInfo<CR>", desc = "LSP Show Symbol Info", mode = "n" },

      -- Toggle LSP On/Off
      {
        "gq",
        function()
          local client = vim.lsp.get_client_by_id(1)
          local bufnr = vim.api.nvim_get_current_buf()
          if client and client.attached_buffers[bufnr] then
            vim.lsp.buf_detach_client(bufnr, client.id)
            print("LSP detached for this buffer")
          else
            vim.lsp.buf_attach_client(bufnr, client.id)
            print("LSP re-attached for this buffer")
          end
        end,
        desc = "Toggle LSP",
        mode = "n",
      },
    },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP source for nvim-cmp
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require('plugins.lsp').setup()
    end,
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
    event = "VeryLazy",  -- Load which-key.nvim lazily to optimize startup
    config = function()
      require("which-key").setup()
    end,
  },

  -- Treesitter for syntax highlighting and parsing
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',  -- Update Treesitter parsers
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
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
    keys = {
      { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree", mode = "n" },
    },
    config = function()
      require('plugins.nvim-tree').setup()
    end,
  },

  -- Bufferline setup for buffer management
  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    keys = {
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<leader>ax", "<cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      { "<leader>x", function() require("bufferline").close_command(vim.api.nvim_get_current_buf()) end, desc = "Close Current Buffer" },
    },
    config = function()
      require('plugins.bufferline').setup()
    end,
  },

  -- Telescope setup for fuzzy finding
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files", mode = "n" },
      {
        "<leader>fF",
        function()
          local builtin = require("telescope.builtin")
          local success = pcall(builtin.git_files)
          if not success then
            builtin.find_files()
          end
        end,
        desc = "Find Git Files",
        mode = "n",
      },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", mode = "n" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files", mode = "n" },
      {
        "<leader>fd",
        function()
          local folder = vim.fn.input("Search folder: ", last_searched_folder, "file")
          if folder == "" or vim.loop.fs_stat(folder) then
            last_searched_folder = folder
            require('telescope.builtin').live_grep({ cwd = folder })
          else
            print("Invalid or non-existent folder!")
          end
        end,
        desc = "Live Grep in Specific Folder",
        mode = "n",
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',  -- Essential Lua functions for Telescope
      {
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' 
      }
    },
    config = function()
      require('plugins.telescope').setup()
      require('telescope').load_extension('fzf')
    end,
  },
})
