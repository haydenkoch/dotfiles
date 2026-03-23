-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- System clipboard (yank → tmux → macOS clipboard)
opt.clipboard = "unnamedplus"

-- Keep context around cursor
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Faster CursorHold events (LSP diagnostics, etc.)
opt.updatetime = 200

-- True color (LazyVim sets this, explicit for tmux interop)
opt.termguicolors = true
