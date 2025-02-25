-- Debug Adapter Protocol
return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go"
        },
        config = function()
            require("dapui").setup()
            require("dap-go").setup()
            require("nvim-dap-virtual-text").setup({})

            vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
            vim.fn.sign_define('DapStopped', { text='▶︎', texthl='DapStopped', linehl='DapStopped', numhl='DapStopped' })
        end,


        vim.keymap.set("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", { noremap = true }),
        vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true, silent =  true }),
        vim.keymap.set("n", "<leader>dcb", ":DapClearBreakpoints<CR>", { noremap = true, silent =  true }),
        vim.keymap.set("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", { noremap = true }),

        vim.keymap.set("n", "<F1>", ":DapContinue<CR>", { noremap = true, silent = true }),
        vim.keymap.set("n", "<F2>", ":DapStepInto<CR>", { noremap = true, silent = true }),
        vim.keymap.set("n", "<F3>", ":DapStepOver<CR>", { noremap = true, silent = true }),
        vim.keymap.set("n", "<F4>", ":DapStepOut<CR>", { noremap = true, silent = true }),
    }
}
