local M = {}

-- Capabilities for LSP
M.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Key mappings for LSP with descriptions
M.keys = {
  -- LSP Keybindings
  { mode = "n", lhs = "gd", rhs = vim.lsp.buf.definition, desc = "LSP Go to Definition" },
  { mode = "n", lhs = "gD", rhs = vim.lsp.buf.declaration, desc = "LSP Go to Declaration" },
  { mode = "n", lhs = "gr", rhs = vim.lsp.buf.references, desc = "LSP Show References" },
  { mode = "n", lhs = "gi", rhs = vim.lsp.buf.implementation, desc = "LSP Go to Implementation" },
  { mode = "n", lhs = "<C-k>", rhs = vim.lsp.buf.signature_help, desc = "LSP Signature Help" },
  { mode = "n", lhs = "<leader>ca", rhs = vim.lsp.buf.code_action, desc = "LSP Code Action" },

  -- Diagnostic Keybindings
  { mode = "n", lhs = "[d", rhs = vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
  { mode = "n", lhs = "]d", rhs = vim.diagnostic.goto_next, desc = "Next Diagnostic" },
  { mode = "n", lhs = "<leader>dl", rhs = vim.diagnostic.setloclist, desc = "Diagnostic List" },

  -- Clangd-specific Keybindings
  { mode = "n", lhs = "go", rhs = "<cmd>ClangdSwitchSourceHeader<CR>", desc = "LSP Switch Header/Source", ft = "c,cpp" },
  { mode = "n", lhs = "gs", rhs = "<cmd>ClangdShowSymbolInfo<CR>", desc = "LSP Show Symbol Info", ft = "c,cpp" },

  -- Toggle LSP On/Off
  { mode = "n", lhs = "gq", rhs = function()
      local lsp_enabled = true
      return function()
        if lsp_enabled then
          vim.lsp.buf_detach_client(0, vim.lsp.get_client_by_id(1).id) -- Toggle off LSP
          print("LSP detached for this buffer")
        else
          vim.lsp.buf_attach_client(0, vim.lsp.get_client_by_id(1).id) -- Toggle on LSP
          print("LSP re-attached for this buffer")
        end
        lsp_enabled = not lsp_enabled
      end
    end, 
    desc = "Toggle LSP"
  },
}

-- On_attach function to bind keys only for LSP buffers
M.on_attach = function(client, bufnr)
  for _, keymap in ipairs(M.keys) do
    local opts = { buffer = bufnr, desc = keymap.desc, noremap = true, silent = true }
    vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, opts)
  end
end

-- LSP server configurations
M.servers = { 'clangd', 'pyright', 'bashls', 'lua_ls' }

M.setup = function()
  local lspconfig = require('lspconfig')

  for _, server in ipairs(M.servers) do
    local config = {
      capabilities = M.capabilities,
      on_attach = M.on_attach,
    }

    if server == 'clangd' then
      config.cmd = { "clangd", "--header-insertion=never" }  -- Disable auto-includes in C/C++
    end

    lspconfig[server].setup(config)
  end
end

return M
