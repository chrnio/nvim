return {

	{
		"lervag/vimtex",
		ft = { "tex", "bib", "plaintex" },
		init = function()

			vim.g.vimtex_view_method = "okular"
			vim.g.vimtex_view_okular_options = "--unique file:@pdf\\#src:@line@tex"

			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				options = {
					"-pdf",
					"-shell-escape",
					"-interaction=nonstopmode",
					"-synctex=1",
				},
			}

			vim.g.vimtex_quickfix_mode = 0

			vim.g.vimtex_toc_config = { split_pos = "vert rightbelow" }

			vim.g.vimtex_indent_enabled = 0

			vim.g.vimtex_syntax_conceal_disable = 1

			vim.g.vimtex_fold_enabled = 1
		end,
		config = function()

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "tex", "bib", "plaintex" },
				group = vim.api.nvim_create_augroup("VimtexExtra", { clear = true }),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>",     vim.tbl_extend("force", opts, { desc = "LaTeX: Forward search (Okular)" }))
					vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>",  vim.tbl_extend("force", opts, { desc = "LaTeX: Compile (toggle)" }))
					vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<CR>",    vim.tbl_extend("force", opts, { desc = "LaTeX: Clean aux files" }))
					vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocOpen<CR>",  vim.tbl_extend("force", opts, { desc = "LaTeX: Table of contents" }))
					vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>",   vim.tbl_extend("force", opts, { desc = "LaTeX: Show errors" }))
					vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<CR>",     vim.tbl_extend("force", opts, { desc = "LaTeX: Stop compiler" }))
				end,
			})
		end,
	},

	{
		"linux-cultist/venv-selector.nvim",
		ft = "python",
		branch = "regexp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
		},
		opts = {

			auto_refresh = true,

			search = true,
			search_venv_managers = true,
			search_workspace = true,
		},
		keys = {
			{ "<leader>pv", "<cmd>VenvSelect<CR>",       desc = "Python: Select venv" },
			{ "<leader>pc", "<cmd>VenvSelectCached<CR>", desc = "Python: Use cached venv" },
		},
	},
}

