if vim.g.did_load_lean_plugin then
  return
end
vim.g.did_load_lean_plugin = true

require('lean').setup {
  abbreviations = { enable = true },

  infoview = {
    autoopen = true,
    width = 50,
    split_direction = 'vertical',
  },
  lsp = { enabled = true },
}

local keymap = vim.keymap.set

keymap('n', '<leader>ll', '<cmd>LeanInfoviewToggle<CR>', { desc = '[l]ean toggle info [v]iew' })
keymap('n', '<leader>lp', '<cmd>LeanInfoviewPause<CR>', { desc = '[l]ean info view [p]ause' })
keymap('n', '<leader>lc', '<cmd>LeanInfoviewContinue<CR>', { desc = '[l]ean info view [c]ontinue' })
keymap('n', '<leader>ls', '<cmd>LeanSorry<CR>', { desc = '[l]ean add [s]orry' })
