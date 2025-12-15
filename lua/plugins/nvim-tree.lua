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

            filesystem_watchers = {
                enable = true,
                ignore_dirs = {
                    '/node_modules',
                    '/%.git',
                    '/dist',
                    '/build',
                    '/target',
                    '/%.cache',
                },
            },

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
            filters = { dotfiles = false, git_ignored = false },
            view = { signcolumn = 'no' },
        },
    },
}
