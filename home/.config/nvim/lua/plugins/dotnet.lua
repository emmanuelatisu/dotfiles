-- C# for LazyVim.
--
-- LazyVim ships a `lang.dotnet` extra, and it is deliberately not enabled:
-- it configures OmniSharp, which Microsoft discontinued and which does not
-- understand modern C#. Everything below replaces it.
--
-- Enabling that extra later (via :LazyExtras) would start a second, worse
-- language server alongside this one. Don't.

return {
  --------------------------------------------------------------------------
  -- Mason needs an extra registry to see the Roslyn server
  --------------------------------------------------------------------------
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        -- The official registry's Roslyn package lags badly. This one tracks
        -- it and updates several times a week.
        "github:Crashdummyy/mason-registry",
      },
    },
  },

  --------------------------------------------------------------------------
  -- Parsers LazyVim's default list doesn't include
  --------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c_sharp", "xml" } },
  },

  --------------------------------------------------------------------------
  -- The language server
  --------------------------------------------------------------------------
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- Let the server watch files itself. Neovim's watcher struggles with
      -- the file count of a 20+ project solution on Windows.
      filewatching = "roslyn",
      -- Also search child directories for the solution, so opening Neovim at
      -- the repo root still finds a solution that lives in src/.
      broad_search = true,
      -- Stay on the solution chosen at first attach instead of re-resolving
      -- per buffer; on a large solution re-resolving means a full reload.
      -- Switch deliberately with :Roslyn target.
      lock_target = true,
    },
    init = function()
      -- Registered in `init` so it is in place before the client ever starts.
      -- Successive vim.lsp.config calls merge, so this sits alongside the
      -- cmd/filetypes that roslyn.nvim itself supplies.
      vim.lsp.config("roslyn", {
        settings = {
          ["csharp|background_analysis"] = {
            -- The large-solution setting. The default analyses every project
            -- continuously; "openFiles" limits that to what you have open.
            -- Solution-wide errors still reach you from a build.
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
          },
          ["csharp|code_lens"] = {
            -- A reference count above every member costs a solution-wide
            -- find-references per symbol. First thing to turn off at scale.
            dotnet_enable_references_code_lens = false,
            dotnet_enable_tests_code_lens = true,
          },
          ["csharp|completion"] = {
            -- Completes types you have not imported yet and adds the using.
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
            dotnet_provide_regex_completions = true,
          },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          },
          ["csharp|symbol_search"] = {
            -- Lets go-to-definition step into framework and NuGet types.
            dotnet_search_reference_assemblies = true,
          },
          ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
          },
        },
      })
    end,
    keys = {
      { "<leader>mp", "<cmd>Roslyn target<CR>", desc = "Pick solution (Roslyn)" },
    },
  },

  --------------------------------------------------------------------------
  -- Label the group so `<leader>m` shows a heading in which-key
  --------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>m", group = "dotnet", icon = { icon = "#", color = "purple" } },
      },
    },
  },

  --------------------------------------------------------------------------
  -- Build, run, test, NuGet, secrets, EF - everything the LSP doesn't do.
  -- This is what stands in for Solution Explorer and the toolbar.
  --------------------------------------------------------------------------
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "folke/snacks.nvim",
    },
    ft = { "cs", "fsharp", "xml" },
    cmd = "Dotnet",
    opts = {
      -- LazyVim's default picker, so this matches the rest of the UI.
      picker = "snacks",
      -- roslyn.nvim owns the language server. easy-dotnet ships LSP helpers
      -- too, but running both risks two clients on one solution.
      lsp = { enabled = false },
      debugger = {
        engine = "netcoredbg",
        console = "integratedTerminal",
        -- Registers the dap adapter and launch configs itself, including the
        -- "which project am I debugging" picker.
        auto_register_dap = true,
      },
      test_runner = {
        viewmode = "float",
        -- Opening the runner is an explicit act, not a side effect of
        -- touching a test file.
        auto_start_testrunner = false,
      },
    },
    -- Everything lives under <leader>m, which LazyVim leaves free. NOT
    -- <leader>d: that is LazyVim's debug group and dap.core already owns
    -- db, dc, dr, ds, dt, dw and most of the rest of that prefix.
    keys = {
      { "<leader>mb", "<cmd>Dotnet build<CR>", desc = "Build project" },
      { "<leader>mB", "<cmd>Dotnet build solution<CR>", desc = "Build solution" },
      { "<leader>mr", "<cmd>Dotnet run<CR>", desc = "Run" },
      { "<leader>mw", "<cmd>Dotnet watch<CR>", desc = "Watch" },
      { "<leader>mt", "<cmd>Dotnet testrunner<CR>", desc = "Test runner" },
      { "<leader>mT", "<cmd>Dotnet test solution<CR>", desc = "Test solution" },
      { "<leader>mg", "<cmd>Dotnet debug<CR>", desc = "Debug project" },
      { "<leader>mn", "<cmd>Dotnet new<CR>", desc = "New project/file" },
      { "<leader>ma", "<cmd>Dotnet add package<CR>", desc = "Add NuGet package" },
      { "<leader>mo", "<cmd>Dotnet outdated<CR>", desc = "Outdated packages" },
      { "<leader>ms", "<cmd>Dotnet secrets<CR>", desc = "User secrets" },
      { "<leader>md", "<cmd>Dotnet diagnostic<CR>", desc = "Solution diagnostics" },
      { "<leader>mS", "<cmd>Dotnet solution select<CR>", desc = "Select solution" },
    },
  },
}
