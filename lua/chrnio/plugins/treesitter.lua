return {
	"nvim-treesitter/nvim-treesitter",

	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()

		local has_configs, configs = pcall(require, "nvim-treesitter.configs")

		local parsers = {

			"javascript", "typescript", "tsx", "json", "jsonc",
			"html", "css", "graphql", "yaml", "toml",

			"rust", "go", "gomod", "gosum", "gowork",

			"java",

			"bash", "lua", "vim", "vimdoc", "query",

			"markdown", "markdown_inline",

			"dockerfile", "gitignore", "gitcommit", "git_rebase",
			"hcl", "terraform",

			"make", "cmake",

			"sql", "proto",

			"python",

			"latex", "bibtex",

			"regex", "diff",
		}

		local textobject_opts = {
			select = {
				enable    = true,
				lookahead = true,
				keymaps   = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
				},
			},
			move = {
				enable    = true,
				set_jumps = true,
				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
				},
				goto_prev_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
				},
			},
			swap = {
				enable        = true,
				swap_next     = { ["<leader>ap"] = "@parameter.inner" },
				swap_previous = { ["<leader>aP"] = "@parameter.inner" },
			},
		}

		if has_configs then

			configs.setup({
				ensure_installed        = parsers,
				highlight               = { enable = true },
				indent                  = { enable = true },
				autotag                 = { enable = true },
				incremental_selection   = {
					enable  = true,
					keymaps = {
						init_selection   = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				textobjects = textobject_opts,
			})
		else

			local ok, ts = pcall(require, "nvim-treesitter")
			if ok then
				ts.setup({
					ensure_installed = parsers,
					highlight        = { enable = true },
					indent           = { enable = true },
				})
			end

			local ok_autotag, autotag = pcall(require, "nvim-ts-autotag")
			if ok_autotag then autotag.setup() end

			local ok_to, to = pcall(require, "nvim-treesitter-textobjects")
			if ok_to then to.setup(textobject_opts) end

			vim.keymap.set("n", "<C-space>", function()
				pcall(vim.cmd, "TSNodeUnderCursor")
			end, { desc = "Treesitter: select node" })
		end
	end,
}

