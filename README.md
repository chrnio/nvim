# nvim config

Backend-focused Neovim config for Rust, Java Spring Boot, Python, JS/TS, Docker/K8s. Built on Lazy.nvim, native LSP (Neovim 0.11+), nvim-dap, and Telescope.

---

## Install

```bash
# Backup existing config first
mv ~/.config/nvim ~/.config/nvim.bak

# Drop this directory at
~/.config/nvim/
```

**External tools** (install via your package manager or Mason `:MasonInstall`):

| Tool | Purpose |
|------|---------|
| `rust-analyzer` | Rust LSP (install via rustup) |
| `jdtls` | Java LSP (Mason: `:MasonInstall jdtls`) |
| `codelldb` | Rust/C debugger (Mason) |
| `debugpy` | Python debugger (Mason) |
| `js-debug-adapter` | JS/TS debugger (Mason) |
| `java-debug-adapter` | Java DAP (Mason) |
| `java-test` | Java test runner (Mason) |
| `ripgrep` | Telescope live grep |
| `lazygit` | Git TUI |

---

## Theme Switcher

Themes persist across sessions — no file edits needed.

| Key | Action |
|-----|--------|
| `<leader>th` | Open theme picker |

Available themes: `catppuccin-mocha` (default), `moonfly`, `kola-dark`, `gruvbox-material`, `onedark` (darker), `cyberdream`, `eldritch` (darker), `nordic`, `solarized-osaka`, `tokyonight`.

Background and opacity come from the terminal emulator. All italics disabled except comments.

---

## Keybinds

`<leader>` = `Space`

### Navigation

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between windows (works in terminal too) |
| `<C-Up/Down>` | Resize window height |
| `<C-Left/Right>` | Resize window width |
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `Q` | Delete buffer |

### Editing

| Key | Action |
|-----|--------|
| `<C-s>` | Save file (normal / insert / visual) |
| `<A-j/k>` | Move line/selection up or down |
| `< / >` | Indent/dedent, keep visual selection |
| `J` | Join lines, keep cursor position |
| `x` | Delete char without yanking |
| `p / P` (visual) | Paste without clobbering unnamed register |
| `Y` (normal) | Yank `file:line` to clipboard |
| `Y` (visual) | Yank `file:line_start-line_end` to clipboard |
| `<Esc>` | Clear search highlight |

### Motions

| Key | Action |
|-----|--------|
| `s` | Flash jump (forward) |
| `S` | Flash treesitter jump |
| `]f / [f` | Next / prev function start |
| `]F / [F` | Next / prev function end |
| `]c / [c` | Next / prev class start |
| `]C / [C` | Next / prev class end |

**Treesitter text objects** (works with `d`, `y`, `v`, `c`):

| Object | Selects |
|--------|---------|
| `af / if` | Around / inside function |
| `ac / ic` | Around / inside class |
| `aa / ia` | Around / inside parameter |

### File Explorer (Oil)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle Oil (current dir) |
| `<leader>E` | Open Oil in floating window |
| `<CR>` | Open file/dir |
| `-` | Go to parent dir |

### Telescope (Find)

| Key | Action |
|-----|--------|
| `<leader><space>` | Find files |
| `<leader>/` | Live grep |
| `<leader>?` | Recent files |
| `<leader>,` | Open buffers |
| `<leader>fw` | Fuzzy search in current buffer |
| `<leader>fk` | Keymaps |
| `<leader>fh` | Help tags |
| `<leader>fd` | Diagnostics (current file) |
| `<leader>fD` | Diagnostics (all) |
| `<leader>fr` | Registers |
| `<leader>ft` | TODO comments |
| `<leader>fg` | Git commits |
| `<leader>fb` | Git branches |
| `<leader>fs` | Git status |

Inside Telescope: `<C-j/k>` move selection, `<C-q>` send to quickfix, `<Esc>` close.

