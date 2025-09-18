return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    opts = {
      keymap = {
        preset = 'default',
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      completion = {
        list = {
          max_items = 200,
          selection = {
            preselect = false,
            auto_insert = false,
          },
          cycle = {
            from_bottom = true,
            from_top = true,
          },
        },
        menu = {
          max_height = 10,
          scrollbar = true,
        },
        ghost_text = {
          enabled = false,
        },
      },
      signature = { enabled = false },

      -- disable blink.nvim in telescope prompts (i.e. new file, delete file confirmation)
      enabled = function()
        return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
      end,
    },
  },
}
