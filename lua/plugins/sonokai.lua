---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "sonokai",
    },
  },

  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    -- dependencies = {
    --   "AstroNvim/astrocore",
    --   opts = {
    --     options = {
    --       g = {
    --         sonokai_style = 'espresso',
    --         sonokai_enable_italic = false,
    --         sonokai_disable_italic_comment = true,
    --         sonokai_diagnostic_text_highlight = false,
    --         sonokai_transparent_background = 2,
    --         sonokai_dim_inactive_windows = 1,
    --       }
    --     }
    --   },
    -- },
    config = function()
      -- directly inside the plugin declaration.
      -- vim.cmd.colorscheme('sonokai')
      vim.g.sonokai_style = 'espresso'
      vim.g.sonokai_enable_italic = false
      vim.g.sonokai_disable_italic_comment = true
      vim.g.sonokai_diagnostic_text_highlight = false
      vim.g.sonokai_transparent_background = 2
      vim.g.sonokai_dim_inactive_windows = 1
    end
  },
}
