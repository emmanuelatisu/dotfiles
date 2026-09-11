-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- YAML editing fix. This is the one thing from the previous hand-written
-- config that LazyVim does not already cover, because it is an editing
-- behaviour rather than an LSP setting: with the default `indentkeys`, typing
-- a comment or a `key:` line in YAML yanks it back to column 0 as you type.
-- (yamlls itself, schemas and keyOrdering=false all come from the lang.yaml
-- extra, whose config is better than what I had written by hand.)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_yaml_indent", { clear = true }),
  pattern = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  callback = function()
    vim.opt_local.indentkeys:remove("0#")
    vim.opt_local.indentkeys:remove("<:>")
  end,
})
