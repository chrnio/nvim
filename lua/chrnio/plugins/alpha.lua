return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			"                                                          ",
			"  ######  ##     ## ########  ##    ## ####  #######      ",
			" ##    ## ##     ## ##     ## ###   ##  ##  ##     ##     ",
			" ##       ##     ## ##     ## ####  ##  ##  ##     ##     ",
			" ##       ######### ########  ## ## ##  ##  ##     ##     ",
			" ##       ##     ## ##   ##   ##  ####  ##  ##     ##     ",
			" ##    ## ##     ## ##    ##  ##   ###  ##  ##     ##     ",
			"  ######  ##     ## ##     ## ##    ## ####  #######      ",
			"                                                          ",
		}

		dashboard.section.buttons.val = {
			dashboard.button("f", "  Find file",       "<cmd>Telescope find_files<CR>"),
			dashboard.button("r", "  Recent files",    "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("w", "  Live grep",       "<cmd>Telescope live_grep<CR>"),
			dashboard.button("e", "  New file",        "<cmd>ene<CR>"),
			dashboard.button("l", "  Lazy",            "<cmd>Lazy<CR>"),
			dashboard.button("c", "  Config",          "<cmd>e " .. vim.fn.stdpath("config") .. "/init.lua<CR>"),
			dashboard.button("q", "  Quit",            "<cmd>qa<CR>"),
		}

		dashboard.section.footer.val = function()
			local stats = require("lazy").stats()
			return string.format(
				"  %d plugins loaded in %.0fms",
				stats.loaded,
				stats.startuptime
			)
		end

		dashboard.section.footer.opts.hl = "Comment"
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"

		dashboard.opts.layout = {
			{ type = "padding", val = 4 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 2 },
			dashboard.section.footer,
		}

		alpha.setup(dashboard.opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "alpha",
			callback = function()
				vim.opt_local.foldenable = false
				vim.opt_local.laststatus = 0
			end,
		})
		vim.api.nvim_create_autocmd("BufUnload", {
			pattern = "<buffer>",
			callback = function()
				vim.opt.laststatus = 2
			end,
		})
	end,
}

