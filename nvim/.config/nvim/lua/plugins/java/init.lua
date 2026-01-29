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

      local lombok_jar = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar")

      require("lspconfig").jdtls.setup({
        cmd = {
          "jdtls",
          "--jvm-arg=-javaagent:" .. lombok_jar,
        },
      })
    end,
  }
