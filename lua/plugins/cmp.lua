-- plugins/cmp.lua
local cmp = require('cmp')

-- Setup nvim-cmp
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Accept currently selected item
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },      -- LSP source
    { name = 'buffer' },        -- Buffer source
    { name = 'path' },          -- Path source
  })
})

-- Setup completion for command-line mode
cmp.setup.cmdline(':', {
  sources = {
    { name = 'path' },          -- Path completion for command-line
    { name = 'cmdline' },       -- Command-line completion
  }
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },        -- Buffer completion for search
  }
})
