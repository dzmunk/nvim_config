return {
    {
        "ibhagwan/fzf-lua",
        version = false,
        cmd = "FzfLua",
        keys = {
            { "<leader>f<", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },
            { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
            { '<leader>fc', '<cmd>FzfLua highlights<cr>', desc = 'Highlights' },
            { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
            { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
            { "<leader>fd", "<cmd>FzfLua lsp_document_diagnostics<cr>", desc = "Document diagnostics" },
        },
    },
}
