local M = {}

M.items = {

	{ repo = "oskarnurm/koda.nvim",          name = nil,        schemes = { "koda", "koda-dark", "koda-light", "koda-glade", "koda-moss" } },
	{ repo = "andreypopp/vim-colors-plain",   name = nil,        schemes = { "plain" } },
	{ repo = "rebelot/kanagawa.nvim",         name = nil,        schemes = { "kanagawa", "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus" } },
	{ repo = "rose-pine/neovim",              name = "rose-pine", schemes = { "rose-pine", "rose-pine-main", "rose-pine-moon", "rose-pine-dawn" } },
	{ repo = "ellisonleao/gruvbox.nvim",      name = nil,        schemes = { "gruvbox" } },
	{ repo = "shaunsingh/nord.nvim",          name = nil,        schemes = { "nord" } },
	{ repo = "navarasu/onedark.nvim",         name = nil,        schemes = { "onedark" } },
	{ repo = "EdenEast/nightfox.nvim",        name = nil,        schemes = { "nightfox", "dayfox", "dawnfox", "duskfox", "nordfox", "terafox", "carbonfox" } },
	{ repo = "sainnhe/everforest",            name = nil,        schemes = { "everforest" } },
	{ repo = "sainnhe/edge",                  name = nil,        schemes = { "edge" } },
	{ repo = "marko-cerovac/material.nvim",   name = nil,        schemes = { "material", "material-darker", "material-deep-ocean", "material-oceanic", "material-palenight" } },
	{ repo = "Mofiqul/dracula.nvim",          name = nil,        schemes = { "dracula", "dracula-soft" } },
	{ repo = "projekt0n/github-nvim-theme",   name = nil,        schemes = { "github_dark", "github_dark_dimmed", "github_dark_high_contrast", "github_light", "github_light_default" } },
	{ repo = "nyoom-engineering/oxocarbon.nvim", name = nil,     schemes = { "oxocarbon" } },
	{ repo = "RRethy/base16-nvim",            name = nil,        schemes = { "base16-default-dark" } },

	{ repo = "folke/tokyonight.nvim",         name = nil,        schemes = { "tokyonight", "tokyonight-night", "tokyonight-storm", "tokyonight-moon" } },
	{ repo = "catppuccin/nvim",               name = "catppuccin", schemes = { "catppuccin", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha" } },
	{ repo = "sainnhe/sonokai",               name = nil,        schemes = { "sonokai" } },
	{ repo = "bluz71/vim-moonfly-colors",     name = "moonfly",  schemes = { "moonfly" } },
	{ repo = "scottmckendry/cyberdream.nvim", name = nil,        schemes = { "cyberdream" } },
	{ repo = "olimorris/onedarkpro.nvim",     name = nil,        schemes = { "onedark_pro", "onedark_vivid", "onedark_dark" } },
}

function M.names()
	local names = {}
	for _, item in ipairs(M.items) do
		vim.list_extend(names, item.schemes)
	end
	return names
end

return M

