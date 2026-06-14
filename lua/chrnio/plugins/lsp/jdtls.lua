return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	config = function()
		local home = vim.fn.expand("$HOME")
		local mason_path = vim.fn.stdpath("data") .. "/mason"

		local jdtls_path = mason_path .. "/packages/jdtls"
		local jdtls_bin = jdtls_path .. "/bin/jdtls"

		if vim.fn.executable(jdtls_bin) == 0 then
			vim.notify("jdtls not found at " .. jdtls_bin .. ". Run :MasonInstall jdtls", vim.log.levels.WARN)
			return
		end

		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

		local lombok_jar = jdtls_path .. "/lombok.jar"
		local vmargs = {}
		if vim.fn.filereadable(lombok_jar) == 1 then
			table.insert(vmargs, "-javaagent:" .. lombok_jar)
		end

		local bundles = {}
		local java_debug_path = mason_path .. "/packages/java-debug-adapter/extension/server"
		if vim.fn.isdirectory(java_debug_path) == 1 then
			vim.list_extend(bundles, vim.split(vim.fn.glob(java_debug_path .. "/*.jar"), "\n", { trimempty = true }))
		end
		local java_test_path = mason_path .. "/packages/java-test/extension/server"
		if vim.fn.isdirectory(java_test_path) == 1 then
			vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/*.jar"), "\n", { trimempty = true }))
		end

		local config = {
			cmd = {
				jdtls_bin,
				"-data", workspace_dir,
			},
			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
			settings = {
				java = {
					signatureHelp = { enabled = true },
					contentProvider = { preferred = "fernflower" },
					completion = {
						favoriteStaticMembers = {
							"org.junit.Assert.*",
							"org.junit.jupiter.api.Assertions.*",
							"java.util.Objects.requireNonNull",
						},
					},
					sources = {
						organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
					},
					codeGeneration = {
						toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
						useBlocks = true,
					},
					inlayHints = { parameterNames = { enabled = "none" } },
				},
			},
			init_options = {
				bundles = bundles,
				extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
			},
			on_attach = function(_, bufnr)

				local jdtls = require("jdtls")
				local opts = { buffer = bufnr, silent = true }

				vim.keymap.set("n", "<leader>jo", jdtls.organize_imports,               vim.tbl_extend("force", opts, { desc = "Java: Organize imports" }))
				vim.keymap.set("n", "<leader>jv", jdtls.extract_variable,               vim.tbl_extend("force", opts, { desc = "Java: Extract variable" }))
				vim.keymap.set("v", "<leader>jv", function() jdtls.extract_variable(true) end, vim.tbl_extend("force", opts, { desc = "Java: Extract variable (selection)" }))
				vim.keymap.set("n", "<leader>jm", jdtls.extract_method,                 vim.tbl_extend("force", opts, { desc = "Java: Extract method" }))
				vim.keymap.set("v", "<leader>jm", function() jdtls.extract_method(true) end, vim.tbl_extend("force", opts, { desc = "Java: Extract method (selection)" }))
				vim.keymap.set("n", "<leader>jc", jdtls.extract_constant,               vim.tbl_extend("force", opts, { desc = "Java: Extract constant" }))
				vim.keymap.set("n", "<leader>jt", jdtls.test_nearest_method,            vim.tbl_extend("force", opts, { desc = "Java: Test nearest method" }))
				vim.keymap.set("n", "<leader>jT", jdtls.test_class,                     vim.tbl_extend("force", opts, { desc = "Java: Test class" }))

				if #bundles > 0 then
					jdtls.setup_dap({ hotcodereplace = "auto" })
					require("jdtls.dap").setup_dap_main_class_configs()
				end
			end,
		}

		require("jdtls").start_or_attach(config)

		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*.java",
			group = vim.api.nvim_create_augroup("JdtlsAttach", { clear = true }),
			callback = function()
				if vim.bo.filetype == "java" then
					require("jdtls").start_or_attach(config)
				end
			end,
		})
	end,
}

