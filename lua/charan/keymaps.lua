local map = vim.keymap.set
local ns  = { noremap = true, silent = true }

local function save()
    if vim.bo.buftype == "" and vim.bo.modifiable then vim.cmd("w!") end
end

-- windows
map("n", "<C-h>", "<Cmd>wincmd h<CR>", ns)
map("n", "<C-j>", "<Cmd>wincmd j<CR>", ns)
map("n", "<C-k>", "<Cmd>wincmd k<CR>", ns)
map("n", "<C-l>", "<Cmd>wincmd l<CR>", ns)
map("t", "<C-h>", "<C-\\><C-n><C-w>h", ns)
map("t", "<C-j>", "<C-\\><C-n><C-w>j", ns)
map("t", "<C-k>", "<C-\\><C-n><C-w>k", ns)
map("t", "<C-l>", "<C-\\><C-n><C-w>l", ns)
map("t", "<Esc>", "<C-\\><C-n>", ns)
map("n", "<C-Up>",    "<Cmd>resize +2<CR>",          ns)
map("n", "<C-Down>",  "<Cmd>resize -2<CR>",          ns)
map("n", "<C-Left>",  "<Cmd>vertical resize -2<CR>", ns)
map("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", ns)

-- buffers
map("n", "<Tab>",   "<Cmd>bnext<CR>",     ns)
map("n", "<S-Tab>", "<Cmd>bprevious<CR>", ns)
map("n", "Q",       "<Cmd>bdelete<CR>",   ns)

map({ "n", "i", "v" }, "<C-s>", save, ns)
map("n", "<Esc>", "<Cmd>noh<CR>", { noremap = false, silent = true })

-- editing
map("i", "<Esc>", "<Esc>`^", ns)           -- keep cursor pos on escape
map("v", "p",     '"_dP',    ns)           -- paste without clobbering register
map("v", "P",     '"_dP',    ns)
map("n", "J",     "mzJ`z",   ns)           -- join lines, keep cursor
map("n", "<A-j>", "<Cmd>m .+1<CR>==",  ns)
map("n", "<A-k>", "<Cmd>m .-2<CR>==",  ns)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", ns)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", ns)
map("v", "<",     "<gv", ns)
map("v", ">",     ">gv", ns)
map("n", "x",     '"_x', ns)

-- quickfix
map("n", "]q", "<Cmd>cnext<CR>zz",     ns)
map("n", "[q", "<Cmd>cprevious<CR>zz", ns)
map("n", "]Q", "<Cmd>clast<CR>zz",     ns)
map("n", "[Q", "<Cmd>cfirst<CR>zz",    ns)

-- yank file:line to clipboard
map("n", "Y", [[<Cmd>let @+ = expand("%") . ":" . line(".")<CR>]], ns)
map("v", "Y", [[:<C-u>let @+ = expand("%") . ":" . line("'<") . "-" . line("'>")<CR>]], ns)

-- terminal
map("n", "<leader>tt", "<Cmd>split | terminal<CR>",  ns)
map("n", "<leader>tv", "<Cmd>vsplit | terminal<CR>", ns)

-- lsp
map("n", "gd",  "<Cmd>Telescope lsp_definitions<CR>",      ns)
map("n", "gr",  "<Cmd>Telescope lsp_references<CR>",       ns)
map("n", "gi",  "<Cmd>Telescope lsp_implementations<CR>",  ns)
map("n", "gt",  "<Cmd>Telescope lsp_type_definitions<CR>", ns)
map("n", "K",   vim.lsp.buf.hover,                         ns)
map("n", "<leader>rn", vim.lsp.buf.rename,                 ns)
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,   ns)
map("n", "<leader>cf", function() require("charan.lsp").format_buffer() end,   ns)
map("n", "<leader>cF", function() require("charan.lsp").toggle_format() end,   ns)
map("n", "<leader>cd", vim.diagnostic.open_float,          ns)
map("n", "[d",  function() vim.diagnostic.jump({ count = -1 }) end, ns)
map("n", "]d",  function() vim.diagnostic.jump({ count =  1 }) end, ns)
map("n", "[e",  function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, ns)
map("n", "]e",  function() vim.diagnostic.jump({ count =  1, severity = vim.diagnostic.severity.ERROR }) end, ns)
map("n", "<leader>cl", function() require("charan.lsp").toggle_virtual_lines() end, ns)
map("n", "<leader>ci", function()
    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end, ns)
