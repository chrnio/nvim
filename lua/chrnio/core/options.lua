local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.wrap = false
opt.linebreak = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.showmode = false

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.splitright = true
opt.splitbelow = true

opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"

vim.schedule(function()
	local has_provider = (
		vim.fn.executable("wl-copy") == 1 or
		vim.fn.executable("xclip")   == 1 or
		vim.fn.executable("xsel")    == 1 or
		vim.fn.executable("pbcopy")  == 1
	)
	if has_provider then
		vim.opt.clipboard = "unnamedplus"
	else
		vim.notify(
			"Clipboard: no provider found.\n" ..
			"Wayland: sudo pacman -S wl-clipboard\n" ..
			"X11:     sudo pacman -S xclip",
			vim.log.levels.WARN,
			{ title = "Neovim clipboard" }
		)
	end
end)

opt.backspace = "indent,eol,start"

opt.updatetime = 100
opt.timeoutlen = 300

opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

opt.fillchars = {
	vert = "│",
	fold = " ",
	eob = " ",
	diff = "╱",
}

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

