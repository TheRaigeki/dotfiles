return {
  'nvim-java/nvim-java',
  config = false,
  dependencies = {
    {
      'neovim/nvim-lspconfig',
      opts = {
        servers = {
          jdtls = {
            -- Your custom jdtls settings goes here
          },
        },
        setup = {
          jdtls = function()
            require('java').setup({
              -- Your custom nvim-java configuration goes here
            })
          end,
        },
      },
    },
  },

  vim.keymap.set("n", "<leader>jtc", ":JavaTestRunCurrentClass<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>jtm", ":JavaTestRunCurrentMethod<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>jdc", ":JavaTestDebugCurrentClass<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>jdm", ":JavaTestDebugCurrentMethod<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>jtr", ":JavaTestViewLastReport<CR>", { noremap = true, silent = true }),
}
