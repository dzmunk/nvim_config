return {
    {
        'nvim-tree/nvim-tree.lua',
        version = false,
        keys = {
            { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'File tree', mode = 'n' },
        },
        opts = {
            git = { enable = false },
            sync_root_with_cwd = true,
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,

            renderer = {
                root_folder_label = false,
                group_empty = true,
                indent_markers = { enable = true },
            },

            update_focused_file = {
                enable = true,
                update_root = false,
            },

            actions = {
                change_dir = { enable = false },
                open_file = {
                    quit_on_open = false,
                    resize_window = true,
                },
            },

            diagnostics = { enable = false, show_on_dirs = false },
            filters = { dotfiles = true, git_ignored = true },
            view = { signcolumn = 'no' },
        },
    },
}
