return {
    "nvim-java/nvim-java",
    ft = { "java" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("java").setup({
      })

      -- nvim-java registers its own jdtls config (install, launch command,
      -- lombok agent) via vim.lsp.config; going through lspconfig would
      -- override it with a PATH-based `jdtls` cmd that doesn't exist.
      -- It doesn't set capabilities, so merge in blink's completion
      -- capabilities (LazyVim does this automatically only for servers
      -- declared under opts.servers, which jdtls is not).
      vim.lsp.config("jdtls", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      vim.lsp.enable("jdtls")
    end,
  }