### LSP / Code

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `gi` | Implementations |
| `gt` | Type definition |
| `K` | Hover docs |
| `<C-\>` | Signature help (normal + insert) |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>cf` | Format buffer |
| `<leader>cF` | Toggle format-on-save |
| `<leader>cd` | Diagnostics float |
| `<leader>cl` | Toggle virtual lines (inline diagnostics) |
| `<leader>ci` | Toggle inlay hints |
| `<leader>cs` | Document symbols |
| `<leader>cS` | Workspace symbols |
| `]d / [d` | Next / prev diagnostic |
| `]e / [e` | Next / prev error |

### Quickfix

| Key | Action |
|-----|--------|
| `]q / [q` | Next / prev quickfix item |
| `]Q / [Q` | Last / first quickfix item |

### Git (Gitsigns)

| Key | Action |
|-----|--------|
| `]h / [h` | Next / prev hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gs` (visual) | Stage selected lines |
| `<leader>gr` (visual) | Reset selected lines |
| `<leader>gS` | Stage buffer |
| `<leader>gR` | Reset buffer |
| `<leader>gu` | Undo stage hunk |
| `<leader>gb` | Blame line (full) |
| `<leader>gB` | Toggle inline blame |
| `<leader>gd` | Diff this |
| `<leader>gg` | LazyGit |

### Debug (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Continue / start |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dL` | Log point |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluate expression (normal + visual) |
| `<leader>dr` | Open REPL |
| `<leader>dl` | Run last |
| `<leader>dx` | Terminate session |

DAP UI opens/closes automatically on session start/end. Variable values shown inline via virtual text.

### Rust (rustaceanvim)

| Key | Action |
|-----|--------|
| `<leader>rr` | Runnables |
| `<leader>rd` | Debuggables |
| `<leader>re` | Explain error |
| `<leader>rm` | Expand macro |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rp` | Parent module |
| `<leader>rj` | Join lines (smart) |
| `<leader>cu` | Upgrade all crates |
| `<leader>co` | Crate info popup |

Clippy runs on save. rust-analyzer manages its own LSP — do not install `rust_analyzer` via Mason.

### Java (nvim-jdtls)

These keymaps are active only in Java buffers.

| Key | Action |
|-----|--------|
| `<leader>Jo` | Organize imports |
| `<leader>Jv` | Extract variable |
| `<leader>Jc` | Extract constant |
| `<leader>Jm` (visual) | Extract method |
| `<leader>Jt` | Run nearest test |
| `<leader>JT` | Run class tests |

Spring Boot: install `vscode-spring-boot` extension, jdtls picks it up automatically.  
DAP requires `java-debug-adapter` and `java-test` installed via Mason.

### Python

| Key | Action |
|-----|--------|
| `<leader>pv` | Select virtual environment |

Debugpy is used for DAP. Respects `$VIRTUAL_ENV` automatically.

### Terminal

| Key | Action |
|-----|--------|
| `<leader>tt` | Terminal in horizontal split |
| `<leader>tv` | Terminal in vertical split |
| `<Esc>` | Exit terminal mode to normal mode |

### Misc

| Key | Action |
|-----|--------|
| `<leader>l` | Open Lazy plugin manager |
| `<leader>n` | Toggle centered layout (NoNeckPain) |
| `<leader>ih` | Inspect highlight group under cursor |
| `<leader>sp` | Swap parameter with next (treesitter) |
| `<leader>sP` | Swap parameter with previous (treesitter) |

---

## LSP Servers

Managed by Mason + mason-lspconfig. Auto-installed on first launch.

| Server | Language |
|--------|---------|
| `lua_ls` | Lua |
| `pyright` | Python |
| `ts_ls` | TypeScript / JavaScript |
| `eslint` | JS/TS linting |
| `jsonls` | JSON |
| `yamlls` | YAML (with Compose/GitHub Actions schemas) |
| `dockerls` | Dockerfile |
| `docker_compose_language_service` | Docker Compose |
| `bashls` | Bash / Shell |
| `html` | HTML |
| `cssls` | CSS |
| `taplo` | TOML |
| `lemminx` | XML (Maven pom.xml) |
| `helm_ls` | Helm charts |
| `rust_analyzer` | Rust (via rustaceanvim, not Mason) |
| `jdtls` | Java (via nvim-jdtls ftplugin) |

---

## File Structure

```
~/.config/nvim/
├── init.lua
├── after/
│   └── ftplugin/
│       └── java.lua          -- jdtls startup
└── lua/charan/
    ├── options.lua
    ├── lazy.lua               -- plugin specs
    ├── keymaps.lua
    ├── theme.lua              -- theme switcher + persistence
    ├── lsp/
    │   └── init.lua           -- LSP configs + diagnostics
    ├── dap/
    │   └── init.lua           -- DAP adapters + dapui setup
    └── ui/
        ├── lualine.lua
        ├── telescope.lua
        └── treesitter.lua
```

---

## Plugin List

| Plugin | Role |
|--------|------|
| lazy.nvim | Plugin manager |
| lualine.nvim | Statusline |
| telescope.nvim | Fuzzy finder |
| nvim-treesitter | Syntax + text objects |
| nvim-lspconfig | LSP client configs |
| mason.nvim | Tool installer |
| mason-lspconfig | Mason ↔ LSP bridge |
| rustaceanvim | Rust LSP + DAP |
| nvim-jdtls | Java LSP + DAP |
| nvim-dap + dap-ui | Debugger |
| nvim-dap-virtual-text | Inline debug values |
| mason-nvim-dap | DAP adapter installer |
| gitsigns.nvim | Git hunk signs + actions |
| lazygit.nvim | LazyGit integration |
| oil.nvim | File explorer |
| leap / flash | Fast motion |
| nvim-surround | Surround text objects |
| nvim-autopairs | Auto-close brackets |
| Comment.nvim | Toggle comments |
| indent-blankline | Indent guides |
| which-key.nvim | Keymap hints |
| crates.nvim | Cargo.toml helper |
| venv-selector | Python venv picker |
| todo-comments | TODO/FIXME highlights |
| no-neck-pain | Centered layout |
| lazydev.nvim | Lua API completion |
| tmux.nvim | Tmux pane nav |
