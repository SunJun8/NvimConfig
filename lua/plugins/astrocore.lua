-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true,                                 -- enable autopairs at start
      cmp = true,                                       -- enable completion at start
      diagnostics_mode = 3,                             -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true,                              -- highlight URLs at start
      notifications = true,                             -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = {                  -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true,         -- sets vim.opt.number
        spell = false,         -- sets vim.opt.spell
        signcolumn = "auto",   -- sets vim.opt.signcolumn to yes
        wrap = false,          -- sets vim.opt.wrap
        tabstop = 2,           -- number of space in a tab
        shiftwidth = 2,        -- number of space inserted for indentation
        expandtab = true,      -- enable the use of space in tab
      },
      g = {                    -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
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

        -- tables with the `name` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<leader>b"]  = { name = "Buffers" },
        ["<leader>g"]  = { name = "Git" },

        -- Neotree
        ["<F4>"]       = { "<cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
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
        ["<leader>s"]  = { name = "Spectre" },
        ["<leader>F"]  = {
          ":lua require(\'spectre\').open()<CR>",
          desc = "Open spectre search"
        },
        ["<leader>sw"] = {
          ":lua require(\'spectre\').open_visual({select_word=true})<CR>",
          desc = "Search current word"
        },
        ["<leader>sp"] = {
          "viw:lua require(\'spectre\').open_file_search()<CR>",
          desc = "Search current buffer"
        },

        -- close buffer
        -- ["<leader>x"]  = { function() require("astrocore.buffer").close() end, desc = "Close buffer" },
        -- ["<leader>X"]  = { function() require("astrocore.buffer").close(0, true) end, desc = "Force close buffer" },


        --Lspsaga
        ["<leader>lk"] = { "<cmd>Lspsaga hover_doc<CR>", desc = "Lspsaga Hover doc" },
        ["<leader>lg"] = { "<cmd>Lspsaga goto_definition<CR>", desc = "Lspsaga Goto definition" },
        ["<leader>lp"] = { "<cmd>Lspsaga peek_definition<CR>", desc = "Lspsaga Preview definition" },
        ["<leader>lF"] = { "<cmd>Lspsaga finder<CR>", desc = "Lspsaga finder" },
        ["<leader>lS"] = { "<cmd>Lspsaga outline<CR>", desc = "Lspsaga Symbols outline" },
      },

      i = {
        ["<C-s>"] = { "<C-c>:w!<CR>", desc = "Save File while insert" }, -- change description but the same command
      },

      t = {
        -- setting a mapping to false will disable it
        ["<esc>"] = false,
      },

      v = {
        ["<leader>s"] = {
          ":lua require(\'spectre\').open_visual()<CR>",
          desc = "Search current block"
        },

        -- clangformat
        -- ["<leader>lm"] = { "<cmd>py3f /home/jokeo/tool/clang/tools/clang-format/clang-format.py<CR>", desc = "format cpp by clang format" },
      },
    },
  },
}
