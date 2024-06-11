-- Customize Treesitter
-- --------------------
-- Treesitter customizations are handled with AstroCore
-- as nvim-treesitter simply provides a download utility for parsers

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      highlight = true, -- enable/disable treesitter based highlighting
      indent = true, -- enable/disable treesitter based indentation
      auto_install = false, -- enable/disable automatic installation of detected languages
      sync_install = false,
      git = {
        ignore = 0, -- List of parsers to ignore installing when `sync_install` is true (e.g. { "javascript" })
      },
      ensure_installed = {
        "c",
        "cpp",
        "python",
        "markdown",
        "make",
        "cmake",
        "rust",
        "lua",
        "bash",
        -- add more arguments for adding more treesitter parsers
      },
    },
  },
}
