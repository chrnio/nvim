local colorschemes = require("chrnio.core.colorschemes")

local specs = vim.tbl_map(function(item)
	local spec = {
		item.repo,
		lazy = true,
		priority = 1000,

		config = function()
			local name = item.name or vim.fn.fnamemodify(item.repo, ":t")

			if item.repo:find("tokyonight") then
				require("tokyonight").setup({ style = "night", styles = { comments = {}, keywords = {}, functions = {}, variables = {} }, italic_comments = false })

			elseif item.repo:find("catppuccin") then
				require("catppuccin").setup({ no_italic = true, flavour = "mocha" })

			elseif item.repo:find("rose%-pine") then
				require("rose-pine").setup({ styles = { italic = false } })

			elseif item.repo:find("kanagawa") then
				require("kanagawa").setup({ styles = { comments = {}, conditionals = {}, loops = {}, functions = {}, keywords = {}, strings = {}, variables = {}, numbers = {}, booleans = {}, properties = {}, types = {} } })

			elseif item.repo:find("gruvbox") then
				require("gruvbox").setup({ italic = { strings = false, emphasis = false, comments = false, operators = false, folds = false } })

			elseif item.repo:find("nightfox") then
				require("nightfox").setup({ options = { styles = { comments = "NONE", keywords = "NONE", types = "NONE", functions = "NONE", strings = "NONE", variables = "NONE" } } })

			elseif item.repo:find("cyberdream") then
				require("cyberdream").setup({ italic_comments = false })

			elseif item.repo:find("onedarkpro") then
				require("onedarkpro").setup({ styles = { types = "NONE", methods = "NONE", numbers = "NONE", strings = "NONE", comments = "NONE", keywords = "NONE", constants = "NONE", functions = "NONE", operators = "NONE", variables = "NONE", parameters = "NONE", conditionals = "NONE", virtual_text = "NONE" } })

			elseif item.repo:find("sonokai") then
				vim.g.sonokai_style = "andromeda"
				vim.g.sonokai_disable_italic_comment = 1
				vim.g.sonokai_enable_italic = 0

			elseif item.repo:find("everforest") then
				vim.g.everforest_disable_italic_comment = 1
				vim.g.everforest_enable_italic = 0

			elseif item.repo:find("edge") then
				vim.g.edge_disable_italic_comment = 1
				vim.g.edge_enable_italic = 0

			elseif item.repo:find("material") then
				require("material").setup({ disable = { colored_cursor = false }, styles = { comments = {} } })
			end
		end,
	}
	if item.name then spec.name = item.name end
	return spec
end, colorschemes.items)

local autocmd_spec = {
	"chrnio/no-italics",
	dir = vim.fn.stdpath("config"),
	lazy = false,
	priority = 999,
	config = function()
		local function strip_italics()
			local highlights = vim.api.nvim_exec2("hi", { output = true }).output
			for line in highlights:gmatch("[^\n]+") do
				local group = line:match("^(%S+)")
				if group and group ~= "" and group ~= "---" then
					local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
					if ok and hl and hl.italic then
						hl.italic = false
						pcall(vim.api.nvim_set_hl, 0, group, hl)
					end
				end
			end
		end

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("NoItalics", { clear = true }),
			callback = strip_italics,
		})
	end,
}

table.insert(specs, autocmd_spec)
return specs

