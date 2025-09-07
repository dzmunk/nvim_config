return {
    {
        'nvim-mini/mini.clue',
        version = false,
        event = 'VeryLazy',
        opts = function()
            local miniclue = require('mini.clue')
            return {
                triggers = {
                    { mode = 'n', keys = '<leader>' }, { mode = 'x', keys = '<leader>' },
                    { mode = 'n', keys = 'g' }, { mode = 'x', keys = 'g' },
                    { mode = 'n', keys = 'z' }, { mode = 'x', keys = 'z' },
                    { mode = 'n', keys = '[' }, { mode = 'n', keys = ']' },
                    { mode = 'n', keys = '<C-w>' },
                    { mode = 'n', keys = "'" }, { mode = 'n', keys = '`' },
                    { mode = 'n', keys = '"' }, { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' }, { mode = 'c', keys = '<C-r>' },
                },
                clues = {
                    { mode = 'n', keys = '<leader>b', desc = '+Buffers' },
                    { mode = 'n', keys = '<leader>f', desc = '+Find' },
                    { mode = 'n', keys = '<leader>d', desc = '+Debug' },
                    { mode = 'n', keys = '[', desc = '+prev' },
                    { mode = 'n', keys = ']', desc = '+next' },

                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.z(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                },
                window = {
                    scroll_down = '<C-d>',
                    scroll_up   = '<C-u>',
                    config = {
                        width = 'auto',
                    },
                },
                delay = 500,
            }
        end,
    },
}
