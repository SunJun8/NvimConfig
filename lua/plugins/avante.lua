return {
  "yetone/avante.nvim",
  build = ":AvanteBuild",
  event = "VeryLazy",
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
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        local prefix = "<Leader>a"

        maps.n[prefix] = { desc = "Avante functionalities" }

        maps.n[prefix .. "a"] = { function() require("avante.api").ask() end, desc = "Avante ask" }
        maps.v[prefix .. "a"] = { function() require("avante.api").ask() end, desc = "Avante ask" }

        maps.v[prefix .. "r"] = { function() require("avante.api").refresh() end, desc = "Avante refresh" }

        maps.n[prefix .. "e"] = { function() require("avante.api").edit() end, desc = "Avante edit" }
        maps.v[prefix .. "e"] = { function() require("avante.api").edit() end, desc = "Avante edit" }

        -- the following key bindings do not have an official api implementation
        maps.n.co = { "<Plug>(AvanteConflictOurs)", desc = "Choose ours", expr = true }
        maps.v.co = { "<Plug>(AvanteConflictOurs)", desc = "Choose ours", expr = true }

        maps.n.ct = { "<Plug>(AvanteConflictTheirs)", desc = "Choose theirs", expr = true }
        maps.v.ct = { "<Plug>(AvanteConflictTheirs)", desc = "Choose theirs", expr = true }

        maps.n.ca = { "<Plug>(AvanteConflictAllTheirs)", desc = "Choose all theirs", expr = true }
        maps.v.ca = { "<Plug>(AvanteConflictAllTheirs)", desc = "Choose all theirs", expr = true }

        maps.n.cb = { "<Plug>(AvanteConflictBoth)", desc = "Choose both", expr = true }
        maps.v.cb = { "<Plug>(AvanteConflictBoth)", desc = "Choose both", expr = true }

        maps.n.cc = { "<Plug>(AvanteConflictCursor)", desc = "Choose cursor", expr = true }
        maps.v.cc = { "<Plug>(AvanteConflictCursor)", desc = "Choose cursor", expr = true }

        maps.n["]x"] = { "<Plug>(AvanteConflictPrevConflict)", desc = "Move to previous conflict", expr = true }

        maps.n["[x"] = { "<Plug>(AvanteConflictNextConflict)", desc = "Move to next conflict", expr = true }
      end,
    },
  },
  opts = {
    provider = "openai",
    openai = {
      endpoint = "https://api.holdai.top/v1",
      model = "gpt-4o-mini", -- The model name to use with this provider
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 8000,
    },
    claude = {
      endpoint = "https://api.holdai.top/v1",
      model = "claude-3-5-sonnet-20241022",
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 8000,
    },
  },
  specs = { -- configure optional plugins
    {
      -- if copilot.lua is available, default to copilot provider
      "zbirenbaum/copilot.lua",
      optional = true,
      specs = {
        {
          "yetone/avante.nvim",
          opts = {
            provider = "copilot",
          },
        },
      },
    },
    {
      -- make sure `Avante` is added as a filetype
      "MeanderingProgrammer/render-markdown.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.file_types then opts.filetypes = { "markdown" } end
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
