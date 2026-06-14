# Chrnio's Neovim Configuration

<img width="1214" height="804" alt="neovim-default" src="https://github.com/user-attachments/assets/929358df-e175-45ce-a253-06b17376a18e" />

## Features
- Keyboard-first workflow with which-key popup for all bindings
- Full LSP for Rust, TypeScript, Go, Java, Python, LaTeX + 10 more languages
- Treesitter text objects, incremental selection, and syntax highlighting
- Fuzzy finding, live grep, and diagnostics via Telescope
- Git hunk staging, inline blame, and Lazygit integration
- Auto-format on save (rustfmt, clippy, biome, gofmt, google-java-format, black)
- Full DAP debugging for Rust, Go, Java, and TypeScript/Node
- 40+ colorschemes with live switching, persistence, and all italics disabled
- Powerline bufferline and statusline with per-colorscheme highlight sync
- nvim-tree sidebar + Oil filesystem buffer editor
- Code folding via LSP/treesitter with peek-fold on `K`
- Surround, autopairs, mini.move, smear cursor, indent guides, todo highlights
- LaTeX build-on-save with Okular forward search via vimtex + texlab
- Python venv auto-detection per project

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
