if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    adapters = {
      baidu_qianfan = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "https://qianfan.baidubce.com/v2",
            api_key = "bce-v3/ALTAK-axQPSEJGXIxcPJmJi57t9/7879a9a73a98b97f46e87c16f81e8ab2921e41a1",
            chat_url = "/chat/completions",
          },
          schema = {
            model = {
              default = "deepseek-v3",
            },
          },
        })
      end,
      tencent_hunyuan = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "https://api.lkeap.cloud.tencent.com",
            api_key = "sk-btDUpTR24tWgemYYtABOxMkpDo8D0yVq6igsuPgAX7TQAIzk",
            chat_url = "/v1/chat/completions",
          },
          schema = {
            model = {
              default = "deepseek-v3",
            },
          },
        })
      end,
    },

    strategies = {
      chat = {
        adapter = "baidu_qianfan"
      },

      inline = {
        adapter = "baidu_qianfan"
      }
    },

    opts = {
      log_level = "DEBUG",
    },
  }
}
