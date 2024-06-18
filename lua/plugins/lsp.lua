return {
  {
    "ojroques/nvim-lspfuzzy",
    enabled = false,
    event = "LspAttach",
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
  },
  {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
      opts.symbol_map.copolot = ""
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
    end
  },
}
