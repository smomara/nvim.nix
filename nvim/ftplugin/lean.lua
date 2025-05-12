vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.expandtab = true

local root_files = {
  'lakefile.lean',
  'lean-toolchain',
  'leanpkg.toml',
  '.git',
}

local root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1])
local lean_cmd = vim.fn.exepath('lean')
if lean_cmd ~= '' then
  vim.lsp.start {
    name = 'lean',
    cmd = { lean_cmd, '--server' },
    root_dir = root_dir,
    capabilities = require('user.lsp').make_client_capabilities(),
  }
else
  vim.notify('Lean executable not found in path. LSP features unavailable.', vim.log.levels.WARN)
end
