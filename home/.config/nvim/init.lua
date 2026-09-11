-- Put the parser build toolchain on PATH first; plugins check for it
-- during startup, before mason has had a chance to extend PATH itself.
require("config.toolchain")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
