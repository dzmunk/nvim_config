-- plugins/lsp.lua
local M = {}

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

  -- Load cmp_nvim_lsp here, after Lazy.nvim has loaded dependencies
  local cmp_lsp = require('cmp_nvim_lsp')

  -- Capabilities for LSP with cmp_nvim_lsp integration
  M.capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

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
