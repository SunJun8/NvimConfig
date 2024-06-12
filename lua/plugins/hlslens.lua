-----------------------------------------------------------
-- Hlslens configuration file
----------------------------------------------------------

-- Plugin: hlslens
-- url: https://github.com/kevinhwang91/nvim-hlslens

return {
  "kevinhwang91/nvim-hlslens",
  event = "User AstroFile",

  config = function()
    require('hlslens').setup({
      calm_down = true,
      nearest_only = true,
      nearest_float_when = 'always'
    })
  end
}
