return {
  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup({})
    end,
  },

  -- Show Emojis in autocomplete, if something like ':smile' was written
  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- HTML Autotags
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
  }
}
