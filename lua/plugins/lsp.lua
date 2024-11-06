-- plugins/lsp.lua
local M = {}

-- On_attach function to bind keys only for LSP buffers
M.on_attach = function(client, bufnr)
  for _, keymap in ipairs(M.keys) do
    local opts = { buffer = bufnr, desc = keymap.desc, noremap = true, silent = true }
    vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, opts)
  end
end

-- Key mappings for LSP with descriptions
M.keys = {
  { mode = "n", lhs = "gd", rhs = vim.lsp.buf.definition, desc = "LSP Go to Definition" },
  { mode = "n", lhs = "gD", rhs = vim.lsp.buf.declaration, desc = "LSP Go to Declaration" },
  { mode = "n", lhs = "gr", rhs = vim.lsp.buf.references, desc = "LSP Show References" },
  { mode = "n", lhs = "gi", rhs = vim.lsp.buf.implementation, desc = "LSP Go to Implementation" },
  { mode = "n", lhs = "<C-k>", rhs = vim.lsp.buf.signature_help, desc = "LSP Signature Help" },
  { mode = "n", lhs = "<leader>ca", rhs = vim.lsp.buf.code_action, desc = "LSP Code Action" },
  { mode = "n", lhs = "[d", rhs = vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
  { mode = "n", lhs = "]d", rhs = vim.diagnostic.goto_next, desc = "Next Diagnostic" },
  { mode = "n", lhs = "<leader>dl", rhs = vim.diagnostic.setloclist, desc = "Diagnostic List" },
  { mode = "n", lhs = "go", rhs = "<cmd>ClangdSwitchSourceHeader<CR>", desc = "LSP Switch Header/Source" },
  { mode = "n", lhs = "gs", rhs = "<cmd>ClangdShowSymbolInfo<CR>", desc = "LSP Show Symbol Info" },

  -- Toggle LSP On/Off
  {
    mode = "n",
    lhs = "gq",
    rhs = function()
      local client = vim.lsp.get_client_by_id(1)
      if client and client.attached_buffers[bufnr] then
        vim.lsp.buf_detach_client(bufnr, client.id)
        print("LSP detached for this buffer")
      else
        vim.lsp.buf_attach_client(bufnr, client.id)
        print("LSP re-attached for this buffer")
      end
    end,
    desc = "Toggle LSP",
  },
}

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
