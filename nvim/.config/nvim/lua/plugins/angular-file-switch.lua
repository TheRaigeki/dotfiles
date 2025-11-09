return {
    -- toggle file switch between component.html and component.ts files
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        keys = {
            {
                "<leader>aa",
                function()
                    local current_file = vim.fn.expand("%:p")
                    local filename = vim.fn.expand("%:t")

                    -- Check if it's a component file
                    if filename:match("%.component%.html$") then
                        -- Switch from .html to .ts
                        local ts_file = current_file:gsub("%.component%.html$", ".component.ts")
                        vim.cmd("edit " .. ts_file)
                    elseif filename:match("%.component%.ts$") then
                        -- Switch from .ts to .html
                        local html_file = current_file:gsub("%.component%.ts$", ".component.html")
                        vim.cmd("edit " .. html_file)
                    end
                    -- If neither pattern matches, do nothing (silent)
                end,
                desc = "Toggle between Angular component HTML/TS",
            },
        },
    },
    -- suppress unnecessary warn message when selecting something from blink.cmp suggestions (auto completion)
    {
        "folke/noice.nvim",
        optional = true,
        opts = {
            routes = {
                {
                    filter = {
                        event = "notify",
                        find = "angular%.applyCompletionCodeAction",
                    },
                    opts = { skip = true },
                },
            },
        },
    },
}
