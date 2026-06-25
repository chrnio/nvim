local dap   = require("dap")
local dapui = require("dapui")

-- open/close ui automatically with sessions
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

dapui.setup({
    icons = { expanded = "", collapsed = "", current_frame = "" },
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open   = "o",
        remove = "d",
        edit   = "e",
        repl   = "r",
        toggle = "t",
    },
    layouts = {
        {
            elements = {
                { id = "scopes",      size = 0.35 },
                { id = "breakpoints", size = 0.15 },
                { id = "stacks",      size = 0.30 },
                { id = "watches",     size = 0.20 },
            },
            size = 45,
            position = "left",
        },
        {
            elements = {
                { id = "repl",    size = 0.5 },
                { id = "console", size = 0.5 },
            },
            size = 12,
            position = "bottom",
        },
    },
    floating = { border = "rounded" },
    render = { indent = 1 },
})

require("nvim-dap-virtual-text").setup({
    enabled = true,
    highlight_changed_variables = true,
    virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
})

vim.fn.sign_define("DapBreakpoint",          { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn",  linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint",            { text = "", texthl = "DiagnosticInfo",  linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped",             { text = "→", texthl = "DiagnosticOk",  linehl = "Visual", numhl = "" })

-- python via debugpy
dap.adapters.python = {
    type    = "executable",
    command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
    args    = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
    {
        type    = "python",
        request = "launch",
        name    = "Launch file",
        program = "${file}",
        pythonPath = function()
            local venv = os.getenv("VIRTUAL_ENV")
            return venv and (venv .. "/bin/python") or vim.fn.exepath("python3") or "python3"
        end,
    },
    {
        type    = "python",
        request = "launch",
        name    = "Launch with args",
        program = "${file}",
        args    = function() return vim.split(vim.fn.input("Args: "), " ") end,
        pythonPath = function()
            local venv = os.getenv("VIRTUAL_ENV")
            return venv and (venv .. "/bin/python") or vim.fn.exepath("python3") or "python3"
        end,
    },
}

-- js/ts via js-debug-adapter
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
        },
    },
}
for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
    dap.configurations[ft] = {
        {
            type    = "pwa-node",
            request = "launch",
            name    = "Launch file",
            program = "${file}",
            cwd     = "${workspaceFolder}",
        },
        {
            type      = "pwa-node",
            request   = "attach",
            name      = "Attach",
            processId = require("dap.utils").pick_process,
            cwd       = "${workspaceFolder}",
        },
    }
end

-- rust/c/c++ via codelldb (rustaceanvim also uses this adapter)
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
        args    = { "--port", "${port}" },
    },
}
