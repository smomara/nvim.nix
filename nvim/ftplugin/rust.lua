local rust_analyzer_cmd = 'rust-analyzer'

if vim.fn.executable(rust_analyzer_cmd) ~= 1 then
  vim.notify('rust-analyzer not found. Please install it.', vim.log.levels.WARN)
  return
end

vim.lsp.start({
  name = 'rust-analyzer',
  cmd = { rust_analyzer_cmd },
  root_dir = vim.fs.dirname(vim.fs.find('Cargo.toml', { upward = true })[1]),
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
        refreshSupport = false,
      },
      inlayHints = {
        enable = true,
      },
    },
  },
})
