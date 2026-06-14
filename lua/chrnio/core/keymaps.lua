vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })
map("n", "G", "Gzz", { desc = "End of file (centered)" })

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("n", "Y", "y$", { desc = "Yank to end of line" })

map("v", "p", '"_dP', { desc = "Paste without yanking selection" })

map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

map("n", "<Esc>", "<cmd>nohl<CR>", { desc = "Clear search highlight" })

map("n", "J", "mzJ`z", { desc = "Join line (cursor fixed)" })

map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })

map("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal split sizes" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
map("n", "<leader>so", "<cmd>only<CR>", { desc = "Close all other splits" })

map("n", "<M-Up>", ":resize +2<CR>", { desc = "Increase split height" })
map("n", "<M-Down>", ":resize -2<CR>", { desc = "Decrease split height" })
map("n", "<M-Left>", ":vertical resize -4<CR>", { desc = "Decrease split width" })
map("n", "<M-Right>", ":vertical resize +4<CR>", { desc = "Increase split width" })

map("n", "<C-h>", "<C-w>h", { desc = "Focus left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus down split" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus up split" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right split" })

map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "<leader>x", "<cmd>Bdelete<CR>", { desc = "Close buffer (keep split)" })
map("n", "<leader>X", "<cmd>Bdelete!<CR>", { desc = "Force close buffer" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })

map("n", "<leader>bl", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
map("n", "<leader>bh", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })

map("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Pin/unpin buffer" })

map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file tree" })

map("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil (current dir)" })

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", { desc = "Grep word under cursor" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find open buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Search help tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>fr", "<cmd>Telescope resume<CR>", { desc = "Resume last search" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Workspace diagnostics" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Search keymaps" })

map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })

map("n", "<leader>ci", "<cmd>Telescope lsp_incoming_calls<CR>", { desc = "LSP incoming calls" })
map("n", "<leader>co", "<cmd>Telescope lsp_outgoing_calls<CR>", { desc = "LSP outgoing calls" })

map("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle Trouble (workspace)" })
map("n", "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Trouble (buffer)" })
map("n", "<leader>ts", "<cmd>Trouble symbols toggle<CR>", { desc = "Trouble symbols" })
map("n", "<leader>tl", "<cmd>Trouble lsp toggle<CR>", { desc = "Trouble LSP defs/refs" })

map({ "n", "v" }, "<leader>fm", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format (manual)" })

map("n", "]h", "<cmd>Gitsigns next_hunk<CR>zz", { desc = "Next git hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>zz", { desc = "Prev git hunk" })
map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("v", "<leader>hs", function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage selected hunk" })
map("v", "<leader>hr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset selected hunk" })
map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })
map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
map("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })
map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>", { desc = "Diff this file" })
map("n", "<leader>hi", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle inline blame" })

map("n", "<leader>cs", "<cmd>Theme<CR>", { desc = "Select colorscheme" })
map("n", "<leader>cn", "<cmd>ThemeNext<CR>", { desc = "Next colorscheme" })
map("n", "<leader>cp", "<cmd>ThemePrev<CR>", { desc = "Prev colorscheme" })

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "Save file" })

map("n", "<leader>q", "<cmd>qa<CR>", { desc = "Quit all" })

map("n", "<leader>so", "<cmd>source %<CR>", { desc = "Source current file" })

map("n", "<C-a>", "ggVG", { desc = "Select all" })

map("n", "<leader>ns", "<cmd>enew<CR>", { desc = "New scratch buffer" })

map("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle word wrap" })

map("n", "<leader>ur", "<cmd>set relativenumber!<CR>", { desc = "Toggle relative numbers" })

map("n", "<leader>rf", function()
	local old = vim.fn.expand("%")
	local new = vim.fn.input("Rename to: ", old)
	if new ~= "" and new ~= old then
		vim.cmd("saveas " .. new)
		vim.fn.delete(old)
		vim.cmd("bdelete! #")
	end
end, { desc = "Rename current file" })

