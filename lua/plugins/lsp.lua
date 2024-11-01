-- plugins/lsp.lua
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'clangd', 'pyright', 'bashls', 'lua_ls' },
})

local lspconfig = require('lspconfig')
local cmp_lsp = require('cmp_nvim_lsp')

-- Enhanced capabilities for nvim-cmp support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_lsp.default_capabilities(capabilities)

-- Define a function to set buffer-local options with descriptions
local on_attach = function(client, bufnr)
  local map = vim.keymap.set

  -- Helper function for setting buffer-local options and descriptions
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc, noremap = true, silent = true }
  end

  -- LSP keybindings with descriptions
  map('n', 'gd', vim.lsp.buf.definition, opts('Go to Definition'))
  map('n', 'gD', vim.lsp.buf.declaration, opts('Go to Declaration'))
  map('n', 'gr', vim.lsp.buf.references, opts('Show References'))
  map('n', 'gi', vim.lsp.buf.implementation, opts('Go to Implementation'))
  map('n', '<C-k>', vim.lsp.buf.signature_help, opts('Signature Help'))
  map('n', '<leader>ca', vim.lsp.buf.code_action, opts('Code Action'))

  -- Diagnostic keybindings with descriptions
  map('n', '[d', vim.diagnostic.goto_prev, opts('Previous Diagnostic'))
  map('n', ']d', vim.diagnostic.goto_next, opts('Next Diagnostic'))
  map('n', '<leader>dl', vim.diagnostic.setloclist, opts('Diagnostic List'))

  if client.name == 'clangd' then
    map('n', 'go', '<cmd>ClangdSwitchSourceHeader<CR>', opts('Switch Header/Source'))
  end
end


-- Setup LSP servers
local servers = { 'clangd', 'pyright', 'bashls', 'lua_ls' }

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end
