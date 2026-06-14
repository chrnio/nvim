return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
	keys = {
		{ "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
		{ "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Focus file tree" },
		{ "<leader>ef", "<cmd>NvimTreeFindFile<CR>", desc = "Find current file in tree" },
	},
	config = function()
		require("nvim-tree").setup({
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				side = "left",
				width = 35,
				preserve_window_proportions = true,
			},
			actions = {
				open_file = {
					quit_on_open = false,
					resize_window = true,
				},
			},
			renderer = {
				highlight_opened_files = "name",
				group_empty = true,
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
				},
			},
			git = { enable = true, ignore = false },
			filters = {
				dotfiles = false,
				custom = { ".DS_Store", "__pycache__", ".cache" },
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local opts = function(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close parent"))
				vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse all"))
				vim.keymap.set("n", "v", api.node.open.vertical, opts("Vertical split"))
				vim.keymap.set("n", "s", api.node.open.horizontal, opts("Horizontal split"))
			end,
		})
	end,
}

