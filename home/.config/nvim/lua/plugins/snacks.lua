return {
  -- The explorer inherits `hidden = false` from snacks' files config, which
  -- hides every dotfile - including the chezmoi source files themselves.
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = { hidden = true },
        },
      },
    },
  },
}
