local lsp = require("charan.lsp")

local function lsp_clients()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then return "" end
    local names = {}
    for _, c in ipairs(clients) do table.insert(names, c.name) end
    return "󰒍 " .. table.concat(names, ", ")
end

local function format_status()
    return lsp.format_enabled and "󰉼 fmt" or ""
end

local function inlay_hints_status()
    return vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }) and " ih" or ""
end

require("lualine").setup({
    options = {
        theme = "auto",
        globalstatus = true,
        section_separators   = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "lazy", "dashboard" } },
    },
    sections = {
        lualine_a = {
            { "mode", separator = { left = "", right = "" }, padding = { left = 1, right = 1 } },
        },
        lualine_b = {
            { "branch", icon = "" },
            { "diff", symbols = { added = " ", modified = " ", removed = " " } },
        },
        lualine_c = {
            { lsp_clients },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = "● ", warn = "● ", info = "● ", hint = "● " },
            },
        },
        lualine_x = {
            { format_status },
            { inlay_hints_status },
            { "filetype", icon_only = false },
        },
        lualine_y = { "progress" },
        lualine_z = {
            { "location", separator = { left = "", right = "" }, padding = { left = 1, right = 1 } },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    extensions = { "oil", "lazy", "quickfix" },
})
