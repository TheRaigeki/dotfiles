return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "html",
                "css",
                "css",
                "gitignore",
                "go",
                "dart",
                "graphql",
                "http",
                "java",
                "php",
                "rust",
                "scss",
                "markdown",
                "markdown_inline",
                "python",
                "sql",
                "svelte",
                "query",
                "regex",
                "tsx",
                "javascript",
                "typescript",
                "yaml",
            },
            query_linter = {
                enable = true,
                use_virtual_text = true,
                lint_events = { "BufWrite", "CursorHold" },
            },
            -- HTML autopairs
            autotag = {
                enable = true,
            },
            indent = {
                enable = false,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)

            -- MDX
            vim.filetype.add({
                extension = {
                    mdx = "mdx",
                },
            })
            vim.treesitter.language.register("markdown", "mdx")
        end,
    },
}
