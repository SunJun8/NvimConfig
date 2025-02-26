-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = "hiphish/rainbow-delimiters.nvim",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = {
      "c",
      "cpp",
      "python",
      "markdown",
      "make",
      "cmake",
      "rust",
      "lua",
    }

    opts.indent = {
      enable = true
    }

    opts.sync_install = false

    opts.auto_install = false

    opts.git = {
      ignore = 0
    }
  end,
}
