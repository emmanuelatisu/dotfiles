-- Makes the build toolchain visible to Neovim.
--
-- nvim-treesitter's `main` branch needs a C compiler and the tree-sitter CLI
-- to build parsers, and checks for them early - during BufReadPost, via
-- nvim-ts-autotag. Both tools are installed on this machine, but neither is
-- on PATH by itself:
--
--   * mason only extends PATH once mason itself loads, which is later than
--     the requirement check.
--   * winget installs WinLibs (MinGW-w64 GCC) as a "portable" package and
--     creates no shim for gcc at all.
--
-- So this runs from init.lua before anything else, otherwise every file you
-- open greets you with "Unmet requirements for nvim-treesitter".

local sep = vim.fn.has("win32") == 1 and ";" or ":"

local function prepend_path(dir)
  if dir and vim.fn.isdirectory(dir) == 1 and not vim.env.PATH:find(dir, 1, true) then
    vim.env.PATH = dir .. sep .. vim.env.PATH
  end
end

-- The tree-sitter CLI, installed as a mason package.
prepend_path(vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin"))

-- MinGW-w64 GCC, wherever winget dropped it.
local pattern = vim.fs.joinpath(
  vim.env.LOCALAPPDATA or "",
  "Microsoft", "WinGet", "Packages", "*WinLibs*", "mingw64", "bin", "gcc.exe"
)
local gcc = vim.fn.glob(pattern, false, true)[1]
if gcc then
  prepend_path(vim.fs.dirname(gcc))
end

-- The tree-sitter CLI compiles with MSVC's cl.exe on Windows and will not go
-- looking for anything else. Pointing CC at gcc both redirects it and makes
-- it emit GCC-style flags, which gcc accepts in full.
--
-- zig deliberately is not an option here: `zig cc` rejects the host triple
-- the CLI hands it. Guides recommending zig describe the frozen `master`
-- branch, which did its own compiling.
if (vim.env.CC == nil or vim.env.CC == "") and vim.fn.executable("cl") == 0 then
  for _, cc in ipairs({ "gcc", "clang", "cc" }) do
    if vim.fn.executable(cc) == 1 then
      vim.env.CC = cc
      break
    end
  end
end
