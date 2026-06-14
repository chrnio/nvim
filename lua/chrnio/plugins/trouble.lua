return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	keys = {
		{ "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>",                desc = "Trouble workspace diagnostics" },
		{ "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",   desc = "Trouble buffer diagnostics" },
		{ "<leader>ts", "<cmd>Trouble symbols toggle<CR>",                    desc = "Trouble symbols" },
		{ "<leader>tl", "<cmd>Trouble lsp toggle<CR>",                        desc = "Trouble LSP definitions/refs" },
		{ "<leader>tq", "<cmd>Trouble qflist toggle<CR>",                     desc = "Trouble quickfix list" },
		{ "]t", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next Trouble item" },
		{ "[t", function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Prev Trouble item" },
	},
	opts = {},
}

