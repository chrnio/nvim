return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	cmd = "Telescope",
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_layout = require("telescope.actions.layout")

		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules", "vendor", "%.git/", "target/", "dist/",
					"%.lock", "build/", "%.class",
				},
				path_display = { "smart" },
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = { preview_width = 0.55 },
					vertical = { mirror = false },
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
					width = 0.87,
					height = 0.80,
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-t>"] = require("trouble.sources.telescope").open,
						["<M-p>"] = action_layout.toggle_preview,
						["<C-x>"] = actions.delete_buffer,
						["<Esc>"] = actions.close,
					},
					n = {
						["<C-t>"] = require("trouble.sources.telescope").open,
						["<M-p>"] = action_layout.toggle_preview,
						["q"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = { hidden = true },
				live_grep = {
					additional_args = function()
						return { "--hidden", "--glob=!.git/*" }
					end,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
	end,
}

