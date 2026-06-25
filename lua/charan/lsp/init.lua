local M = {}

-- rounded borders on all lsp floats
local orig = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig(contents, syntax, opts, ...)
end

local signs = {
    text = {
        [vim.diagnostic.severity.ERROR] = "●",
        [vim.diagnostic.severity.WARN]  = "●",
        [vim.diagnostic.severity.INFO]  = "●",
        [vim.diagnostic.severity.HINT]  = "●",
    },
}

local diag_cfg = {
    signs = signs,
    virtual_text = false,
    update_in_insert = true,
    severity_sort = true,
    float = { border = "rounded", prefix = "  ", header = "" },
}

M.virtual_lines = false

function M.toggle_virtual_lines()
    M.virtual_lines = not M.virtual_lines
    diag_cfg.virtual_lines = M.virtual_lines
    vim.diagnostic.config(diag_cfg)
end

vim.diagnostic.config(diag_cfg)

M.format_enabled = false

function M.toggle_format()
    M.format_enabled = not M.format_enabled
    vim.notify("Format on save: " .. (M.format_enabled and "ON" or "OFF"))
end

function M.format_buffer()
    local ft = vim.bo.filetype
    vim.lsp.buf.format({
        async = false,
        timeout_ms = 10000,
        filter = function(client)
            if ft == "java" then return client.name == "jdtls" end
            return true
        end,
    })
end

vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        if M.format_enabled then M.format_buffer() end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("charanLspAttach", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then return end

        if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        end

        if client:supports_method("textDocument/completion") then
            vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, { buffer = ev.buf })
            vim.keymap.set("i", "<CR>", function()
                return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
            end, { buffer = ev.buf, expr = true })
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- round the completion detail popup border
vim.api.nvim_create_autocmd("CompleteChanged", {
    group = vim.api.nvim_create_augroup("charanCmpBorder", { clear = true }),
    callback = function()
        vim.schedule(function()
            local winid = vim.fn.complete_info({ "preview_winid" }).preview_winid
            if winid and winid >= 0 and vim.api.nvim_win_is_valid(winid) then
                pcall(vim.api.nvim_win_set_config, winid, { border = "rounded" })
            end
        end)
    end,
})

vim.lsp.config("*", {
    capabilities = {
        textDocument = {
            completion = { completionItem = { snippetSupport = true } },
        },
    },
})

vim.lsp.enable({
    "lua_ls", "pyright", "ts_ls", "eslint", "jsonls", "yamlls",
    "dockerls", "docker_compose_language_service", "bashls",
    "html", "cssls", "taplo", "lemminx", "helm_ls",
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            hint = { enable = true },
        },
    },
})

vim.lsp.config("pyright", {
    settings = {
        pyright = { autoImportCompletion = true },
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
            },
        },
    },
})

vim.lsp.config("ts_ls", {
    settings = {
        typescript = { inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
        }},
        javascript = { inlayHints = {
            includeInlayParameterNameHints = "all",
        }},
    },
})

vim.lsp.config("yamlls", {
    settings = {
        yaml = {
            keyOrdering = false,
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = { "docker-compose*.yml", "compose*.yml" },
                ["https://json.schemastore.org/helmfile.json"] = "helmfile.yaml",
            },
        },
    },
})

vim.lsp.config("helm_ls", {
    settings = {
        ["helm-ls"] = { yamlls = { path = "yaml-language-server" } },
    },
})

return M
