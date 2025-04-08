return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    local get_icon = require("astroui").get_icon
    opts.dashboard = {
    preset = {
        keys = {
          { key = "n", action = "<Leader>n", icon = get_icon("FileNew", 0, true), desc = "New File  " },
          { key = "f", action = "<Leader>fF", icon = get_icon("Search", 0, true), desc = "Find File  " },
          { key = "r", action = "<Leader>fo", icon = get_icon("DefaultFile", 0, true), desc = "Recents  " },
          { key = "w", action = "<Leader>fw", icon = get_icon("WordFile", 0, true), desc = "Find Word  " },
          { key = "u", action = ":Lazy update", icon = get_icon("Refresh", 0, true), desc = "Update  " },
          { key = "q", action = ":q", icon = get_icon("ArrowLeft", 0, true), desc = "Exit  " },
          -- { key = "'", action = "<Leader>f'", icon = get_icon("Bookmarks", 0, true), desc = "Bookmarks  " },
          -- { key = "s", action = "<Leader>Sl", icon = get_icon("Refresh", 0, true), desc = "Last Session  " },
        },
      header = table.concat(
      	{
				"██   ██ ███    ██  ██████  ██     ██ ██      ███████ ██████   ██████  ███████",
				"██  ██  ████   ██ ██    ██ ██     ██ ██      ██      ██   ██ ██       ██     ",
				"█████   ██ ██  ██ ██    ██ ██  █  ██ ██      █████   ██   ██ ██   ███ █████  ",
				"██  ██  ██  ██ ██ ██    ██ ██ ███ ██ ██      ██      ██   ██ ██    ██ ██     ",
				"██   ██ ██   ████  ██████   ███ ███  ███████ ███████ ██████   ██████  ███████",
				"                                                                             ",
				"      █████  ███████      █████   ██████ ████████ ██  ██████  ███    ██",
				"     ██   ██ ██          ██   ██ ██         ██    ██ ██    ██ ████   ██",
				"     ███████ ███████     ███████ ██         ██    ██ ██    ██ ██ ██  ██",
				"     ██   ██      ██     ██   ██ ██         ██    ██ ██    ██ ██  ██ ██",
				"     ██   ██ ███████     ██   ██  ██████    ██    ██  ██████  ██   ████",
      	}, "\n"),
      },
    }
  end,
}
