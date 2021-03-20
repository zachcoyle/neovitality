require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = {},
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldlevel=10]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
