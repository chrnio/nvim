return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	keys = {
		{ "-", "<cmd>Oil<CR>", desc = "Open Oil (parent dir)" },
		{ "<leader>-", "<cmd>Oil --float<CR>", desc = "Open Oil (float)" },
	},
	opts = {

		view_options = {
			show_hidden = true,
		},

		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-v>"] = "actions.select_vsplit",
			["<C-s>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-l>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
		},

		columns = {
			"icon",
			"permissions",
			"size",
		},
		float = {
			padding = 2,
			max_width = 90,
			max_height = 30,
			border = "rounded",
		},
	},
}