map({ "n", "i" }, "<C-\\>", function() pcall(vim.lsp.buf.signature_help) end, ns)
map("n", "<leader>cs", "<Cmd>Telescope lsp_document_symbols<CR>",          ns)
map("n", "<leader>cS", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", ns)

-- telescope
map("n", "<leader><space>", "<Cmd>Telescope find_files<CR>",                ns)
map("n", "<leader>/",       "<Cmd>Telescope live_grep<CR>",                 ns)
map("n", "<leader>?",       "<Cmd>Telescope oldfiles<CR>",                  ns)
map("n", "<leader>,",       "<Cmd>Telescope buffers previewer=false<CR>",   ns)
map("n", "<leader>fw",      "<Cmd>Telescope current_buffer_fuzzy_find<CR>", ns)
map("n", "<leader>fk",      "<Cmd>Telescope keymaps<CR>",                   ns)
map("n", "<leader>fh",      "<Cmd>Telescope help_tags<CR>",                 ns)
map("n", "<leader>fd",      "<Cmd>Telescope diagnostics bufnr=0<CR>",       ns)
map("n", "<leader>fD",      "<Cmd>Telescope diagnostics<CR>",               ns)
map("n", "<leader>fr",      "<Cmd>Telescope registers<CR>",                 ns)
map("n", "<leader>ft",      "<Cmd>TodoTelescope<CR>",                       ns)
map("n", "<leader>fg",      "<Cmd>Telescope git_commits<CR>",               ns)
map("n", "<leader>fb",      "<Cmd>Telescope git_branches<CR>",              ns)
map("n", "<leader>fs",      "<Cmd>Telescope git_status<CR>",                ns)

-- oil
map("n", "<leader>e", function()
    if vim.bo.filetype == "oil" then
        pcall(vim.api.nvim_command, "b#")
    else
        vim.cmd("Oil")
    end
end, ns)
map("n", "<leader>E", "<Cmd>Oil --float<CR>", ns)

-- gitsigns
local function gs() return require("gitsigns") end
map("n", "]h", function() gs().next_hunk() end, ns)
map("n", "[h", function() gs().prev_hunk() end, ns)
map("n", "<leader>gp", function() gs().preview_hunk() end, ns)
map("n", "<leader>gs", function() gs().stage_hunk() end, ns)
map("n", "<leader>gr", function() gs().reset_hunk() end, ns)
map("v", "<leader>gs", function() gs().stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, ns)
map("v", "<leader>gr", function() gs().reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, ns)
map("n", "<leader>gS", function() gs().stage_buffer() end, ns)
map("n", "<leader>gR", function() gs().reset_buffer() end, ns)
map("n", "<leader>gu", function() gs().undo_stage_hunk() end, ns)
map("n", "<leader>gb", function() gs().blame_line({ full = true }) end, ns)
map("n", "<leader>gB", function() gs().toggle_current_line_blame() end, ns)
map("n", "<leader>gd", function() gs().diffthis() end, ns)
map("n", "<leader>gg", "<Cmd>LazyGit<CR>", ns)

-- dap
map("n", "<F5>",  function() require("dap").continue() end,          ns)
map("n", "<F10>", function() require("dap").step_over() end,         ns)
map("n", "<F11>", function() require("dap").step_into() end,         ns)
map("n", "<F12>", function() require("dap").step_out() end,          ns)
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, ns)
map("n", "<leader>dB", function()
    require("dap").set_breakpoint(vim.fn.input("Condition: "))
end, ns)
map("n", "<leader>dL", function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log msg: "))
end, ns)
map("n", "<leader>dr", function() require("dap").repl.open() end,    ns)
map("n", "<leader>dl", function() require("dap").run_last() end,     ns)
map("n", "<leader>du", function() require("dapui").toggle() end,     ns)
map("n", "<leader>dx", function() require("dap").terminate() end,    ns)
map({ "n", "v" }, "<leader>de", function() require("dapui").eval() end, ns)

-- rust
map("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end,    ns)
map("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end,  ns)
map("n", "<leader>re", function() vim.cmd.RustLsp("explainError") end, ns)
map("n", "<leader>rm", function() vim.cmd.RustLsp("expandMacro") end,  ns)
map("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end,    ns)
map("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, ns)
map("n", "<leader>rj", function() vim.cmd.RustLsp("joinLines") end,    ns)

-- misc
map("n", "<leader>l",  "<Cmd>Lazy<CR>",                               ns)
map("n", "<leader>th", function() require("charan.theme").pick() end, ns)
map("n", "<leader>n",  "<Cmd>NoNeckPain<CR>",                         ns)
map("n", "<leader>ih", "<Cmd>Inspect<CR>",                            ns)
