return {
  "dhananjaylatkar/cscope_maps.nvim",
  event = "User AstroFile",
  dependencies = {
    {
      "ibhagwan/fzf-lua",
      dependencies = {
        'nvim-tree/nvim-web-devicons'
      }
    }
  },
  opts = {
    prefix = "<Leader>c",                   -- prefix to trigger maps
    disable_maps = false,                   -- true disables my keymaps, only :Cscope will be loaded
    cscope = {
      db_file = "./cscope.out",             -- location of cscope db file
      exec = "cscope",                      -- "cscope" or "gtags-cscope"
      picker = "fzf-lua",                   -- "telescope", "fzf-lua" or "quickfix"
      skip_picker_for_single_result = true, -- "false" or "true"
    },
  }
}
