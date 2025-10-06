return {
    "nvim-java/nvim-java",
    ft = { "java" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
    },
    config = function()
      require("java").setup({
      })

      require("lspconfig").jdtls.setup({
      })
    end,
  }
