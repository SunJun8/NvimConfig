return {
  {
    "ojroques/nvim-lspfuzzy",
    event = "User AstroFile",
    dependencies = {
      {
        "junegunn/fzf",
      },
      {
        "junegunn/fzf.vim",
      }
    },
  },
  {
    'nvimdev/lspsaga.nvim',
    event = "LspAttach",
    config = function()
      require('lspsaga').setup({
        definition = {
          width = 0.6,
          height = 0.6,
        },
        outline = {
          win_width = 40,
        },
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    }
  }

}
