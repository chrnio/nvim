return {

	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	build = ":MasonUpdate",
	cmd = { "Mason", "MasonInstall", "MasonUpdate" },
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed   = "",
					package_pending     = "",
					package_uninstalled = "",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {

				"rust_analyzer",

				"ts_ls",

				"gopls",

				"jdtls",

				"lua_ls",

				"jsonls",
				"yamlls",
				"taplo",

				"html",
				"cssls",

				"bashls",

				"dockerls",
				"docker_compose_language_service",

				"sqlls",

				"pyright",

				"texlab",
			},
			automatic_installation = true,
		})
	end,
}

