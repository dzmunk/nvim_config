local function switch_source_header(bufnr, client)
    local params = vim.lsp.util.make_text_document_params(bufnr)
    client:request('textDocument/switchSourceHeader', params, function(err, result)
        if err then
            error(tostring(err))
        end
        if not result then
            vim.notify('corresponding file cannot be determined')
            return
        end
        vim.cmd.edit(vim.uri_to_fname(result))
    end, bufnr)
end

local function symbol_info(bufnr, client)
    local win = vim.api.nvim_get_current_win()
    local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
    client:request('textDocument/symbolInfo', params, function(err, res)
        if err or #res == 0 then
            return
        end
        local container = string.format('container: %s', res[1].containerName)
        local name = string.format('name: %s', res[1].name)
        vim.lsp.util.open_floating_preview({ name, container }, '', {
            height = 2,
            width = math.max(string.len(name), string.len(container)),
            focusable = false,
            focus = false,
            title = 'Symbol Info',
        })
    end, bufnr)
end

return {
    cmd = { 
        'clangd',
        '--background-index',
        '--header-insertion=never',
        '--completion-style=detailed',
        '--fallback-style=none',
        '--function-arg-placeholders=false',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    root_markers = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git',
    },
    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { 'utf-8', 'utf-16' },
    },
    on_init = function(client, init_result)
        if init_result.offsetEncoding then
            client.offset_encoding = init_result.offsetEncoding
        end
    end,
    on_attach = function(client, bufnr)
        if client:supports_method('textDocument/switchSourceHeader') then
            vim.keymap.set('n', 'go', function()
                switch_source_header(bufnr, client)
            end, { desc = 'Switch between source/header', buffer = bufnr })
        end
        if client:supports_method('textDocument/symbolInfo') then
            vim.keymap.set('n', 'gs', function()
                symbol_info(bufnr, client)
            end, { desc = 'Show symbol info', buffer = bufnr })
        end
    end,
}
