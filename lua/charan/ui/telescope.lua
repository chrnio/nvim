local ts      = require("telescope")
local actions = require("telescope.actions")

local round          = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
local combine_top    = { "─", "│", " ", "│", "╭", "╮", "│", "│" }
local combine_bottom = { "─", "│", "─", "│", "├", "┤", "╯", "╰" }

local keymaps = {
    i = {
        ["<Esc>"]   = actions.close,
        ["<C-Esc>"] = actions.close,
        ["<C-q>"]   = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-j>"]   = actions.move_selection_next,
        ["<C-k>"]   = actions.move_selection_previous,
    },
    n = { ["<Esc>"] = actions.close, ["q"] = actions.close },
}

local base = {
    previewer        = false,
    results_title    = false,
    border           = true,
    borderchars      = { prompt = combine_top, results = combine_bottom, preview = round },
    sort_mru         = true,
    sorting_strategy = "ascending",
    layout_config    = { prompt_position = "top" },
    entry_prefix     = "   ",
    prompt_prefix    = "   ",
    selection_caret  = "   ",
    hl_result_eol    = true,
    wrap_results     = true,
    winblend         = 0,
    mappings         = keymaps,
}

local no_preview_large = vim.tbl_deep_extend("force", base, {
    layout_strategy = "center",
    layout_config   = { height = 39, width = 141, prompt_position = "top" },
})

local no_preview_small = vim.tbl_deep_extend("force", base, {
    layout_strategy = "center",
    layout_config   = { height = 30, width = 120, prompt_position = "top" },
})

local with_preview = vim.tbl_deep_extend("force", base, {
    previewer       = true,
    borderchars     = { prompt = round, results = round, preview = round },
    layout_strategy = "vertical",
    layout_config   = { height = 0.95, width = 141, preview_height = 0.35, mirror = true, prompt_position = "top" },
})

ts.setup({
    defaults = no_preview_large,
    pickers = {
        find_files  = no_preview_small,
        oldfiles    = no_preview_small,
        buffers     = vim.tbl_deep_extend("force", no_preview_small, {
            ignore_current_buffer = true,
            sort_mru = true,
        }),
        registers   = no_preview_small,
        keymaps     = no_preview_small,
        live_grep   = with_preview,
        lsp_references           = with_preview,
        lsp_definitions          = with_preview,
        lsp_implementations      = with_preview,
        lsp_type_definitions     = with_preview,
        diagnostics              = with_preview,
        lsp_document_symbols     = vim.tbl_deep_extend("force", with_preview, { show_line = false }),
        lsp_dynamic_workspace_symbols = vim.tbl_deep_extend("force", with_preview, {
            show_line    = false,
            path_display = { "hidden" },
        }),
        git_commits = with_preview,
        git_status  = with_preview,
        help_tags   = vim.tbl_deep_extend("force", no_preview_small, {
            mappings = { i = { ["<CR>"] = actions.select_vertical } },
        }),
    },
    extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
        fzf = {
            fuzzy                   = true,
            override_generic_sorter = true,
            override_file_sorter    = true,
        },
    },
})

ts.load_extension("ui-select")
ts.load_extension("fzf")

-- show line numbers in previewer
vim.api.nvim_create_autocmd("User", {
    pattern  = "TelescopePreviewerLoaded",
    callback = function() vim.opt_local.number = true end,
})
