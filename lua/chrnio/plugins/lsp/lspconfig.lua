return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"williamboman/mason-lspconfig.nvim",
		"b0o/SchemaStore.nvim",
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap.set

		local capabilities = vim.tbl_deep_extend("force",
			vim.lsp.protocol.make_client_capabilities(),
			cmp_nvim_lsp.default_capabilities()
		)
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				spacing = 2,
				severity = { min = vim.diagnostic.severity.HINT },
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN]  = " ",
					[vim.diagnostic.severity.HINT]  = "󰠠 ",
					[vim.diagnostic.severity.INFO]  = " ",
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = { border = "rounded", source = true },
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				local client = vim.lsp.get_client_by_id(ev.data.client_id)

				if client and client.server_capabilities.semanticTokensProvider then
					client.server_capabilities.semanticTokensProvider = nil
				end

				opts.desc = "Go to declaration"
				keymap("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Go to definition"
				keymap("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "Show implementations"
				keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show type definition"
				keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "Show references"
				keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Hover documentation"
				keymap("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Signature help"
				keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				keymap("i", "<C-k>", vim.lsp.buf.signature_help, opts)

				opts.desc = "Code action"
				keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Rename symbol"
				keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Line diagnostics"
				keymap("n", "<leader>ld", vim.diagnostic.open_float, opts)

				opts.desc = "Buffer diagnostics"
				keymap("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Previous diagnostic"
				keymap("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Next diagnostic"
				keymap("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Restart LSP"
				keymap("n", "<leader>lr", "<cmd>LspRestart<CR>", opts)

				opts.desc = "LSP info"
				keymap("n", "<leader>li", "<cmd>LspInfo<CR>", opts)

				if client and client.server_capabilities.inlayHintProvider then
					opts.desc = "Toggle inlay hints"
					keymap("n", "<leader>uh", function()
						local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
						vim.lsp.inlay_hint.enable(not enabled, { bufnr = ev.buf })
						vim.notify("Inlay hints " .. (enabled and "disabled" or "enabled"))
					end, opts)
					vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
				end
			end,
		})

		local mason_ra = vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer"
		local ra_cmd = vim.uv.fs_stat(mason_ra) and { mason_ra } or { "rust-analyzer" }

		vim.lsp.config("rust_analyzer", {
			capabilities = capabilities,
			cmd = ra_cmd,
			settings = {
				["rust-analyzer"] = {
					checkOnSave = true,
					check = { command = "clippy" },
					inlayHints = {
						typeHints              = { enable = true },
						parameterHints         = { enable = false },
						chainingHints          = { enable = false },
						bindingModeHints       = { enable = false },
						closureReturnTypeHints = { enable = "never" },
						lifetimeElisionHints   = { enable = "never" },
						reborrowHints          = { enable = false },
						closingBraceHints      = { enable = false },
					},
					procMacro = { enable = true },
					cargo     = { allFeatures = true, loadOutDirsFromCheck = true },
				},
			},
		})
		vim.lsp.enable("rust_analyzer")

		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints              = "none",
						includeInlayFunctionParameterTypeHints      = false,
						includeInlayVariableTypeHints               = false,
						includeInlayPropertyDeclarationTypeHints    = false,
						includeInlayFunctionLikeReturnTypeHints     = true,
						includeInlayEnumMemberValueHints            = true,
					},
				},
			},
		})
		vim.lsp.enable("ts_ls")

		vim.lsp.config("gopls", {
			capabilities = capabilities,
			settings = {
				gopls = {
					gofumpt     = true,
					staticcheck = true,
					analyses    = { unusedparams = true, shadow = true },
					hints = {
						assignVariableTypes    = false,
						compositeLiteralFields = false,
						compositeLiteralTypes  = false,
						constantValues         = true,
						functionTypeParameters = false,
						parameterNames         = false,
						rangeVariableTypes     = false,
					},
				},
			},
		})
		vim.lsp.enable("gopls")

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime     = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace   = {
						checkThirdParty = false,
						library = vim.api.nvim_get_runtime_file("", true),
					},
					completion  = { callSnippet = "Replace" },
					hint        = { enable = false },
				},
			},
		})
		vim.lsp.enable("lua_ls")

		vim.lsp.config("jsonls", {
			capabilities = capabilities,
			settings = {
				json = {
					schemas  = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
		vim.lsp.enable("jsonls")

		vim.lsp.config("yamlls", {
			capabilities = capabilities,
			settings = {
				yaml = {
					schemaStore = { enable = false, url = "" },
					schemas     = require("schemastore").yaml.schemas(),
				},
			},
		})
		vim.lsp.enable("yamlls")

		vim.lsp.config("taplo", {
			capabilities = capabilities,
			root_markers = { "*.toml", ".git", "Cargo.toml", "pyproject.toml" },
		})
		vim.lsp.enable("taplo")

		vim.lsp.config("html",   { capabilities = capabilities })
		vim.lsp.config("cssls",  { capabilities = capabilities })
		vim.lsp.enable("html")
		vim.lsp.enable("cssls")

		vim.lsp.config("bashls", { capabilities = capabilities })
		vim.lsp.enable("bashls")

		vim.lsp.config("dockerls", { capabilities = capabilities })
		vim.lsp.config("docker_compose_language_service", { capabilities = capabilities })
		vim.lsp.enable("dockerls")
		vim.lsp.enable("docker_compose_language_service")

		vim.lsp.config("sqlls", { capabilities = capabilities })
		vim.lsp.enable("sqlls")

		vim.lsp.config("pyright", {
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						typeCheckingMode     = "basic",
						autoSearchPaths      = true,
						useLibraryCodeForTypes = true,
						diagnosticMode       = "workspace",
					},
				},
			},
		})
		vim.lsp.enable("pyright")

		vim.lsp.config("texlab", {
			capabilities = capabilities,
			settings = {
				texlab = {
					build = {
						executable = "latexmk",
						args = { "-pdf", "-shell-escape", "-interaction=nonstopmode", "-synctex=1", "%f" },
						onSave            = true,
						forwardSearchAfter = true,
					},
					forwardSearch = {
						executable = "okular",
						args       = { "--unique", "file:%p#src:%l%f" },
					},
					chktex      = { onOpenAndSave = true, onEdit = false },
					latexindent = { modifyLineBreaks = false },
				},
			},
		})
		vim.lsp.enable("texlab")
	end,
}

