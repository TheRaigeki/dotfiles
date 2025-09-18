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
      -- HTML autopairs
      autotag = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)

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
