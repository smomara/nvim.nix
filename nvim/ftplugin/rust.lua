local rust_analyzer_cmd = 'rust-analyzer'

if vim.fn.executable(rust_analyzer_cmd) ~= 1 then
  vim.notify('rust-analyzer not found. Please install it.', vim.log.levels.WARN)
  return
end

local root_files = {
  'Cargo.toml',
  'rust-project.json',
  '.git',
}

vim.lsp.start({
  name = 'rust-analyzer',
  cmd = { rust_analyzer_cmd },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = 'clippy',
      },
      cargo = {
        allFeatures = true,
      },
      diagnostics = {
        enable = true,
        experimental = {
          enable = true,
        },
      },
      inlayHints = {
        enable = true,
      },
    },
  },
})
