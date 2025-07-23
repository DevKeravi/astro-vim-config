-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.dracula-nvim" },
  { import = "astrocommunity.colorscheme.rose-pine" },
  { import = "astrocommunity.scrolling.vim-smoothie" },
  { import = "astrocommunity.code-runner.vim-slime" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.diagnostics.tiny-inline-diagnostic-nvim" },
  { import = "astrocommunity.recipes.vscode-icons" },
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.test.nvim-coverage" },
  { import = "astrocommunity.test.vim-test" },
  { import = "astrocommunity.note-taking.neorg" },
  { import = "astrocommunity.completion.avante-nvim" },
  {
    "vim-test/vim-test",
    config = function() vim.g["test#python#runner"] = "pytest" end,
  },
  {
  "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup()
    end
  },
  {
  'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
        config = function()
      require("flutter-tools").setup {
        ui = {
          border = "rounded",
          notification_style = "nvim-notify",
        },
        decorations = {
          statusline = {
            app_version = false,
            device = true,
          }
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
          register_configurations = function(paths)
            require("dap").configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch flutter",
                dartSdkPath = paths.dart_sdk,
                flutterSdkPath = paths.flutter_sdk,
                program = "/Users/demian/workspace/safetysnap/safetysnap-app/lib/main.dart",
                cwd = "/Users/demian/workspace/safetysnap/safetysnap-app/",
              }
            }
          end,
        },
        flutter_path = "/Users/demian/workspace/flutter/bin/flutter",
        fvm = false, -- FVM 사용시 true로 변경
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          highlight = "ErrorMsg",
          prefix = "//",
          enabled = true
        },
        dev_log = {
          enabled = true,
          open_cmd = "tabedit",
        },
        lsp = {
          color = {
            enabled = true,
            background = false,
            virtual_text = true,
            virtual_text_str = "■",
          },
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = {
              vim.fn.expand("/Users/demian/.pub-cache"),
            },
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
          }
        }
      }
    end,
  },
  {
  "akinsho/pubspec-assist.nvim",
    ft = "yaml",
    event = "BufEnter pubspec.yaml",
    config = function()
      require("pubspec-assist").setup()
    end,
  }
}
