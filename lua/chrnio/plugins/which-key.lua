return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = 400,
		spec = {

			{ "<leader>b", group = "Buffers" },
			{ "<leader>c", group = "LSP calls / colorscheme" },
			{ "<leader>d", group = "Debug (DAP)" },
			{ "<leader>e", group = "Explorer" },
			{ "<leader>f", group = "Find (Telescope)" },
			{ "<leader>g", group = "Git" },
			{ "<leader>h", group = "Git hunks" },
			{ "<leader>r", group = "Refactor / rename" },
			{ "<leader>s", group = "Splits" },
			{ "<leader>t", group = "Trouble / diagnostics" },
			{ "<leader>u", group = "UI toggles" },
			{ "[",         group = "Go to prev" },
			{ "]",         group = "Go to next" },
			{ "g",         group = "Go to / LSP" },
		},
	},
}

