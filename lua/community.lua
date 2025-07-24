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
  { import = "astrocommunity.editing-support.yanky-nvim" },
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
          prefix = ">",
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
  },
  	{
		-- bridges the gap between mason and lspconfig
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local lsp_config = require("lspconfig")
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- dart sdk ships with LSP
					"astro",
					"tailwindcss",
					"ts_ls",
					"lua_ls",
				},
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>dl", vim.diagnostic.setqflist)

			vim.keymap.set({ "n", "i" }, "<C-b>", function()
				vim.lsp.inlay_hint(0, nil)
			end)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				end,
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = false,
			})

			local dartExcludedFolders = {
				vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
				vim.fn.expand("$HOME/.pub-cache"),
				vim.fn.expand("/opt/homebrew/"),
				vim.fn.expand("$HOME/tools/flutter/"),
			}

			lsp_config["dartls"].setup({
				capabilities = capabilities,
				cmd = {
					"dart",
					"language-server",
					"--protocol=lsp",
					-- "--port=8123",
					-- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
				},
				filetypes = { "dart" },
				init_options = {
					onlyAnalyzeProjectsWithOpenFiles = false,
					suggestFromUnimportedLibraries = true,
					closingLabels = true,
					outline = false,
					flutterOutline = false,
				},
				settings = {
					dart = {
						analysisExcludedFolders = dartExcludedFolders,
						updateImportsOnRename = true,
						completeFunctionCalls = true,
						showTodos = true,
					},
				},
			})

			lsp_config.astro.setup({
				capabilities = capabilities,
			})

			lsp_config.tailwindcss.setup({
				capabilities = capabilities,
			})

			lsp_config.ts_ls.setup({
				capabilities = capabilities,
			})

			lsp_config.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
            -- runtime = {
            --   version = "LuaJIT",
            -- },
						diagnostics = {
							globals = { "vim" },
						},
            -- workspace = {
            --   checkThirdParty = false,
            --   library = {
            --     '${3rd}/luv/library',
            --     unpack(vim.api.nvim_get_runtime_rile("", true)),
            --     vim.api.nvim_get_proc,
            --   }
            -- },
					},
				},
			})

			-- Tooltip for the lsp in bottom right
			require("fidget").setup({})

			-- Hot reload :)
			require("dart-tools")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",

			{ "j-hui/fidget.nvim", tag = "legacy" },
			-- support for dart hot reload on save
			"RobertBrunhage/dart-tools.nvim",
		},
	},
}
