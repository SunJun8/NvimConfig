if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local prefix = "<Leader>a"
return {
  "yetone/avante.nvim",
  build = vim.fn.has "win32" == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "User AstroFile", -- load on file open because Avante manages it's own bindings
  cmd = {
    "AvanteAsk",
    "AvanteBuild",
    "AvanteEdit",
    "AvanteRefresh",
    "AvanteSwitchProvider",
    "AvanteChat",
    "AvanteToggle",
    "AvanteClear",
  },
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        opts.mappings.n[prefix] = { desc = " Avante" }
      end
    },
  },
  opts = {
    mappings = {
      ask = prefix .. "<CR>",
      edit = prefix .. "e",
      refresh = prefix .. "r",
      focus = prefix .. "f",
      toggle = {
        default = prefix .. "t",
        debug = prefix .. "d",
        hint = prefix .. "h",
        suggestion = prefix .. "s",
        repomap = prefix .. "R",
      },
      diff = {
        next = "]c",
        prev = "[c",
      },
      files = {
        add_current = prefix .. ".",
      },
    },
    provider = "tencent_hunyuan",
    vendors = {
      tencent_hunyuan = {
        __inherited_from = "openai",
        endpoint = "https://api.lkeap.cloud.tencent.com/v1",
        model = "deepseek-v3",
        api_key_name = "TENCENT_HUNYUAN_API_KEY",
        temperature = 0.1
      },
      baidu_qianfan = {
        __inherited_from = "openai",
        endpoint = "https://qianfan.baidubce.com/v2",
        model = "deepseek-v3",
        api_key_name = "BAIDU_QIANFAN_API_KEY",
        temperature = 0.7
      },
    },
  },
  specs = { -- configure optional plugins
    { "AstroNvim/astroui", opts = { icons = { Avante = "" } } },
    { -- if copilot.lua is available, default to copilot provider
      -- "zbirenbaum/copilot.lua",
      -- optional = true,
      -- specs = {
      --   {
      --     "yetone/avante.nvim",
      --     opts = {
      --       provider = "copilot",
      --       auto_suggestions_provider = "copilot",
      --     },
      --   },
      -- },
    },
    {
      -- make sure `Avante` is added as a filetype
      "MeanderingProgrammer/render-markdown.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.file_types then opts.file_types = { "markdown" } end
        opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "Avante" })
      end,
    },
    {
      -- make sure `Avante` is added as a filetype
      "OXY2DEV/markview.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.filetypes then opts.filetypes = { "markdown", "quarto", "rmd" } end
        opts.filetypes = require("astrocore").list_insert_unique(opts.filetypes, { "Avante" })
      end,
    },
  },
}
