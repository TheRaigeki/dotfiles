return {
    -- Incremental rename
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup({})
        end,
    },

    -- HTML Autotags
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
    },
}
