return {
    {
        "folke/trouble.nvim",
        opts = { use_diagnostic_signs = true },
        cmd = "Trouble",
        keys = {
            {
                "<leader>tt",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Trouble diagnostics",
            },
        },
    },
}
