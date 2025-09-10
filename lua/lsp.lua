vim.lsp.enable({
    'clangd',
    'lua_ls',
    'pyright',
    'ts_ls',
    'bashls',
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp.attach', { clear = true }),
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then return end
        if  client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, bufnr, {
                autotrigger = false,
                convert = function(item)
                    return { abbr = item.label:gsub('%b()', '') }
                end,
            })
        end
        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition,  { buffer = bufnr, silent = true, desc = 'Go to definition' })
        end
        if client:supports_method('textDocument/declaration') then
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, silent = true, desc = 'Go to declaration' })
        end
    end,
})

vim.keymap.set('n', '<leader>dl', function()
    vim.diagnostic.setloclist({ open = true })
end, { desc = 'Open diagnostics location list' })

vim.diagnostic.config({
    underline = true,
    virtual_lines = { current_line = true },
    virtual_text = false,
    update_in_insert = false,
    severity_sort = true,
    float = {
        source = 'if_many',
        focusable = false,
    },
})
