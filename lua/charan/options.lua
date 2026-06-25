vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cmdheight = 1
vim.opt.pumheight = 12
vim.opt.pumblend = 0
vim.opt.winblend = 0
vim.opt.laststatus = 3
vim.opt.showtabline = 0
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.fillchars = { eob = " ", diff = "╱", vert = "│" }

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.textwidth = 0

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.inccommand = "nosplit"

vim.opt.swapfile = false
vim.opt.autowrite = false
vim.opt.autoread = true
vim.opt.fixeol = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

vim.opt.clipboard:append("unnamedplus")
vim.opt.completeopt = { "menuone", "fuzzy", "popup", "noselect" }
vim.opt.pumborder = "rounded"
vim.opt.complete = "."
vim.opt.mouse = ""
vim.opt.splitbelow = true
vim.opt.splitright = true

-- let terminal control background opacity
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("charanTransparent", { clear = true }),
    callback = function()
        for _, g in ipairs({ "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer" }) do
            vim.api.nvim_set_hl(0, g, { bg = "NONE" })
        end
    end,
})

-- strip italics from everything except comments
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("charanItalics", { clear = true }),
    callback = function()
        local no_italic = {
            "String", "Number", "Boolean", "Constant", "Type", "Keyword",
            "Function", "Identifier", "Statement", "@keyword", "@keyword.return",
            "@type", "@type.builtin", "@variable", "@variable.builtin",
            "@property", "@parameter", "@function", "@method", "@string",
        }
        for _, g in ipairs(no_italic) do
            local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = g, link = false })
            if ok and hl and hl.italic then
                hl.italic = false
                pcall(vim.api.nvim_set_hl, 0, g, hl)
            end
        end
        local ok, chl = pcall(vim.api.nvim_get_hl, 0, { name = "Comment", link = false })
        if ok and chl then
            chl.italic = true
            pcall(vim.api.nvim_set_hl, 0, "Comment", chl)
        end
    end,
})

vim.cmd("filetype plugin indent on")
