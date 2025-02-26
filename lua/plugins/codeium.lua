if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "Exafunction/codeium.nvim",
  event = "User AstroFile",
  cmd = "Codeium",
  opts = {
    enable_chat = false,
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
}
