return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add          = { text = "│" },
			change       = { text = "│" },
			delete       = { text = "_" },
			topdelete    = { text = "‾" },
			changedelete = { text = "~" },
			untracked    = { text = "┆" },
		},
		current_line_blame = false,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 500,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local map = function(mode, lhs, rhs, opts)
				opts = vim.tbl_extend("force", { buffer = bufnr }, opts or {})
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			map("n", "]h", function()
				if vim.wo.diff then return "]h" end
				vim.schedule(function() gs.next_hunk() end)
				return "<Ignore>"
			end, { expr = true, desc = "Next git hunk" })

			map("n", "[h", function()
				if vim.wo.diff then return "[h" end
				vim.schedule(function() gs.prev_hunk() end)
				return "<Ignore>"
			end, { expr = true, desc = "Prev git hunk" })

			map("n", "<leader>hs", gs.stage_hunk,  { desc = "Stage hunk" })
			map("n", "<leader>hr", gs.reset_hunk,  { desc = "Reset hunk" })
			map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage selected" })
			map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset selected" })
			map("n", "<leader>hS", gs.stage_buffer,             { desc = "Stage buffer" })
			map("n", "<leader>hR", gs.reset_buffer,             { desc = "Reset buffer" })
			map("n", "<leader>hp", gs.preview_hunk,             { desc = "Preview hunk" })
			map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line (full)" })
			map("n", "<leader>hi", gs.toggle_current_line_blame, { desc = "Toggle inline blame" })
			map("n", "<leader>hd", gs.diffthis,                 { desc = "Diff this" })
			map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff against HEAD~1" })
		end,
	},
}

