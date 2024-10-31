-- plugins/lsp.lua
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'clangd', 'pyright', 'bashls', 'lua_ls' },
})

local lspconfig = require('lspconfig')

-- Setup LSP servers
local servers = { 'clangd', 'pyright', 'bashls', 'lua_ls' }

for _, server in ipairs(servers) do
  lspconfig[server].setup {}
end
