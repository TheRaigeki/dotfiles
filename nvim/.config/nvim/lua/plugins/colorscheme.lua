return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        -- night, moon, storm, day (light theme)
        style = "night",
        transparent = true,
        lualine_bold = true,
        styles = {
          comments  = { italic = true },
          keywords  = { italic = false },
          functions = {},
          variables = {},
          sidebars  = "transparent", -- make sidebars transparent
          floats    = "transparent", -- make floats (incl. Telescope) transparent
        },
        on_highlights = function(hl, c)
          -- Ensure all generic floats are transparent + keep a border
          hl.NormalFloat = { bg = "NONE" }
          hl.FloatBorder = { bg = "NONE", fg = c.blue }

          local prompt = true;

          -- Telescope: fully transparent panes, readable border, subtle selection
          hl.TelescopeNormal        = { bg = "NONE", fg = c.fg }
          hl.TelescopeBorder        = { bg = "NONE", fg = c.blue }

          hl.TelescopePromptNormal  = { bg = "NONE", fg = c.fg }
          hl.TelescopePromptBorder  = { bg = "NONE", fg = c.blue }
          hl.TelescopePromptPrefix  = { bg = "NONE", fg = c.blue }
          hl.TelescopePromptTitle   = { bg = "NONE", fg = c.blue }

          hl.TelescopeResultsNormal = { bg = "NONE", fg = c.fg }
          hl.TelescopeResultsBorder = { bg = "NONE", fg = c.blue }
          hl.TelescopeResultsTitle  = { bg = "NONE", fg = c.blue }

          hl.TelescopePreviewNormal = { bg = "NONE", fg = c.fg }
          hl.TelescopePreviewBorder = { bg = "NONE", fg = c.blue }
          hl.TelescopePreviewTitle  = { bg = "NONE", fg = c.blue }

          -- Selection inside Telescope list (keeps it visible without filling the whole pane)
          hl.TelescopeSelection     = { bg = c.bg_highlight, fg = c.fg }

          -- change text color of unused variables to comment color, because the original color was to hard to read with transparent bg
          hl["@lsp.mod.unused"]  = { fg = c.comment, italic = true, strikethrough = false }
          hl.DiagnosticUnnecessary = { fg = c.comment, italic = true, strikethrough = false }

          -- visual selection (if highlight color is too hard to see, uncomment the line below)
          -- hl.Visual = { fg = "NONE", bg = "#33467C" }
        end,
      }
    end,
  },
}
