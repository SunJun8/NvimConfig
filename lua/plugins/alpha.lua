return {
	"goolord/alpha-nvim",
	opts = function(_, opts) -- override the options using lazy.nvim
		opts.section.header.val = {
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
		}
		opts.section.buttons.val = {
			opts.button("e", "  New file", "<cmd>ene<CR>"),
			opts.button("f", "  Find file",
				function()
					require("telescope.builtin").find_files { hidden = false, no_ignore = true }
				end
			),
			opts.button("r", "  Recent file", "<cmd>Telescope oldfiles<CR>"),
			opts.button("u", "  Update plugins", "<cmd>Lazy update<CR>"),
			opts.button("q", "  Quit", "<cmd>qa<CR>"),
		}
	end,
}
