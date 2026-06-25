local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    -- themes (all lazy, loaded on demand by theme.lua)
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        opts = {
            flavour = "mocha",
            integrations = {
                telescope = true, gitsigns = true,
                indent_blankline = { enabled = true },
                mason = true, which_key = true, nvim_surround = true,
            },
        },
    },
    { "bluz71/vim-moonfly-colors",      name = "moonfly",         lazy = true },
    { "oskarnurm/koda.nvim", name = "koda-dark", lazy = true, opts = {} },
    { "sainnhe/gruvbox-material",       lazy = true, config = function()
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_better_performance = 1
    end },
    { "navarasu/onedark.nvim",          lazy = true, opts = { style = "darker" } },
    { "scottmckendry/cyberdream.nvim",  lazy = true, opts = { italic_comments = true } },
    { "eldritch-theme/eldritch.nvim",   lazy = true, opts = { style = "darker" } },
    { "AlexvZyl/nordic.nvim",           lazy = true },
    { "craftzdog/solarized-osaka.nvim", lazy = true, opts = { transparent = false } },
    { "folke/tokyonight.nvim",          lazy = true, opts = { style = "night" } },

    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function() require("charan.ui.lualine") end,
    },

    -- indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        opts = {
            exclude = { filetypes = { "help", "markdown", "lazy", "oil" } },
            scope = {
                enabled    = true,
                show_start = false,
                show_end   = false,
                char       = "┆",
                highlight  = { "IblScope" },
            },
            indent = { char = "┆", highlight = { "IblIndent" } },
        },
    },

    -- keymap hints popup
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            icons = { mappings = false },
            win = { border = "rounded" },
            spec = {
                { "<leader>c", group = "code/lsp" },
                { "<leader>d", group = "debug" },
                { "<leader>f", group = "find" },
                { "<leader>g", group = "git" },
                { "<leader>r", group = "rust" },
                { "<leader>t", group = "terminal/theme" },
            },
        },
    },

    -- centered writing mode
    {
        "shortcuts/no-neck-pain.nvim",
        cmd = "NoNeckPain",
        opts = { width = 140 },
    },

    -- highlights TODO/FIXME/etc
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },

    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- file explorer
    {
        "stevearc/oil.nvim",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                delete_to_trash = true,
                watch_for_changes = true,
                default_file_explorer = true,
                view_options = { show_hidden = true },
                float = { border = "rounded" },
                keymaps = {
                    ["<CR>"]  = "actions.select",
                    ["-"]     = "actions.parent",
                    ["<C-s>"] = false,
                    ["<C-h>"] = false,
                    ["<C-l>"] = false,
                },
                use_default_keymaps = false,
            })
        end,
    },

    -- fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function() require("charan.ui.telescope") end,
    },

    -- jump anywhere on screen
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end },
            { "r",     mode = "o",               function() require("flash").remote() end },
            { "<C-s>", mode = { "c" },            function() require("flash").toggle() end },
        },
    },

    { "kylechui/nvim-surround",  event = "VeryLazy",    opts = {} },
    { "windwp/nvim-autopairs",   event = "InsertEnter", opts = { check_ts = true } },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            require("ts_context_commentstring").setup({ enable_autocmd = false })
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },

    -- syntax + text objects
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        -- textobjects still uses the old API on its own branch, pin treesitter to master
        branch = "master",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        config = function() require("charan.ui.treesitter") end,
    },

    -- git hunk signs + blame
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        opts = {
            signs = {
                add          = { text = "│" },
                change       = { text = "│" },
                delete       = { text = "│" },
                topdelete    = { text = "│" },
                changedelete = { text = "│" },
                untracked    = { text = "│" },
            },
            signs_staged_enable = true,
        },
    },

    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- lsp + mason
    { "neovim/nvim-lspconfig", lazy = true },
    {
        "mason-org/mason.nvim",
        lazy = false,
        priority = 900,
        opts = {
            ui = {
                border = "rounded",
                icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
            },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
        opts = {
            ensure_installed = {
                "lua_ls", "pyright", "ts_ls", "eslint", "jsonls", "yamlls",
                "dockerls", "docker_compose_language_service", "bashls",
                "html", "cssls", "taplo", "lemminx",
            },
        },
    },

    -- lua api completion
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = { library = { { path = "luvit-meta/library", words = { "vim%.uv" } } } },
    },
    { "Bilal2453/luvit-meta", lazy = true },

    -- rust lsp + dap (manages rust-analyzer itself, don't use mason for it)
    {
        "mrcjkb/rustaceanvim",
        version = "^9",
        ft = "rust",
        config = function()
            vim.g.rustaceanvim = {
                tools = {
                    hover_actions = { auto_focus = false },
                    float_win_config = { border = "rounded" },
                },
                server = {
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = { allFeatures = true },
                            checkOnSave = { command = "clippy" },
                            inlayHints = { enable = true },
                        },
                    },
                },
                dap = {
                    adapter = {
                        type = "server",
                        port = "${port}",
                        executable = {
                            command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
                            args = { "--port", "${port}" },
                        },
                    },
                },
            }
        end,
    },

    -- cargo.toml helper
    {
        "Saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        opts = { completion = { cmp = { enabled = false }, lsp = { enabled = true } } },
        keys = {
            { "<leader>cu", function() require("crates").upgrade_all_crates() end, desc = "Upgrade all crates" },
            { "<leader>co", function() require("crates").show_popup() end,         desc = "Crates info" },
        },
    },

    -- java lsp (config lives in after/ftplugin/java.lua)
    { "mfussenegger/nvim-jdtls", ft = "java" },

    -- python venv switcher
    {
        "linux-cultist/venv-selector.nvim",
        branch = "regexp",
        ft = "python",
        opts = { settings = { options = { notify_user_on_venv_activation = true } } },
        keys = { { "<leader>pv", "<Cmd>VenvSelect<CR>", desc = "Select venv" } },
    },

    -- debugger
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            {
                "jay-babu/mason-nvim-dap.nvim",
                opts = {
                    ensure_installed = { "codelldb", "debugpy", "js-debug-adapter" },
                    automatic_installation = true,
                    handlers = {},
                },
            },
        },
        config = function() require("charan.dap") end,
        keys = { "<F5>", "<F10>", "<F11>", "<F12>", "<leader>db" },
    },

    -- better quickfix
    { "stevearc/quicker.nvim", event = "FileType qf", opts = {} },

    -- tmux pane navigation passthrough
    { "aserowy/tmux.nvim", event = "VeryLazy", opts = {} },

    { "nvim-lua/plenary.nvim", lazy = true },

}, {
    ui = { border = "rounded", backdrop = 100 },
    checker = { enabled = true, notify = false },
    defaults = { lazy = false },
    performance = {
        rtp = {
            disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
        },
    },
})

require("charan.lsp")
require("charan.theme").setup()
