-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- jj leaves insert mode, so escaping costs no finger travel.
--
-- The one cost: after typing a single `j`, Neovim waits `timeoutlen` (300ms
-- under LazyVim) to see whether a second `j` follows. You only notice it if
-- you pause immediately after a j - typing "json" at speed is unaffected,
-- because the `o` resolves the ambiguity instantly.
vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode" })
