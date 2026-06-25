-- pinned to master branch which still has the configs module
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "lua", "vim", "vimdoc", "query",
        "rust", "python", "java", "kotlin",
        "javascript", "typescript", "tsx", "html", "css",
        "json", "json5", "jsonc", "yaml", "toml",
        "bash", "dockerfile", "sql", "go", "c",
        "markdown", "markdown_inline", "regex",
    },
    auto_install = true,
    sync_install = false,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent    = { enable = true },
    textobjects = {
        select = {
            enable    = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
            },
        },
        move = {
            enable    = true,
            set_jumps = true,
            goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
        swap = {
            enable        = true,
            swap_next     = { ["<leader>sp"] = "@parameter.inner" },
            swap_previous = { ["<leader>sP"] = "@parameter.inner" },
        },
    },
})
