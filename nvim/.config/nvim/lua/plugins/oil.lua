return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "sf",
      function()
        require("oil").open()
      end,
      desc = "Open file browser at current file's directory",
    },
  },
  opts = {
    constrain_cursor = "name",
    view_options = {
      show_hidden = true,
    },
  },
}
