return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",

		"leoluz/nvim-dap-go",
	},
	keys = {
		{ "<leader>dc", function() require("dap").continue() end,          desc = "DAP: Continue" },
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
		{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "DAP: Conditional breakpoint" },
		{ "<leader>ds", function() require("dap").step_over() end,         desc = "DAP: Step over" },
		{ "<leader>di", function() require("dap").step_into() end,         desc = "DAP: Step into" },
		{ "<leader>do", function() require("dap").step_out() end,          desc = "DAP: Step out" },
		{ "<leader>dr", function() require("dap").restart() end,           desc = "DAP: Restart" },
		{ "<leader>dt", function() require("dap").terminate() end,         desc = "DAP: Terminate" },
		{ "<leader>du", function() require("dapui").toggle() end,          desc = "DAP: Toggle UI" },
		{ "<leader>dR", function() require("dap").repl.open() end,         desc = "DAP: Open REPL" },
		{ "<leader>dw", function()
			local expr = vim.fn.input("Watch expression: ")
			if expr ~= "" then require("dapui").elements.watches.add(expr) end
		end, desc = "DAP: Add watch" },
		{ "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "DAP: Eval expression" },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup({
			layouts = {
				{
					elements = {
						{ id = "scopes",      size = 0.35 },
						{ id = "breakpoints", size = 0.20 },
						{ id = "stacks",      size = 0.25 },
						{ id = "watches",     size = 0.20 },
					},
					size = 40,
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
			controls = { enabled = false },
			floating = { border = "rounded" },
		})

		dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
		dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
		dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

		require("nvim-dap-virtual-text").setup({
			commented = false,
			virt_text_pos = "eol",
		})

		local uv = vim.uv or vim.loop

		local function file_exists(path)
			return path and uv.fs_stat(path) ~= nil
		end

		local function workspace_root()
			local current = vim.api.nvim_buf_get_name(0)
			local markers = { ".git", "Cargo.toml", "package.json", "go.mod", "build.gradle", "pom.xml", "Makefile" }
			local root = vim.fs.dirname(vim.fs.find(markers, {
				path = current ~= "" and current or vim.fn.getcwd(),
				upward = true,
			})[1] or "")
			return root ~= "" and root or vim.fn.getcwd()
		end

		local function pick_binary()
			local cwd = workspace_root()
			local stem = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t:r")
			local candidates = {
				cwd .. "/" .. stem,
				cwd .. "/target/debug/" .. stem,
				cwd .. "/build/" .. stem,
				cwd .. "/bin/" .. stem,
			}
			for _, c in ipairs(candidates) do
				if file_exists(c) then
					vim.notify("DAP: launching " .. c, vim.log.levels.INFO)
					return c
				end
			end
			local picked = vim.fn.input("Path to executable: ", cwd .. "/", "file")
			return picked ~= "" and picked or nil
		end

		local lldb_dap = vim.fn.exepath("lldb-dap")
		local codelldb = vim.fn.exepath("codelldb")

		if lldb_dap ~= "" then
			dap.adapters.lldb = { type = "executable", command = lldb_dap, name = "lldb" }
		elseif codelldb ~= "" then
			dap.adapters.lldb = {
				type = "server",
				port = "${port}",
				executable = { command = codelldb, args = { "--port", "${port}" } },
			}
		else
			vim.notify("DAP: no Rust/C adapter found (install lldb-dap or codelldb)", vim.log.levels.WARN)
		end

		local lldb_configs = {
			{ name = "Launch",             type = "lldb", request = "launch", program = pick_binary, cwd = "${workspaceFolder}", stopOnEntry = false },
			{ name = "Launch with args",   type = "lldb", request = "launch", program = pick_binary,
			  args = function()
				local args = {}
				for arg in vim.fn.input("Args: "):gmatch("%S+") do
					table.insert(args, arg)
				end
				return args
			  end,
			  cwd = "${workspaceFolder}", stopOnEntry = false },
			{ name = "Attach to process",  type = "lldb", request = "attach", pid = require("dap.utils").pick_process, cwd = "${workspaceFolder}" },
		}

		dap.configurations.rust = lldb_configs
		dap.configurations.c    = lldb_configs
		dap.configurations.cpp  = lldb_configs

		require("dap-go").setup({
			dap_configurations = {
				{ type = "go", name = "Debug",             request = "launch", program = "${file}" },
				{ type = "go", name = "Debug package",     request = "launch", program = "${fileDirname}" },
				{ type = "go", name = "Attach to process", request = "attach", processId = require("dap.utils").pick_process, mode = "local" },
			},
		})

		local vscode_js_debug = vim.fn.exepath("js-debug-adapter")
		if vscode_js_debug ~= "" then
			for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
				dap.adapters[adapter] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = { command = vscode_js_debug, args = { "${port}" } },
				}
			end
			for _, ft in ipairs({ "typescript", "javascript", "typescriptreact" }) do
				dap.configurations[ft] = {
					{ name = "Launch Node file", type = "pwa-node", request = "launch", program = "${file}", cwd = "${workspaceFolder}", sourceMaps = true },
					{ name = "Attach to Node",   type = "pwa-node", request = "attach", processId = require("dap.utils").pick_process, cwd = "${workspaceFolder}" },
				}
			end
		end

		vim.fn.sign_define("DapBreakpoint",          { text = "", texthl = "DiagnosticError" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn" })
		vim.fn.sign_define("DapBreakpointRejected",  { text = "", texthl = "Comment" })
		vim.fn.sign_define("DapLogPoint",            { text = "󰆹", texthl = "DiagnosticInfo" })
		vim.fn.sign_define("DapStopped",             { text = "", texthl = "DiagnosticOk", linehl = "DapStoppedLine", numhl = "" })
	end,
}

