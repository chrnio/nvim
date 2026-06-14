local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
	group = augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

autocmd("BufWritePre", {
	group = augroup("TrimWhitespace", { clear = true }),
	pattern = "*",
	callback = function()
		local ft = vim.bo.filetype

		if ft == "diff" or ft == "git" then return end
		local save = vim.fn.winsaveview()
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(save)
	end,
})

autocmd("BufReadPost", {
	group = augroup("RestoreCursor", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

autocmd("FileType", {
	group = augroup("LangIndent", { clear = true }),
	callback = function(args)
		local ft = vim.bo[args.buf].filetype

		if ft == "go" then
			vim.bo[args.buf].expandtab = false
			vim.bo[args.buf].tabstop = 4
			vim.bo[args.buf].shiftwidth = 4
		end

		if ft == "java" then
			vim.bo[args.buf].tabstop = 4
			vim.bo[args.buf].shiftwidth = 4
			vim.bo[args.buf].expandtab = true
		end

		if vim.tbl_contains({ "typescript", "typescriptreact", "javascript", "javascriptreact", "json", "html", "css", "scss", "yaml", "toml" }, ft) then
			vim.bo[args.buf].tabstop = 2
			vim.bo[args.buf].shiftwidth = 2
			vim.bo[args.buf].expandtab = true
		end

		if ft == "lua" then
			vim.bo[args.buf].tabstop = 2
			vim.bo[args.buf].shiftwidth = 2
			vim.bo[args.buf].expandtab = true
		end

		if ft == "markdown" then
			vim.wo.wrap = true
			vim.wo.spell = true
		end
	end,
})

autocmd("FileType", {
	group = augroup("QuickClose", { clear = true }),
	pattern = { "help", "man", "qf", "lspinfo", "notify", "checkhealth", "startuptime" },
	callback = function(args)
		vim.bo[args.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = args.buf, silent = true })
	end,
})

autocmd("BufWritePre", {
	group = augroup("AutoMkdir", { clear = true }),
	callback = function(args)
		local path = args.match
		local dir = vim.fn.fnamemodify(path, ":h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

autocmd("VimResized", {
	group = augroup("ResizeSplits", { clear = true }),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

autocmd("ModeChanged", {
	group = augroup("DiagnosticMode", { clear = true }),
	pattern = { "n:i", "v:i" },
	callback = function()
		vim.diagnostic.enable(false, { bufnr = 0 })
	end,
})
autocmd("ModeChanged", {
	group = augroup("DiagnosticModeRestore", { clear = true }),
	pattern = "i:n",
	callback = function()
		vim.diagnostic.enable(true, { bufnr = 0 })
	end,
})

