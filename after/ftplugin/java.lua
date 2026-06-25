local mason_data  = vim.fn.stdpath("data") .. "/mason/packages"
local jdtls       = require("jdtls")
local jdtls_setup = require("jdtls.setup")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace    = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

-- load java-debug and java-test bundles for dap support
local bundles = {}
vim.list_extend(bundles, vim.fn.glob(mason_data .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true, true))
vim.list_extend(bundles, vim.fn.glob(mason_data .. "/java-test/extension/server/*.jar", true, true))

local config = {
    cmd      = { "jdtls", "-data", workspace },
    root_dir = jdtls_setup.find_root({ "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }),
    settings = {
        java = {
            eclipse         = { downloadSources = true },
            maven           = { downloadSources = true },
            referencesCodeLens = { enabled = true },
            signatureHelp      = { enabled = true },
            contentProvider    = { preferred = "fernflower" },
            completion = {
                favoriteStaticMembers = {
                    "org.assertj.core.api.Assertions.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "org.mockito.Mockito.*",
                },
                importOrder = { "java", "javax", "com", "org" },
            },
            sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
            codeGeneration = {
                toString  = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
                useBlocks = true,
            },
            format = { enabled = true, settings = { tabSize = 4 } },
        },
    },
    init_options = { bundles = bundles },
    on_attach = function(_, bufnr)
        jdtls.setup_dap({ hotcodereplace = "auto" })
        jdtls_setup.add_commands()
        local opts = { buffer = bufnr, noremap = true, silent = true }
        local ext = function(desc) return vim.tbl_extend("force", opts, { desc = desc }) end
        vim.keymap.set("n", "<leader>Jo", jdtls.organize_imports,                      ext("Organize imports"))
        vim.keymap.set("n", "<leader>Jv", jdtls.extract_variable,                      ext("Extract variable"))
        vim.keymap.set("n", "<leader>Jc", jdtls.extract_constant,                      ext("Extract constant"))
        vim.keymap.set("v", "<leader>Jm", function() jdtls.extract_method(true) end,   ext("Extract method"))
        vim.keymap.set("n", "<leader>Jt", jdtls.test_nearest_method,                   ext("Test method"))
        vim.keymap.set("n", "<leader>JT", jdtls.test_class,                            ext("Test class"))
    end,
}

jdtls.start_or_attach(config)
