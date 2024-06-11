if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    adapters = {
      huoshan = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "https://ark.cn-beijing.volces.com/api/v3/",
            api_key = vim.fn.getenv("HUOSHAN_API_KEY"),
            chat_url = "chat/completions",
            models_endpoint = "ListEndpoints",
          },

          schema = {
            model = {
              default = "deepseek-v3-250324",
            },
            temperature = {
              order = 2,
              mapping = "parameters",
              type = "number",
              optional = true,
              default = 0.5,
              desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
              validate = function(n)
                return n >= 0 and n <= 2, "Must be between 0 and 2"
              end,
            },
          },
        })
      end,

      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            api_key = vim.fn.getenv("OPENAI_API_KEY"),
          },

          schema = {
            model = {
              default = "gpt-4.1",
            },
            temperature = {
              order = 2,
              mapping = "parameters",
              type = "number",
              optional = true,
              default = 0.5,
              desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
              validate = function(n)
                return n >= 0 and n <= 2, "Must be between 0 and 2"
              end,
            },
          },
        })
      end,
    },

    strategies = {
      chat = {
        adapter = "huoshan",
        chat = {
          keymaps = {
            send = {
              modes = { n = "<C-s>", i = "<C-s>" },
            },
            close = {
              modes = { n = "<C-c>", i = "<C-c>" },
            },
          },
        },

        inline = {
          adapter = "huoshan",
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gj" },
              description = "Reject the suggested change",
            },
          },
          layout = "vertical", -- vertical|horizontal|buffer
        },

        cmd = {
          adapter = "huoshan",
        },
      },
    },

    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = "Prompt ", -- Prompt used for interactive LLM calls
        provider = "default", -- Can be "default", "telescope", or "mini_pick". If not specified, the plugin will autodetect installed providers.
        opts = {
          show_default_actions = true, -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        },
      },

      chat = {
        window = {
          layout = "horizontal", -- float|vertical|horizontal|buffer
          position = "bottom", -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
          border = "single",
          height = 0.4,
          width = 0.45,
          relative = "editor",
        },
      },

      diff = {
        enabled = true,
        close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
        layout = "vertical", -- vertical|horizontal split for default provider
        opts = {
          "internal",
          "filler",
          "closeoff",
          "algorithm:patience",
          "followwrap",
          "linematch:120"
        },
        provider = "default", -- default|mini_diff
      },
    },

    opts = {
      log_level = "INFO",
      language = "Chinese",
      send_code = true,
    },

  }
}
