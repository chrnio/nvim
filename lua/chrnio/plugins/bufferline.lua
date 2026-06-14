return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local bufferline = require("bufferline")

		local function build_highlights()
			local function hl(name)
				return vim.api.nvim_get_hl(0, { name = name, link = false })
			end

			local normal       = hl("Normal")        or {}
			local tabline      = hl("TabLine")        or {}
			local tabline_sel  = hl("TabLineSel")     or {}
			local tabline_fill = hl("TabLineFill")    or {}
			local diag_warn    = hl("DiagnosticWarn") or {}
			local special      = hl("Special")        or {}

			local base_bg = tabline_fill.bg or tabline.bg or normal.bg
			local base_fg = tabline.fg      or normal.fg
			local sel_bg  = tabline_sel.bg  or normal.bg or base_bg
			local sel_fg  = tabline_sel.fg  or normal.fg
			local warn_fg = diag_warn.fg    or base_fg
			local ind_fg  = special.fg      or sel_fg

			local function hex(n)
				if not n then return nil end
				return string.format("#%06x", n)
			end

			local bbg = hex(base_bg)
			local bfg = hex(base_fg)
			local sbg = hex(sel_bg)
			local sfg = hex(sel_fg)
			local wfg = hex(warn_fg)
			local ifg = hex(ind_fg)

			return {
				fill                            = { bg = bbg },
				background                      = { bg = bbg, fg = bfg },
				buffer_visible                  = { bg = bbg, fg = bfg },
				buffer_selected                 = { bg = sbg, fg = sfg, bold = true },
				numbers                         = { bg = bbg, fg = bfg },
				numbers_visible                 = { bg = bbg, fg = bfg },
				numbers_selected                = { bg = sbg, fg = sfg, bold = true },
				diagnostic                      = { bg = bbg },
				diagnostic_visible              = { bg = bbg },
				diagnostic_selected             = { bg = sbg, bold = true },
				hint                            = { bg = bbg },
				hint_visible                    = { bg = bbg },
				hint_selected                   = { bg = sbg, bold = true },
				hint_diagnostic                 = { bg = bbg },
				hint_diagnostic_visible         = { bg = bbg },
				hint_diagnostic_selected        = { bg = sbg, bold = true },
				info                            = { bg = bbg },
				info_visible                    = { bg = bbg },
				info_selected                   = { bg = sbg, bold = true },
				info_diagnostic                 = { bg = bbg },
				info_diagnostic_visible         = { bg = bbg },
				info_diagnostic_selected        = { bg = sbg, bold = true },
				warning                         = { bg = bbg, fg = wfg },
				warning_visible                 = { bg = bbg, fg = wfg },
				warning_selected                = { bg = sbg, fg = wfg, bold = true },
				warning_diagnostic              = { bg = bbg, fg = wfg },
				warning_diagnostic_visible      = { bg = bbg, fg = wfg },
				warning_diagnostic_selected     = { bg = sbg, fg = wfg, bold = true },
				error                           = { bg = bbg },
				error_visible                   = { bg = bbg },
				error_selected                  = { bg = sbg, bold = true },
				error_diagnostic                = { bg = bbg },
				error_diagnostic_visible        = { bg = bbg },
				error_diagnostic_selected       = { bg = sbg, bold = true },
				modified                        = { bg = bbg, fg = wfg },
				modified_visible                = { bg = bbg, fg = wfg },
				modified_selected               = { bg = sbg, fg = wfg },

				separator                       = { bg = bbg, fg = bbg },
				separator_visible               = { bg = bbg, fg = bbg },
				separator_selected              = { bg = sbg, fg = bbg },
				offset_separator                = { bg = bbg, fg = bbg },
				indicator_selected              = { bg = sbg, fg = ifg },
				indicator_visible               = { bg = bbg },
				tab                             = { bg = bbg, fg = bfg },
				tab_selected                    = { bg = sbg, fg = sfg, bold = true },
				tab_separator                   = { bg = bbg, fg = bbg },
				tab_separator_selected          = { bg = sbg, fg = bbg },
				tab_close                       = { bg = bbg, fg = bfg },
				close_button                    = { bg = bbg, fg = bfg },
				close_button_visible            = { bg = bbg, fg = bfg },
				close_button_selected           = { bg = sbg, fg = sfg },
				pick                            = { bg = bbg, bold = true },
				pick_visible                    = { bg = bbg, bold = true },
				pick_selected                   = { bg = sbg, bold = true },
				duplicate                       = { bg = bbg, fg = bfg },
				duplicate_visible               = { bg = bbg, fg = bfg },
				duplicate_selected              = { bg = sbg, fg = sfg, bold = true },
				trunc_marker                    = { bg = bbg, fg = bfg },
			}
		end

		local function make_opts()
			return {
				highlights = build_highlights(),
				options = {
					mode = "buffers",

					separator_style = "slant",
					always_show_bufferline = true,
					sort_by = "insert_after_current",
					show_buffer_close_icons = false,
					show_close_icon = false,
					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,

					offsets = {
						{
							filetype   = "NvimTree",
							text       = "Files",
							text_align = "left",

							separator  = false,
							highlight  = "BufferLineFill",
						},
					},
				},
			}
		end

		vim.defer_fn(function()
			bufferline.setup(make_opts())
		end, 0)

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("BufferlineThemeSync", { clear = true }),
			callback = function()
				vim.defer_fn(function()
					bufferline.setup(make_opts())
				end, 0)
			end,
		})

		vim.keymap.set("n", "<Tab>",      "<cmd>BufferLineCycleNext<CR>",   { desc = "Next buffer" })
		vim.keymap.set("n", "<S-Tab>",    "<cmd>BufferLineCyclePrev<CR>",   { desc = "Prev buffer" })
		vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
		vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineMoveNext<CR>",    { desc = "Move buffer right" })
		vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineMovePrev<CR>",    { desc = "Move buffer left" })
		vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>",   { desc = "Pin/unpin buffer" })
	end,
}

