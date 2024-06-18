return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts

    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map

          -- navigate buffer tabs
          ["L"]          = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["H"]          = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

          -- mappings seen under group name "Buffer"
          ["<Leader>bd"] = {
            function()
              require("astroui.status.heirline").buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Close buffer from tabline",
          },

          -- buffers
          ["<Leader>c"]  = false,
          ["<Leader>C"]  = false,
          ["<Leader>x"]  = { function() require("astrocore.buffer").close() end, desc = "Close buffer" },
          ["<Leader>X"]  = { function() require("astrocore.buffer").close(0, true) end, desc = "Force close buffer" },

          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"]  = { name = "Buffers" },
          ["<Leader>g"]  = { name = "Git" },

          -- Neotree
          ["<F4>"]       = { "<cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
          ["<Leader>e"] = false,
          ["<Leader>o"] = { "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },

          -- telescope
          ["<F8>"]       = {
            function()
              require("telescope.builtin").find_files { hidden = false, no_ignore = true }
            end,
            desc = 'Find all files',
          },

          -- tables with the `name` key will be registered with which-key if it's installed
          -- quick save
          ["<C-s>"]      = { ":w!<cr>", desc = "Save File" }, -- change description but the same command

          --spectre
          ["<Leader>s"]  = { name = "Spectre" },
          ["<Leader>S"]  = {
            ":lua require(\'spectre\').open()<CR>",
            desc = "Open spectre search"
          },
          ["<Leader>sw"] = {
            ":lua require(\'spectre\').open_visual({select_word=true})<CR>",
            desc = "Search current word"
          },
          ["<Leader>sp"] = {
            "viw:lua require(\'spectre\').open_file_search()<CR>",
            desc = "Search current buffer"
          },

          -- lsp
          ["gra"] = false,
          ["grn"] = false,
          ["grr"] = false,
          ["gr"] = { "<cmd>FzfLua lsp_references<CR>", desc = "Search references" },
        },

        i = {
          ["<C-s>"] = { "<C-c>:w!<CR>", desc = "Save File while insert" }, -- change description but the same command
        },

        t = {
          -- setting a mapping to false will disable it
          ["<esc>"] = false,
        },

        v = {
          ["<Leader>s"] = {
            ":lua require(\'spectre\').open_visual()<CR>",
            desc = "Search current block"
          },

          -- clangformat
          -- ["<Leader>lm"] = { "<cmd>py3f /home/jokeo/tool/clang/tools/clang-format/clang-format.py<CR>", desc = "format cpp by clang format" },
        },

        x = {
          ["gra"] = false,
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          --Lspsaga
          ["<Leader>lk"] = { "<cmd>Lspsaga hover_doc<CR>", desc = "Lspsaga Hover doc" },
          ["<Leader>lg"] = { "<cmd>Lspsaga goto_definition<CR>", desc = "Lspsaga Goto definition" },
          ["<Leader>lp"] = { "<cmd>Lspsaga peek_definition<CR>", desc = "Lspsaga Preview definition" },
          ["<Leader>lF"] = { "<cmd>Lspsaga finder<CR>", desc = "Lspsaga finder" },
          ["<Leader>lS"] = { "<cmd>Lspsaga outline<CR>", desc = "Lspsaga Symbols outline" },

          ["<Leader>lR"] = { function() require("fzf-lua").lsp_references() end, desc = "Search references" },
          ["<Leader>lG"] = { function() require("fzf-lua").lsp_live_workspace_symbols() end, desc = "Search workspace symbols" },
        },
      },
    },
  },
}
