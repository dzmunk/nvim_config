return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local langs = {
            'bash',
            'c',
            'cpp',
            'fish',
            'go',
            'graphql',
            'html',
            'hyprlang',
            'java',
            'javascript',
            'json',
            'json5',
            'jsonc',
            'lua',
            'markdown',
            'markdown_inline',
            'python',
            'query',
            'rasi',
            'regex',
            'rust',
            'scss',
            'toml',
            'tsx',
            'typescript',
            'vim',
            'vimdoc',
            'yaml',
        }

        local ts = require('nvim-treesitter')
        ts.setup({
            install_dir = vim.fn.stdpath('data') .. '/site',
        })
        ts.install(langs)

        vim.api.nvim_create_autocmd('FileType', {
            pattern = langs,
            callback = function()
                vim.treesitter.start()
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
