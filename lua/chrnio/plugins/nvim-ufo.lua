return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "zR", function() require("ufo").openAllFolds() end,  desc = "Open all folds" },
		{ "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
		{ "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" },
		{ "zm", function() require("ufo").closeFoldsWith() end, desc = "Close folds with count" },
		{ "K", function()
			local ufo = require("ufo")
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, desc = "Peek fold or show hover" },
	},
	opts = {
		provider_selector = function(_, filetype, buftype)

			local lsp_fts = { "rust", "go", "java", "typescript", "typescriptreact", "javascript", "lua" }
			if vim.tbl_contains(lsp_fts, filetype) then
				return { "lsp", "treesitter" }
			end
			if buftype == "nofile" then return "" end
			return { "treesitter", "indent" }
		end,

		fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = ("  %d lines"):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "Comment" })
			return newVirtText
		end,
	},
}

