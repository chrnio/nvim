return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fm",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format file (or selection)",
		},
	},
	opts = {
		formatters_by_ft = {

			rust = { "rustfmt" },

			typescript = { { "biome", "prettier" } },
			typescriptreact = { { "biome", "prettier" } },
			javascript = { { "biome", "prettier" } },
			javascriptreact = { { "biome", "prettier" } },
			json = { { "biome", "prettier" } },
			jsonc = { { "biome", "prettier" } },

			go = { "gofmt", "goimports" },

			java = { "google-java-format" },

			lua = { "stylua" },

			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },

			sh = { "shfmt" },
			bash = { "shfmt" },

			toml = { "taplo" },

			sql = { "sql_formatter" },

			python = { "black", "isort" },

			tex = { "latexindent" },
			bib = { "latexindent" },
		},

		format_on_save = function(bufnr)

			local max_filesize = 500 * 1024
			local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
			if ok and stats and stats.size > max_filesize then
				return nil
			end

			local disable_filetypes = { "gitcommit", "gitrebase", "tex", "bib" }
			if vim.tbl_contains(disable_filetypes, vim.bo[bufnr].filetype) then
				return nil
			end

			return { timeout_ms = 3000, lsp_fallback = true }
		end,

		notify_on_error = true,
	},
}

