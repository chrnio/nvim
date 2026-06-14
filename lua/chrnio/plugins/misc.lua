return {

	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		version = "*",
		config = true,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"echasnovski/mini.move",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			mappings = {
				left  = "<M-h>",
				right = "<M-l>",
				down  = "<M-j>",
				up    = "<M-k>",
				line_left  = "<M-h>",
				line_right = "<M-l>",
				line_down  = "<M-j>",
				line_up    = "<M-k>",
			},
		},
	},

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = { border = "rounded" },
			select = { backend = { "telescope", "builtin" } },
		},
	},

	{
		"sphamba/smear-cursor.nvim",
		event = "VeryLazy",
		opts = {
			smear_insert_mode = false,
			min_horizontal_distance_smear = 2,
			min_vertical_distance_smear = 2,
			time_interval = 17,
			stiffness = 0.9,
			trailing_stiffness = 0.4,
			damping = 0.99,
			never_draw_over_target = true,
		},
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "]T", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
			{ "[T", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
			{ "<leader>fT", "<cmd>TodoTelescope<CR>", desc = "Find TODOs" },
		},
		opts = { signs = true },
	},

	{
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout" },
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = true, timeout = 3000 },
			quickfile = { enabled = true },
			statuscolumn = { enabled = false },
			words = { enabled = true },
		},
		keys = {
			{ "<leader>un", function() require("snacks").notifier.show_history() end, desc = "Notification history" },
			{ "<leader>gg", function() require("snacks").lazygit() end, desc = "Open Lazygit" },
			{ "<leader>gl", function() require("snacks").lazygit.log() end, desc = "Lazygit log" },
		},
	},

	{ "nvim-lua/plenary.nvim", lazy = true },

	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft", "TmuxNavigateDown",
			"TmuxNavigateUp", "TmuxNavigateRight",
		},
		keys = {
			{ "<C-h>", "<cmd>TmuxNavigateLeft<CR>",  desc = "Navigate left" },
			{ "<C-j>", "<cmd>TmuxNavigateDown<CR>",  desc = "Navigate down" },
			{ "<C-k>", "<cmd>TmuxNavigateUp<CR>",    desc = "Navigate up" },
			{ "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right" },
		},
	},

	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			render = "background",
			enable_named_colors = true,
			enable_tailwind = true,
		},
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown" },
		opts = {},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			indent = { char = "│" },
			scope = { enabled = true, show_start = false, show_end = false },
		},
	},
}

