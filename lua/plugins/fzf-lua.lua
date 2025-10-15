return {
    {
        "ibhagwan/fzf-lua",
        version = false,
        cmd = "FzfLua",
        keys = {
            { "<leader>f<", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },
            { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
            { "<leader>fc", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },
            { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
            { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
            { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
            { "<leader>fd", "<cmd>FzfLua lsp_document_diagnostics<cr>", desc = "Document diagnostics" },
        },
        opts = function()
            local actions = require("fzf-lua").actions
            return {
                keymap = {
                    builtin = {
                        ["<Tab>"]   = "down",
                        ["<S-Tab>"] = "up",
                        ["<C-x>"]   = "toggle",
                    },
                    fzf = {
                        ["tab"]       = "down",
                        ["shift-tab"] = "up",
                        ["ctrl-x"]    = "toggle",
                        ["ctrl-q"]    = "select-all+accept",
                    },
                },
                actions = {
                    files = {
                        ["default"] = actions.file_edit_or_qf,
                    },
                    buffers = {
                        ["default"] = actions.buf_edit,
                    },
                    grep = {
                        ["default"] = actions.grep_lgrep,
                    },
                },
                winopts = {
                    on_create = function()
                        vim.keymap.set("t", "<C-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true, buffer = true })
                    end
                },
            }
        end,
    },
}
