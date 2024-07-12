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
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        options = {
          g = {
            sonokai_style = 'espresso',
            sonokai_enable_italic = false,
            sonokai_disable_italic_comment = true,
            sonokai_diagnostic_text_highlight = false,
            sonokai_transparent_background = 2,
            sonokai_dim_inactive_windows = 1,
          }
        }
      },
    },
  },
}
