-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.dracula-nvim" },
  { import = "astrocommunity.colorscheme.rose-pine" },
  { import = "astrocommunity.colorscheme.github-nvim-theme" },
  { import = "astrocommunity.scrolling.vim-smoothie" },
  { import = "astrocommunity.code-runner.vim-slime" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
  { import = "astrocommunity.bars-and-lines.feline-nvim" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.diagnostics.tiny-inline-diagnostic-nvim" },
  { import = "astrocommunity.recipes.vscode-icons" },
  { import = "astrocommunity.editing-support.multicursors-nvim" },
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.test.nvim-coverage" },
  { import = "astrocommunity.test.vim-test" },
  {
    "vim-test/vim-test",
    config = function() vim.g["test#python#runner"] = "pytest" end,
  },
}
