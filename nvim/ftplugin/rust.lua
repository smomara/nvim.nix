local rust_analyzer_cmd = 'rust-analyzer'

if vim.fn.executable(rust_analyzer_cmd) ~= 1 then
  vim.notify('rust-analyzer not found. Please install it.', vim.log.levels.WARN)
  return
end

-- Ignore -32802 (server canceled the request) errors for diagnostics
for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
      return -- Ignore the error
    end
    return default_diagnostic_handler(err, result, context, config)
  end
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
