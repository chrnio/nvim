# Chrnio's Neovim Configuration

<img width="1214" height="804" alt="neovim-default" src="https://github.com/user-attachments/assets/929358df-e175-45ce-a253-06b17376a18e" />

## Features
- Keyboard-first with which-key popup
- LSP for Rust, TypeScript, Go, Java, Python, LaTeX + more
- Treesitter highlighting, text objects, incremental selection
- Telescope fuzzy finding, live grep, diagnostics
- Git hunks, inline blame, Lazygit
- Auto-format on save for all languages
- DAP debugging for Rust, Go, Java, TypeScript
- 40+ colorschemes, live switching, no italics
- Powerline bufferline + statusline
- nvim-tree + Oil file explorer
- LSP/treesitter folding with peek-fold
- Surround, autopairs, move, smear cursor, todo highlights
- LaTeX build-on-save + Okular forward search
- Python venv auto-detection

## Dependencies
- Neovim >= 0.10
-  A Nerd font like `JetBrainsMono`
- `git`, `make`, `gcc` or `clang`
- `ripgrep` and `fd` 
- `node`, `python3`, `cargo`, `go`, `java 17+` (Mason language servers)
- `latexmk` + a TeX distribution
- `lazygit` (optional, `<leader>gg`)
- `lldb-dap` or `codelldb` (optional, Rust/C debugging)

## Installation

```sh
mv ~/.config/nvim ~/.config/nvim.bak
cp -r nvim ~/.config/nvim
nvim
```
That's it. 
