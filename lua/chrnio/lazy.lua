local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local ts_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
if vim.uv.fs_stat(ts_path) then
	local has_configs = vim.uv.fs_stat(ts_path .. "/lua/nvim-treesitter/configs.lua")
	local has_configs_old = vim.uv.fs_stat(ts_path .. "/lua/nvim-treesitter.lua")

	if not has_configs and has_configs_old then
		vim.fn.delete(ts_path, "rf")
		vim.notify(
			"nvim-treesitter: stale main-branch install removed.\n" ..
			"Re-installing from master on next lazy sync.\n" ..
			"Run :Lazy sync now.",
			vim.log.levels.WARN,
			{ title = "Treesitter" }
		)
	end
end

require("lazy").setup({
	{ import = "chrnio.plugins" },
	{ import = "chrnio.plugins.lsp" },
}, {
	install = {
		colorscheme = { "tokyonight-night", "habamax" },
	},
	checker = {
		enabled = true,
		notify  = false,
	},
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin",
				"netrwPlugin", "matchparen", "matchit",
			},
		},
	},
	ui = {
		border = "rounded",
	},
})

require("chrnio.core.theme").setup()

