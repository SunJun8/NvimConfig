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
    init = function()
      vim.g.sonokai_style = 'espresso'
      vim.g.sonokai_dim_inactive_windows = 0
      vim.g.sonokai_enable_italic = false
      vim.g.sonokai_disable_italic_comment = true
      vim.g.sonokai_transparent_background = false
      vim.g.sonokai_diagnostic_text_highlight = false
      vim.g.sonokai_transparent_background = 2
    end,
  },
}
