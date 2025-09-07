return {
    {
        'akinsho/bufferline.nvim',
        version = false,
        event = 'VeryLazy',
        keys = {
            { '<leader>bp', '<cmd>BufferLinePick<cr>', desc = 'Pick a buffer to open' },
            { '<leader>bc', '<cmd>BufferLinePickClose<cr>', desc = 'Select a buffer to close' },
            { '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', desc = 'Close buffers to the left' },
            { '<leader>br', '<cmd>BufferLineCloseRight<cr>', desc = 'Close buffers to the right' },
            { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = 'Close other buffers' },
        },
        opts = {
            options = {
                close_command = 'confirm bdelete %d',
                right_mouse_command = 'confirm bdelete %d',
                middle_mouse_command = 'confirm bdelete %d',

                show_buffer_close_icons = false,
                show_close_icon = false,
                always_show_bufferline = false,

                indicator = { style = 'underline' },
                truncate_names = false,

                offsets = {
                    {
                        filetype = 'NvimTree',
                        text = 'File tree',
                        text_align = 'left',
                        separator = true,
                    },
                },
            },
        },
    },
}
