-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = "p00f/nvim-ts-rainbow",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = {
      "c",
      "cpp",
      "python",
      "markdown",
      "make",
      "cmake",
      "ninja",
      "go",
      "html",
      "rust",
      "vim",
      "lua",
    }

    opts.rainbow = {
      enable = true,
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
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
